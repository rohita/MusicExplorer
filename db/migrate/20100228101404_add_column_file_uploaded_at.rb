class AddColumnFileUploadedAt < ActiveRecord::Migration
  def self.up
    add_column :users, :file_uploaded_at, :datetime
  end

  def self.down
    remove_column :users, :file_uploaded_at
  end
end
