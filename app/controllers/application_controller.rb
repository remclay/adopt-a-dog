require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "adoptadogsecret"
  end

  get '/' do
    user = Helpers.current_user(session)
    if user
      flash[:message] = "Welcome back, #{user.username}!"
      redirect to '/dogs'
    else
      erb :home
    end
  end
end
