class UsersController < ApplicationController

  get '/login' do
    redirect '/tweets' if logged_in?

    erb :'users/login'
  end

  post '/login' do
    # if logged_in?
    #   @user= User.find(session[:user_id])
    # else
      user = User.find_by(:username=>params[:username])
    # end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    redirect '/tweets' if logged_in?

    erb :'users/create_user'
  end

  post '/signup' do
    user = User.new(:username=>params[:username], :password=>params[:password], :email=>params[:email])
    if user.save
      session[:user_id] = user.id

      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    erb :'users/show'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
