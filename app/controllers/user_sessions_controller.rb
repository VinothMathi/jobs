class UserSessionsController < ApplicationController
  def new
    if Current.user
      redirect_to schedules_path
    end
    if params[:redirecturl].present?
      session[:login_referer] = params[:redirecturl]
    elsif session[:login_referer].blank? && request.env["HTTP_REFERER"].present?
      session[:login_referer] = request.env["HTTP_REFERER"]
    end
    @origin = Hash.new
    @origin["origin"]= request.env['HTTP_REFERER'] if request.env["HTTP_REFERER"].present?
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params.to_h)
    if @user_session.save
      set_user_session(@user_session.record)
      redirect_url = session[:login_referer] || schedules_path
      redirect_to(redirect_url)
    else
      flash.now[:error] = @user_session.errors.full_messages
      @origin = Hash.new
      @origin["origin"]= request.env['HTTP_REFERER'] if request.env["HTTP_REFERER"].present?
      @user = User.new
      request.env["HTTP_REFERER"] = "/" if request.env["HTTP_REFERER"].blank?
      render 'new'
    end
  end

  def signup
    @user = User.new
  end

  def logout
    set_user_session
    show()
  end

  def show
    redirect_to '/login'
  end

  private
  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end