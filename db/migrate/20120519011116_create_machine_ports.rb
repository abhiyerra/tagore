class CreateMachinePorts < ActiveRecord::Migration
  def change
    create_table :machine_ports do |t|
      t.integer :machine_id
      t.integer :service_id

      t.integer :port

      t.timestamps
    end
  end
end
