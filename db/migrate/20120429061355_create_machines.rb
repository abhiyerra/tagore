class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :type
      t.string :tag

      t.text :data

      t.timestamps
    end
  end
end
