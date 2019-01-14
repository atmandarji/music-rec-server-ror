class UserController < ApplicationController
	require 'uri'
	require 'net/http'
	require 'jwt'

	def signup
		information = request.raw_post
		body = JSON.parse(information)
		userid = body["userid"]
		username = body["username"]
		password = body["password"]
		if(userid==nil || username==nil || password==nil)
			json_message = {:message => "Missing parameters"}
			render :json => json_message, :status => 422
		elsif(User.exists?(userid: userid))
			json_message = {:message => "User already exist"}
			render :json => json_message, :status => 409
		else
			u = User.create!(username: username, password: password, userid: userid)
			json_message = {:message => "done"}
			#If problem in JSON object

			#If userid exist

			#If new user

			#Else
			render :json => json_message, :status => 202
		end
	end

	def login
		information = request.raw_post
		body = JSON.parse(information)
		userid = body["userid"]
		password = body["password"]
		if(userid==nil || password==nil)
			json_message = {:message => "Missing parameters"}
			render :json => json_message, :status => 422
		elsif(User.exists?(userid: userid))
			user_obj = User.find(params[:userid])
			if (!user_obj.authenticate(password))
				json_message = {:message => "Wrong password"}
				render :json => json_message, :status => 400
			else
				secret_key = "masd82348$asldfja"
				token = JWT.encode({userid: userid}, secret_key, "HS256")
				json_message = {:token => token}
				render :json => json_message, :status => 200
			end
		else
			json_message = {:message => "User don't exist"}
			render :json => json_message, :status => 404
		end
	end

	def search
		artist = params[:artist]
		api_key = "1ca2cf614eeaa185c2b61753b434b599"
		#Top tracks
		api_url = "http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{artist}&api_key=#{api_key}&format=json"
		url = URI(api_url)
		http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Get.new(url)
		request["cache-control"] = 'no-cache'
		response = http.request(request)
		tracks_json = JSON.parse(response.body)

		#Similar Artists
		api_url = "http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=#{artist}&api_key=#{api_key}&format=json"
		url = URI(api_url)
		http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Get.new(url)
		request["cache-control"] = 'no-cache'
		response = http.request(request)
		similar_json = JSON.parse(response.body)

		json_respose = {:toptracks => tracks_json, :similarartists => similar_json}
		#Verify Token

		#If verified 
			#extract userid
			#Call API and add to history
		#Else
		render :json => json_respose, :status => status
	end

	def history
		#Verify Token
		request_type = request.request_method
		if request_type == 'GET'
			obj = {:Type => "get"}
			render :json => obj, :status => 200
		end
		if request_type == 'DELETE'
			obj = {:Type => "delete"}
			render :json => obj, :status => 200
		end
	end
end
