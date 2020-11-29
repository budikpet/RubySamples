module PublicationsHelper
  def author
    Person.find(@publication.person_id)
  end
end
