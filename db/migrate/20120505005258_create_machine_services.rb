class CreateMachineServices < ActiveRecord::Migration
  def change
    create_table :machine_services do |t|
      t.integer :machine_id
      t.integer :service_id

      t.integer :port
      t.integer :pid

      t.timestamps
    end
  end
end
