class Problem < ActiveRecord::Base
    def courses
        tuples = CourseProblemRelation.where(:problem => id)
        Course.where(:id => tuples.map(&:course))
    end
end
