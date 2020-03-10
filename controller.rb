require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/film')
require_relative('./models/customer')
# require_relative('./models/tickets')
also_reload('./models/*')

get '/'do
  erb(:home)
end

get '/films' do
  @films = Film.all
  erb(:index)
end

get '/films/:id' do
  @films = Film.find(params[:id].to_i)
  erb(:film)
end
