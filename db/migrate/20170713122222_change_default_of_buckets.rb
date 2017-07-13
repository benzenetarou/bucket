class ChangeDefaultOfBuckets < ActiveRecord::Migration[5.0]
  def change
    change_column :buckets, :is_accomplished, :boolean, :default => false
  end
end
