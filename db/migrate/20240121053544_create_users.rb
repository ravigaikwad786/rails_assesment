class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :gender
      t.jsonb :name
      t.integer :age
      t.jsonb :location

      t.timestamps
    end
  end
end
