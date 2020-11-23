class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :full_name
      t.string :email
      t.string :username

      t.timestamps
    end
  end
end
