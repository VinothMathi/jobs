class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  around_action :wrap_in_transaction
  around_action :set_current

  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      yield
    end
  end

  def set_current
    set_current_user
    yield
  ensure
    # to address the thread variable leak issues in Puma/Thin webserver
    Current.reset!
  end

  def set_current_user
    Current.user ||= session['user_credentials_id'] && User.find(session['user_credentials_id'])
  end

  def require_login
    unless Current.user
      flash[:error] = 'Please login to proceed'
      redirect_to '/login'
    end
  end

  def set_user_session(user=nil)
    session['user_credentials_id'] = user.try(:id)
    Current.user = user
  end
end