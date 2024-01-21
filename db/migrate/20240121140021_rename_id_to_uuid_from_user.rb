class RenameIdToUuidFromUser < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :id, :uuid
  end
end
