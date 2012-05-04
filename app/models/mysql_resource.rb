class MysqlResource < Resource

  def provision!
    db_name = "#{self.service.name}_#{self.id}_production"

    db_machines = Machine.where(:tag => "mysql")
    machine = db_machines[db_name.hash.abs % database_machines.length]

    self.machine_id = machine.id

    # TODO: Need to grant privileges to a user. We don't want to just
    # give root access to this.
    system %{
      ssh #{machine} mysql -u root <<END
        create database #{db_name}
      END
    }

    self.data = {
      :database => db_name,
      :user => "root",
      :password => "",
    }

    self.save!
  end
end
