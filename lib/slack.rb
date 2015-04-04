require "slack/version"
require "net/http"
require "uri"
require "json"
require 'ostruct'
require 'active_support/core_ext/hash'

module Slack

	def self.set_token(token = ENV['SLACK_TOKEN'])
		@token = token
		@rtm = self.rtm_start
	end

	def self.show_rtm
		@rtm
	end

	def self.show_token
		@token
	end

	def self.rtm_start
		token = @token
		uri = URI.parse("https://slack.com/api/rtm.start?token="+token)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Post.new(uri.request_uri)
		response = http.request(request)
		response = JSON.parse(response.body)
		response = OpenStruct.new(response)
	end

	def self.find_by_name(name)
		@rtm.users.each do |user|
			u = OpenStruct.new(user)
			if u.name == name
				return u
			end
		end
		return nil
	end

	def self.find_channel_by_name(name)
		@rtm.channels.each do |channel|
			c = OpenStruct.new(channel)
			if c.name == name
				return c
			end
		end
		return nil
	end

	def self.get_direct_channel(name)
		uid = nil
		@rtm.users.each do |user|
			os = OpenStruct.new(user)
			if os.name == name
				uid = os.id
			end
		end

		@rtm.ims.each do |im|
			i = OpenStruct.new(im)
			if i.user == uid
				return i
			end
		end
		return nil
	end

	def self.send_message(channel, text)
		id = rand(1..150)
		token = @token
		text = self.sanitize_text(text)
		uri = URI.parse("https://slack.com/api/chat.postMessage")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data({"token" => "#{token}", "id" => "#{id}", "type" => "message", "channel" => "#{channel}", "text" => "#{text}", "as_user" => "true"})
		response = http.request(request)
		response = JSON.parse(response.body)
		response = OpenStruct.new(response)
	end

	def self.send_message_to_user(name, text)
		id = rand(1..150)
		token = @token
		text = self.sanitize_text(text)
		uri = URI.parse("https://slack.com/api/chat.postMessage")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data({"token" => "#{token}", "id" => "#{id}", "type" => "message", "channel" => "#{self.get_direct_channel(name).id}", "text" => "#{text}", "as_user" => "true"})
		response = http.request(request)
		response = JSON.parse(response.body)
		response = OpenStruct.new(response)
	end

	def self.send_message_to_channel(name, text)
		id = rand(1..150)
		token = @token
		text = self.sanitize_text(text)
		uri = URI.parse("https://slack.com/api/chat.postMessage")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data({"token" => "#{token}", "id" => "#{id}", "type" => "message", "channel" => "#{self.find_channel_by_name(name).id}", "text" => "#{text}", "as_user" => "true"})
		response = http.request(request)
		response = JSON.parse(response.body)
		response = OpenStruct.new(response)
	end

	def self.sanitize_text(text)
		text = text.gsub(/\@(\w+)/) {|user| "<@#{self.get_direct_channel(user.gsub('@', '')).user}>"}
		text = text.gsub(/\#(\w+)/) {|channel| "<##{self.find_channel_by_name(channel.gsub('#', '')).id}>"}
	end
end
