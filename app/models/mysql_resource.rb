class DatabaseResource < Resource

  DATABASE_MACHINES = [
    'localhost'
  ]

  def provision
    db_name = "#{self.service.name}_#{self.id}_production"
    machine = DATABASE_MACHINES[db_name.hash.abs % DATABASE_MACHINES.length]

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
  end
end
