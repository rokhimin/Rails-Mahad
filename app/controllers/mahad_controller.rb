require 'discordrb/webhooks'
require 'slack/incoming/webhooks'

class MahadController < ApplicationController
protect_from_forgery prepend: true
	
	# discord webhooks initialize
	def discord
		
	end
	
	# discord webhooks sending 
	def send_discord
		
		discord_url = params[:url]
		discord_username = params[:username]
		discord_avatar_url = params[:avatar_url]
		discord_color = params[:color]
		discord_title = params[:title]
		discord_url_title = params[:url_title]
		discord_desc = params[:desc]
		discord_image = params[:image]
		discord_thumbnail = params[:thumbnail]
		discord_author_name = params[:author_name]
		discord_author_url = params[:author_url]
		discord_author_icon_url = params[:author_icon_url]
		discord_footer = params[:footer]
		discord_icon_footer = params[:icon_footer]
		discord_field_name = params[:field_name]
		discord_field_value = params[:field_value]
		
		begin
			discord_url.each do |x|
			client = Discordrb::Webhooks::Client.new(url: x[1])
			client.execute do |builder|
			discord_username.each do |x|
			  builder.username = "#{x[1]}"
			end
			discord_avatar_url.each do |x|
			  builder.avatar_url = "#{x[1]}"
			end
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
				  
				discord_image.each do |x|
					embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{x[1]}")
				end
				  
				discord_thumbnail.each do |x|
 					embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "#{x[1]}")
				end
				
				discord_author_url.each do |x|
					@sigil_author_url = x[1]
				end
				discord_author_icon_url.each do |x|
					@sigil_author_icon_url = x[1]
				end
				  
				discord_author_name.each do |x|
					embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{x[1]}", url: "#{@sigil_author_url}", icon_url: "#{@sigil_author_icon_url}")
				end
				  
				discord_icon_footer.each do |x|
					@sigil_icon_footer = x[1]
				end
					
				discord_footer.each do |x|
  					embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "#{x[1]}", icon_url: "#{@sigil_icon_footer}")
				end
				  
				discord_field_value.each do |x|
					@sigil_field_value = x[1]
				end
				  
				discord_field_name.each do |x|
					unless @sigil_field_value == ''
				    	embed.add_field(name: "#{x[1]}", value: "#{@sigil_field_value}")
					else
					end
				end

			  end
			end 
			end
		rescue URI::InvalidURIError
			render plain: '{"respond":"failed","code":"0",status:"URI::InvalidURIError"}'
		rescue RestClient::NotFound
			render plain: '{"respond":"failed","code":"0",status:"RestClient::NotFound"}'
		rescue RestClient::BadRequest
			render plain: '{"respond":"failed","code":"0",status:"RestClient::BadRequest"}'
		rescue RestClient::Unauthorized
			render plain: '{"respond":"failed","code":"0",status:"RestClient::Unauthorized"}'
		rescue SocketError
			render plain: '{"respond":"failed","code":"0",status:"SocketError"}'
		else
			render plain: '{"respond":"success","code":"1",status:"success sending"}'
		end
		
	end


	# slack webhook initialize
	def slack
	end

	# slack webhook sending
	def send_slack
		
		slack_url = params[:url]
		slack_username = params[:username]
		slack_color = params[:color]
		slack_title = params[:title]
		slack_url_title = params[:url_title]
		slack_post = params[:post]
		slack_text = params[:text]
		slack_image = params[:image]
		
		slack_url.each do |x|
		@slack = Slack::Incoming::Webhooks.new "#{x[1]}"
		end

		
		slack_username.each do |x|
			@sigil2_username = x[1]
		end
		slack_color.each do |x|
					case x[1]
						when 'white'
				    		@sigil2_color = "#ffffff"
						when 'black'
				    		@sigil2_color = "#000000"
						when 'red'
				    		@sigil2_color = "#ff0000"
						when 'blue'
				    		@sigil2_color = "#0000ff"
						when 'green'
				    		@sigil2_color = "#00cc00"
						when 'orange'
				    		@sigil2_color = "#ff8c1a"
						when 'purple'
				    		@sigil2_color = "#9900ff"
						else #grey
				    		@sigil2_color = "#8c8c8c"
					end
		end
		slack_title.each do |x|
			@sigil2_title = x[1]
		end
		slack_url_title.each do |x|
			@sigil2_url_title = x[1]
		end
		slack_post.each do |x|
			@sigil2_post = x[1]
		end
		slack_text.each do |x|
			@sigil2_text = x[1]
		end
		slack_image.each do |x|
			@sigil2_image = x[1]
		end
		
		begin
			
		attachments = {
		  color: "#{@sigil2_color}",
		  title: "#{@sigil2_title}",
		  title_link: "#{@sigil2_url_title}",
		  text: "#{@sigil2_text}",
		  image_url: "#{@sigil2_image}"
		}

		@slack.username = "Mahad-#{@sigil2_username}"
		@slack.post "#{@sigil2_post}", attachments: [attachments]
			
		rescue NoMethodError
			render plain: '{"respond":"failed","code":"0",status:"NoMethodError"}'
		else
			render plain: '{"respond":"success","code":"1",status:"success sending"}'
			
		end
	end

	
end