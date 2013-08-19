class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :text
      t.boolean :secret, :default => false

      t.timestamps
    end
  end
end
