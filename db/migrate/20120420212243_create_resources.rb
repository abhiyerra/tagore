class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :type
      t.integer :service_id
      t.text :data

      t.integer :machine_id

      t.timestamps
    end
  end
end
