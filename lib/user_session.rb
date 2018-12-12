class UserSession < Authlogic::Session::Base
  generalize_credentials_error_messages "Invalid Email or Password. Please try again"

  validate :check_if_inactive

  @@session_key = "user_session"
  def session
    Authlogic::Session::Base.controller.session[@@session_key] ||= {}
  end

  def destroy()
    Authlogic::Session::Base.controller.session[@@session_key] = {}
    super
    controller.session.clear
  end

  private
  def check_if_inactive
    errors.add(:base, "This account has been deactivated") if (attempted_record && attempted_record.status == 'inactive')
  end
end
