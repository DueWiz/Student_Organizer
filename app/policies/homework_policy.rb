class HomeworkPolicy
  attr_reader :user, :homework
  
  def initialize(user, homework)
    @user = user
    @homework = homework
  end

  def create?
  end

end