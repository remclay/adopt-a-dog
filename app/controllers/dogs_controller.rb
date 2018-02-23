class DogsController < ApplicationController

  get '/dogs' do
    if Helpers.logged_in?(session)
      @dogs = Dog.all
      erb :'dogs/dogs'
    else
      redirect to '/login'
    end
  end

end
