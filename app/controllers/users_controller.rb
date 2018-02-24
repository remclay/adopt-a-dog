require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      @dogs = @user.dogs
      erb :'users/show'
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    if !Helpers.logged_in?(session)
      erb :'users/create_user'
    else
      redirect to '/dogs'
    end
  end

  post '/signup' do
    @user = User.create(params)
    if @user.save
      session[:id] = @user.id
      redirect to '/dogs'
    else
      #error message
      flash[:message] = @user.errors.full_messages.first
      redirect to '/signup'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect to '/dogs'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/dogs"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
      redirect to '/login'
    end
      redirect to '/'
  end
end
