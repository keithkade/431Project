class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @courses = @student.courses
  end

  # GET /students/new
  def new
    @student = Student.new
    @courses = Course.all
    rels = CourseUserRelation.where(:user => @student.id)
    @rels = Hash.new(false)
    rels.each do |rel|
      @rels[rel.course] = true
    end
  end

  # GET /students/1/edit
  def edit
    @courses = Course.all
    rels = CourseUserRelation.where(:user => @student.id)
    @rels = Hash.new(false)
    rels.each do |rel|
      @rels[rel.course] = true
    end
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    relate_with_courses

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    relate_with_courses
    
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    CourseUserRelation.destroy_by_user(@student.id)
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:Name, :ID, :UserName, :Password, :Class)
    end
    
    def relate_with_courses
    # Extremely lazy way of doing things.  Just erase all and rewrite them.  At least it works.
      CourseUserRelation.destroy_by_user(@student.id)
      courses = Course.all
      courses.each do |course|
        id = "course-checkbox-#{course.id}"
        if(params.include?(id) and params[id])
          CourseUserRelation.relate!(course.id, @student.id)
        end
      end
    end
end