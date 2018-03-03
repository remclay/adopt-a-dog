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
      @breeds = Breed.all.uniq
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
          @dog.breeds << Breed.create(params[:breed])
        else @dog.breeds << Breed.find_by(name: params[:breed][:name])
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
    if Helpers.logged_in?(session)
      @dog = Dog.find_by_id(params[:id])
      @user = Helpers.current_user(session)
      erb :'dogs/show'
    else
      redirect to '/login'
    end
  end

  #EDIT
  get '/dogs/:id/edit' do
    if @user = Helpers.current_user(session)
      @dog = Dog.find_by_id(params[:id])
      @breeds = Breed.all
      if @user && @user.id = @dog.user_id
        erb :'/dogs/edit'
      else
        redirect to '/login'
      end
    else
      redirect to '/login'
    end
  end

  patch '/dogs/:id' do
    @dog = Dog.find_by_id(params[:id])
    if @dog.update(params[:dog]) && Helpers.logged_in?(session)
      @dog.update(params[:dog])
      if params[:dog][:breed_ids] == nil
        @dog.breed_ids = []
      end
      if params[:breed][:name] != ""
        if !Breed.all.collect{|b| b.name}.include?(params[:breed][:name])
          @dog.breeds << Breed.create(params[:breed])
        else @dog.breeds << Breed.find_by(name: params[:breed][:name])
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
