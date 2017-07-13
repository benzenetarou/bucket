class AddCommentToBuckets < ActiveRecord::Migration[5.0]
  def change
    add_column :buckets, :comment, :string
  end
end
