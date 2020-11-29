class CreatePublications < ActiveRecord::Migration[6.0]
  def change
    create_table :publications do |t|
      t.belongs_to :person, index: { unique: false }, foreign_key: true
      t.string :title
      t.string :published_at
      t.string :abstract
      t.boolean :published

      t.timestamps
    end
  end
end
