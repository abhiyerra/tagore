class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :type
      t.text :data

      t.timestamps
    end
  end
end
