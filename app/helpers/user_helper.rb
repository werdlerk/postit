module UserHelper

  def user_role(user)
    if user.admin?
      'Administrator'
    else
      'User'
    end
  end
end