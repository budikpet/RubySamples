class AddSchoolReferenceToPeople < ActiveRecord::Migration[6.0]
  def change
    add_reference :people, :school
  end
end
