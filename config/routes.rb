Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: redirect('/discord')
	#discord route
	get '/discord', to: 'mahad#discord'
	post '/discord', to: 'mahad#send_discord'
	# slack route
	get '/slack', to: 'mahad#slack'
	post '/slack', to: 'mahad#send_slack'
end
