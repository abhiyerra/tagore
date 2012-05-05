class MysqlResource < Resource

  def self.provision!(params)
    resource = self.create(params)

    db_name = "#{resource.service.name}_#{resource.id}_production"

    db_machines = Machine.where(:tag => "mysql")
    machine = db_machines[db_name.hash.abs % db_machines.length]

    resource.machine_id = machine.id

    # TODO: Need to grant privileges to a user. We don't want to just
    # give root access to this.
    # system %{
    #   ssh #{machine.ip_address} mysqladmin -u root create #{db_name}
    # }

    system %{
      mysqladmin -u root create #{db_name}
    }

    resource.data = {
      :database => db_name,
      :user     => "root",
      :password => "",
    }

    resource.save!
  end
end
