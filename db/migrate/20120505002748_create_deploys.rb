class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|
      t.integer :service_id
      t.string :commit

      t.timestamps
    end
  end
end
