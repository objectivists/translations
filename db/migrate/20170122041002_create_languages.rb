class CreateLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :local_name
      t.string :slug

      t.timestamps
    end
  end
end
