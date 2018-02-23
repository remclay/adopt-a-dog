class UsersController < ApplicationController

  get '/signup' do
    if !Helpers.logged_in?(session)
      erb :'users/create_user'
    else
     redirect to '/dogs'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      #use validation
      @user = User.create(params)
      session[:id] = @user.id
      redirect to '/dogs'
    else
      #error message
      redirect to '/signup'
    end
  end

end
