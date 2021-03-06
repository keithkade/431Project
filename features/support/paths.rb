# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the student home\s?page$/
      '/home'

    when /^the student problems\s?page$/
      '/problems'

    when /^the student quizzes\s?page$/
      '/quizzes'

    when /^the admin courses\s?page$/
      '/admin/courses'

    when /^the problems\s?page$/
      '/admin/problems'

    when /^the admin quizzes\s?page$/
      '/admin/quizzes'

    when /^the admin quiz page for "(.*)"$/
      title = $1
      quiz = Quiz.all.find_by(title: title)
      "/admin/quizzes/#{quiz.id}"

    when /^the student problem page for "(.*)"$/
      title = $1
      problem = Problem.all.find_by(title: title)
      "/problems/#{problem.id}"

    when /^the problem page for "(.*)"$/
      title = $1
      problem = Problem.all.find_by(title: title)
      "/admin/problems/#{problem.id}"

    when /^the courses\s?page$/
      '/admin/courses'
 
    when /^the course page for "(.*)"$/
      name = $1
      course = Course.all.find_by(name: name)
      "/admin/courses/#{course.id}"
    
    when /^the student\s?page$/
      '/admin/students'

    when /^the students page$/
      '/admin/students'

    when /^the student page for "(.*)"$/
      name = $1
      student = Student.all.find_by(FirstName: name)
      "/admin/students/#{student.id}"

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
