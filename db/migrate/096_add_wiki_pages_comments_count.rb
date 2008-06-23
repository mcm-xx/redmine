class AddWikiPagesCommentsCount < ActiveRecord::Migration
  def self.up
    add_column :wiki_pages, :comments_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :wiki_pages, :comments_count
  end
end
