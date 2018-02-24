require 'rack-flash'

class DogsController < ApplicationController
  use Rack::Flash

  get '/dogs' do
    if Helpers.logged_in?(session)
      @dogs = Dog.all
      @user = User.find_by_id(session[:id])
      erb :'dogs/dogs'
    else
      redirect to '/login'
    end
  end

  get '/dogs/new' do
    if Helpers.logged_in?(session)
      @breeds = Breed.all.uniq
      erb :'dogs/create_dog'
    else
      redirect to '/login'
    end
  end

  post '/dogs' do
    if params[:name] != "" && params[:age] != ""
      @dog = Dog.create(params[:dog])
      @dog.user_id = session[:id]
      if params[:breed] != ""
        @dog.breeds << Breed.create(params[:breed])
      end
      @dog.save
      flash[:message] = "New dog successfully added for adoption!"
      redirect to "/dogs/#{@dog.id}"
    end
  end

  get '/dogs/:id' do
    if Helpers.logged_in?(session)
      @dog = Dog.find_by_id(params[:id])
      erb :'dogs/show_dog'
    else
      redirect to '/login'
    end
  end

  #EDIT
  get '/dogs/:id/edit' do
    if @user = Helpers.current_user(session)
      @dog = Dog.find_by_id(params[:id])
      if @user && @user.id = @dog.user_id
        erb :'/dogs/edit_dog'
      else
        redirect to '/login'
      end
    else
      redirect to '/login'
    end
  end

  patch 'dogs/:id' do
    if Helpers.logged_in?(session) && params[:name] != "" && params[:age] != ""
      @dog = Dog.find_by_id(params[:id])
      @dog.update(params[:dog])
      flash[:message] = "Dog adoption details successfully updated!"
      redirect to "/dogs/#{@dog.id}"
    else
      redirect to '/login'
    end
  end

  #DELETE
  delete '/dogs/:id/delete' do
    if Helpers.logged_in?(session)
      @dog = Dog.find_by_id(params[:id])
      if @dog && @dog.user = Helpers.current_user(session)
        @dog.delete
        flash[:message] = "Dog successfully removed from adoption!"
      end
      redirect to '/dogs'
    else
      redirect to '/login'
    end
  end
end
