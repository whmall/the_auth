class TheAuth::JoinController < TheAuth::BaseController

  def new
    @user = User.new(password: '')
    store_location request.referer if request.referer.present?
  end

  def create
    @user = User.new(user_params)
    if @user.join(params)
      login_as @user
      redirect_back_or_default
    else
      render :new, error: @user.errors.full_messages
    end
  end

  private
  def user_params
    params.fetch(:user, {}).permit(:name, :email, :mobile, :password, :password_confirmation)
  end

end
