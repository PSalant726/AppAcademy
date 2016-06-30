class RemoveUniquenessUserId < ActiveRecord::Migration
  def change
    remove_index :shortened_urls, :user_id
    add_index :shortened_urls, :user_id
    add_index :shortened_urls, :short_url, unique: true
  end
end
