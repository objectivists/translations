class CreateTranslations < ActiveRecord::Migration[5.0]
  def change
    create_table :translations do |t|
      t.belongs_to :book, foreign_key: true
      t.belongs_to :language, foreign_key: true
      t.string :title
      t.string :cover_image_url
      t.string :publisher
      t.string :translator
      t.string :isbn_13
      t.string :isbn_10

      t.timestamps
    end
  end
end
