class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if User.find_by_email(user_params[:email])
      flash[:error] = 'Email ID already exists'
      render 'user_sessions/signup'
      return
    end
    @user.login_identifier = @user.email
    if @user.save
      user_session = UserSession.new(@user)
      user_session.save
      redirect_to schedules_path
    else
      render 'user_sessions/signup'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end