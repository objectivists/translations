class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :cover_image_url
      t.string :author
      t.string :slug

      t.timestamps
    end
  end
end
