class CreateProvisions < ActiveRecord::Migration
  def change
    create_table :provisions do |t|
      t.integer :machine_id
      t.integer :service_id
      t.integer :start_port

      t.timestamps
    end
  end
end
