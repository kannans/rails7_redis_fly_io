class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.string :title
      t.string :url
      t.string :technologies
      t.text :details
      t.string :image

      t.timestamps
    end
  end
end
