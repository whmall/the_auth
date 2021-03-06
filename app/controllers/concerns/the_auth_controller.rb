module TheAuthController
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def current_user
    @current_user ||= login_from_session
  end

  def require_login
    return if current_user
    store_location
    if params[:form_id]
      redirect_to login_url(form_id: params[:form_id], login: params[:login])
    else
      redirect_to login_url
    end
  end

  def login_from_session
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def store_location(path = nil)
    if [login_url, password_forget_url].include? path
      session[:return_to] = root_url
    else
      session[:return_to] = path || request.fullpath
    end
  end

  def redirect_back_or_default(default = root_url)
    redirect_to session[:return_to] || default
    session[:return_to] = nil
  end

end