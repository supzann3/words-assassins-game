class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/") }

  get '/index' do
    erb :'index'
  end

  get '/status' do
    @players = Player.all.sort_by {|player| player.name}
    # binding.pry
    erb :'status'
  end

  # post '/status' do
  #   @players = Player.all.sort_by {|player| player.name}
  #   # binding.pry
  #   erb :'status'
  # end

  delete '/status' do
    # binding.pry
    id = params['player']['id']
    Player.find(id).dies
    redirect '/status'
  end
  ########################################
  get '/new' do
    erb :'new'
  end

  post '/new'do
    # binding.pry
    @number = params["number"].to_i
    erb :'/new'
    # redirect '/new'
  end

  get '/players' do
  # @players = Player.all.sort_by {|player| player.name}
  # erb :'show'
  end

  post '/status' do
    Player.delete_all
    names=params["player"]["name"]
    emails=params["player"]["email"]
    names.zip(emails).each do |player|
      Player.create({name: player[0], email: player[1]})
    end
    # redirect :'/status'
    # binding.pry
    Player.initial_victim_id_assignment
  end
end
