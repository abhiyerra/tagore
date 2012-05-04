class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description

      t.string :repo

      t.string :state
      t.string :stack

      t.timestamps
    end
  end
end
