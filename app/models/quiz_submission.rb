class QuizSubmission < ActiveRecord::Base
  before_destroy :destroy_dependents
  
  def student
    Student.find_by_id(self.studentid)
  end
  
  def quiz
    Quiz.find_by_id(self.quizid)
  end
  
  def answers
    QuizStudentAnswer.where(:submissionid => self.id)
  end
  
  def graded?
    answers = QuizStudentAnswer.where(:submissionid => self.id)
    answers.all? { |answer| answer.graded? }
  end
  
  def points
    total = 0
    answers.each do |answer|
      if answer.graded?
        total += answer.points
      end
    end
    total
  end
  
# View stuff
  def raw_score
    "#{self.points} / #{quiz.points_possible}"
  end
  
  def score
    if quiz.points_possible !=0
      return 100 * self.points / quiz.points_possible
    else
      return 100
    end
  end
  
private
  def destroy_dependents
    QuizStudentAnswer.where(:submissionid => self.id).each { |s| s.destroy }
  end
end
