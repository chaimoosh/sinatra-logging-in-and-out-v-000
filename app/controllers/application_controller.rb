require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user.nil?
      erb :error
    else
      session[:user_id] = @user.id
      redirect to '/account'
    end
  end

  get '/account' do
    if session.nil?
      redirect to '/error'
    else
      @user = User.find(session[:user_id])
      erb :account
    end
  end

  get '/logout' do
    session.clear
  end


end
