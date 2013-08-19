class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :text
      t.boolean :secret

      t.timestamps
    end
  end
end
