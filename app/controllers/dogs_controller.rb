class DogsController < ApplicationController

  get '/dogs' do
    if Helpers.logged_in?(session)
      @dogs = Dog.all
      erb :'dogs/dogs'
    else
      redirect to '/login'
    end
  end

  get '/dogs/new' do
    if Helpers.logged_in?(session)
      @breeds = Dog.all.collect{|d| d.breed}.uniq
      erb :'dogs/create_dog'
    else
      redirect to '/login'
    end
  end

  post '/dogs' do
    if params[:name] != "" && params[:age] != ""
      @dog = Dog.create(params[:dog])
      @dog.user_id = session[:id]
      @dog.save
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
  get 'dogs/:id/edit' do
    if @user = Helpers.logged_in?(session)
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
      redirect to "/dogs/#{@dog.id}"
    else
      redirect to '/login'
    end
  end

  delete 'dogs/:id/delete' do
    if Helpers.logged_in?(session)
      @dog = Dog.find_by_id(params[:id])
      if @dog && @dog.user = Helper.current_user(session)
        @dog.delete
        #Add message or additional view
      end
      redirect to '/dogs'
    else
      redirect to '/login'
    end
  end
end
