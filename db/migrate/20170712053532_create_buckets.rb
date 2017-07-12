class CreateBuckets < ActiveRecord::Migration[5.0]
  def change
    create_table :buckets do |t|
      t.text :content
      t.boolean :is_accomplished
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :buckets, [:user_id, :created_at]
  end
end
