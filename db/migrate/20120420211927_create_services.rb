class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.string :subdomain

      t.string :repo

      t.string :type

      t.timestamps
    end
  end
end
