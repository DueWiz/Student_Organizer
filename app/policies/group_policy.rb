class GroupPolicy
  attr_reader :user, :group
  
  def initialize(user, group)
    @user = user
    @group = group
  end

  def create?
  end

end