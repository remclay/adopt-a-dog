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
end
