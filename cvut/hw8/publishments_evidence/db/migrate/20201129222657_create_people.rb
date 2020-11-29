class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.belongs_to :school, index: { unique: false }, foreign_key: true
      t.string :full_name
      t.string :email
      t.string :username

      t.timestamps
    end
  end
end
