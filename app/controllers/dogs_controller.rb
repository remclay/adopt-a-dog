require 'rack-flash'

class DogsController < ApplicationController
  use Rack::Flash

  get '/dogs' do
    if Helpers.logged_in?(session)
      @dogs = Dog.all
      @user = User.find_by_id(session[:id])
      erb :'dogs/index'
    else
      redirect to '/login'
    end
  end

  get '/dogs/new' do
    if Helpers.logged_in?(session)
      @breeds = Breed.all
      erb :'dogs/new'
    else
      redirect to '/login'
    end
  end

  post '/dogs' do
    @dog = Dog.new(params[:dog])
    if @dog.save
      @dog.user_id = session[:id]
      if params[:breed][:name] != ""
        if !Breed.all.collect{|b| b.name}.include?(params[:breed][:name])
          @dog.breeds.create(params[:breed])
        else @dog.breeds.find_by(name: params[:breed][:name])
        end
      end
    @dog.save
    flash[:message] = "New dog successfully added for adoption!"
    redirect to "/dogs/#{@dog.id}"
    else
      flash[:message] = @dog.errors.full_messages.first
      redirect to '/signup'
    end
  end

  get '/dogs/:id' do
    @user = Helpers.current_user(session)
    if @user
      @dog = Dog.find_by_id(params[:id])
      erb :'dogs/show'
    else
      redirect to '/login'
    end
  end

  #EDIT
  get '/dogs/:id/edit' do
    @user = Helpers.current_user(session)
    @dog = Dog.find_by_id(params[:id])
    if @user && @user.id == @dog.user_id
      @breeds = Breed.all
      erb :'/dogs/edit'
    else
      redirect to '/login'
    end
  end

  patch '/dogs/:id' do
    @dog = Dog.find_by_id(params[:id])
    @user = Helpers.current_user(session)
    if @dog.update(params[:dog]) && @user.id == @dog.user_id
      @dog.update(params[:dog])
      if params[:dog][:breed_ids] == nil
        @dog.breed_ids = []
      end
      if params[:breed][:name] != ""
        if !Breed.all.collect{|b| b.name}.include?(params[:breed][:name])
          @dog.breeds.create(params[:breed])
        else @dog.breeds.find_by(name: params[:breed][:name])
        end
      @dog.save
      end
      flash[:message] = "Dog adoption details successfully updated!"
      redirect to "/dogs/#{@dog.id}"
    else
      flash[:message] = @dog.errors.full_messages.first
      redirect to "/dogs/#{@dog.id}"
    end
  end

  #DELETE
  delete '/dogs/:id/delete' do
    @user = Helpers.current_user(session)
    @dog = Dog.find_by_id(params[:id])
    if @user && @dog && @dog.user_id == @user.id
      @dog.delete
      flash[:message] = "Dog successfully removed from adoption!"
      redirect to '/dogs'
    else
      redirect to '/login'
    end
  end
end
