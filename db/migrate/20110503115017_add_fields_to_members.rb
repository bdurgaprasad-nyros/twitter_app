class AddFieldsToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :friends_count, :integer
    add_column :members, :followers_count, :integer
    add_column :members, :statuses_count, :integer
  end

  def self.down
    remove_column :members, :statuses_count
    remove_column :members, :followers_count
    remove_column :members, :friends_count
  end
end
