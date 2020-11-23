class CreatePublications < ActiveRecord::Migration[6.0]
  def change
    create_table :publications do |t|
      t.string :title
      t.string :published_at
      t.string :abstract

      t.timestamps
    end
  end
end
