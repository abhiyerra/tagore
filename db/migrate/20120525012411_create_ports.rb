class CreatePorts < ActiveRecord::Migration
  def change
    create_table :ports do |t|
      t.integer :machine_id
      t.integer :service_id

      t.integer :port

      t.timestamps
    end
  end
end
