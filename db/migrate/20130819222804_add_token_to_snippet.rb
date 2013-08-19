class AddTokenToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :token, :string
  end
end
