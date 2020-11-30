module PeopleHelper
  def school
    School.find(@person.school_id)
  end

  def linked_publications
    Publication.all.select { |publication| Person.find(publication.person_id).username == @person.username }
  end
end
