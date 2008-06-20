class AddWikiPagesDisplayInToc < ActiveRecord::Migration
  def self.up
    add_column :wiki_pages, :display_in_toc, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :wiki_pages, :display_in_toc
  end
end
