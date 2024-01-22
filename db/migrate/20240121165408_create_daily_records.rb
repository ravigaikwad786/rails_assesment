class CreateDailyRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_records, id: :uuid do |t|
      t.date :date
      t.integer :male_count
      t.integer :female_count
      t.float :male_avg_age
      t.float :female_avg_age

      t.timestamps
    end
  end
end
