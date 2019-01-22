class TweetsController < ApplicationController

  get '/tweets' do
    redirect '/login' if !logged_in?

    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    redirect '/login' if !logged_in?

    erb :'tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(:content=>params[:content], :user_id=>session[:user_id])
    redirect '/tweets/new'
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if (params[:content] != "")
      @tweet.update(:content=>params[:content]) #if params[:content].nil?
      redirect "/tweets/#{@tweet.id}"
    end

    redirect "/tweets/#{@tweet.id}/edit"
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if (@tweet.user == current_user)
      @tweet.delete
    end
    redirect '/tweets'
  end


end
