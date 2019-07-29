require 'gossip'
class ApplicationController < Sinatra::Base
	
	get '/' do
		 erb :index
	end

	get '/gossips/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		redirect '/'
	end

	get '/gossips/' do
		erb :gossips, locals: {gossips: Gossip.all}
	end

	get '/gossips/:id/' do
		#puts "Voici le numéro du potin que tu veux : #{params['id']}!"
		#puts params['id']
		#puts Gossip.find(params['id']).author #+ Gossip.find('id').content
		erb :gossip, locals: {gossip: Gossip.find(params['id']), id:params['id']}
	end
end

#binding.pry