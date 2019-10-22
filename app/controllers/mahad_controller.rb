require 'discordrb/webhooks'

class MahadController < ApplicationController
protect_from_forgery prepend: true
	
	# discord webhooks initialize
	def discord
		
	end
	
	# discord webhooks sending 
	def send_discord
		
		discord_url = params[:url]
		discord_color = params[:color]
		discord_title = params[:title]
		discord_url_title = params[:url_title]
		discord_desc = params[:desc]
		
		begin
			discord_url.each do |x|
			client = Discordrb::Webhooks::Client.new(url: x[1])
			client.execute do |builder|
			  builder.username = "anjing"
			  builder.avatar_url = "https://avatars0.githubusercontent.com/u/25274451?s=460&v=4"
			  builder.add_embed do |embed|
				discord_color.each do |x|
					case x[1]
						when 'white'
				    		embed.colour = "0xffffff"
						when 'black'
				    		embed.colour = "0x1"
						when 'red'
				    		embed.colour = "0xd0021b"
						when 'blue'
				    		embed.colour = "0x22bd0"
						when 'green'
				    		embed.colour = "0x7ed321"
						when 'orange'
				    		embed.colour = "0xf5a623"
						when 'purple'
				    		embed.colour = "0x9013fe"
						else #grey
				    		embed.colour = "0x4a4a4a"
					end
				end
				  
				discord_title.each do |x|
					embed.title = "#{x[1]}"
				end
				  
				discord_url_title.each do |x|
					embed.url = "#{x[1]}"
				end
				  
				discord_desc.each do |x|
					embed.description = "#{x[1]}"
				end
				  
			  end
			end 
			end
		rescue URI::InvalidURIError
			render plain: '{"respond":"failed","code":"0",status:"URI::InvalidURIError"}'
		rescue RestClient::NotFound
			render plain: '{"respond":"failed","code":"0",status:"RestClient::NotFound"}'
		rescue RestClient::Unauthorized
			render plain: '{"respond":"failed","code":"0",status:"RestClient::Unauthorized"}'
		rescue SocketError
			render plain: '{"respond":"failed","code":"0",status:"SocketError"}'
		else
			render plain: '{"respond":"success","code":"1",status:"success sending"}'
		end
		
	end



	
end