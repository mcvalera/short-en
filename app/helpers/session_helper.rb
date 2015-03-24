helpers do

  def session_logged_in?
    !session[:current_user_id].blank?
  end

  def session_current_user
    User.find(session[:current_user_id])
  end

end