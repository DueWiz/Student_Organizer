class HomeworkPolicy
  attr_reader :user, :homework
  
  def initialize(user, homework)
    @user = user
    @homework = homework
  end

  def create?
  	true
  end

  def edit?

  end
end