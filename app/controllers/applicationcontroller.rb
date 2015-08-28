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

end
