module PeopleHelper
  def school
    School.find(@person.school_id)
  end
end
