class ChangePosts < ActiveRecord::Migration
  def change
    remove_column :posts, :url, :string
    add_column :posts, :url, :string
  end
end
