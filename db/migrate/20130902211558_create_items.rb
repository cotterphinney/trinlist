class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
