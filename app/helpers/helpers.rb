class Helpers

  def self.logged_in?(session)
    !!current_user(session)
  end

  def self.current_user(session)
    @current_user ||= User.find_by_id(session[:id]) if session[:id]
  end
end
