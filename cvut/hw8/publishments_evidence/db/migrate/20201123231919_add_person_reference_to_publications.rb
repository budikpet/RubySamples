class AddPersonReferenceToPublications < ActiveRecord::Migration[6.0]
  def change
    add_reference :publications, :person
  end
end
