class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/") }

  get '/status' do
    @players = Player.all.sort_by {|player| player.name}
    # binding.pry
    erb :'status'
  end

  delete '/status' do
    # binding.pry
    id = params['player']['id']
    Player.find(id).dies
  end
  ########################################
  get '/new' do
    erb :'new'
  end
  get '/players'
  @players = Player.all.sort_by {|player| player.name}
    erb :'show'
  end
  post '/players'
  @players=Player.create[:params]
    redirect :'/players'
  end
end
