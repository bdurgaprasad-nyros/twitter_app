require 'twitter'
require 'open-uri'
require 'find'
require 'json'

class MembersController < ApplicationController
 
	include OauthSystem

	before_filter :oauth_login_required, :except => [ :callback, :signout, :index ]

	before_filter :init_member, :except => [ :callback, :signout, :index ]

	before_filter :access_check, :except => [ :callback, :signout, :index ]


	# GET /members
	# GET /members.xml
	def index
		
		twitter = Twitter::Base.new()
		 
	end

	def new
		# this is a do-nothing action, provided simply to invoke authentication
		# on successful authentication, user will be redirected to 'show'
		# on failure, user will be redirected to 'index'
	end
	
	# GET /members/1
	# GET /members/1.xml
	def show
		
		#~ @friends = self.friends()
		#~ render :text=> @friends.size and return 
		#~ @screens =[]
		 #~ @friends.each  do  |p| 
		 #~ @screens << p["screen_name"]
		 #~ end
               
		#render :text=> @screens.inspect and return 
		#~ render :text=> params[:user_info].inspect and return
		#@user_info=params[:user_info]
		#~ @messages = self.home_timeline()
	 #~ render :text => @messages.methods and return
		#~ respond_to do |format|
			#~ format.html # show.html.erb
			#~ format.xml  { render :xml => @member }
		#~ end
	end

	def update_status
		if self.update_status!(params[:status_message])
			flash[:notice] = 'status update sent'
		else
			flash[:error] = 'status update problem'
		end
		redirect_to member_path(@member)
	end

	def partialfriends
		if (request.xhr?)
			@friends = self.friends()
			render :partial => 'members/friend', :collection => @friends, :layout => false
		else
			flash[:error] = 'method only supporting XmlHttpRequest'
			member_path(@member)
		end
	end

	def partialfollowers
		if (request.xhr?)
			@followers = self.followers()
			render :partial => 'members/friend', :collection => @followers, :as => :friend, :layout => false
		else
			flash[:error] = 'method only supporting XmlHttpRequest'
			member_path(@member)
		end
	end

	def partialmentions
		if (request.xhr?)
			@messages = self.mentions()
			render :partial => 'members/status', :collection => @messages, :as => :status, :layout => false
		else
			flash[:error] = 'method only supporting XmlHttpRequest'
			member_path(@member)
		end
	end

	def partialdms
		if (request.xhr?)
			@messages = self.direct_messages()
			render :partial => 'members/direct_message', :collection => @messages, :as => :direct_message, :layout => false
		else
			flash[:error] = 'method only supporting XmlHttpRequest'
			member_path(@member)
		end
	end

   
   
        def search 
      
	  #~ @messages =search_twitter("kakinada")
	  query = params[:query]
          @messages = Twitter::Search.new.q(query).per_page(10).fetch
	  #~ render :text=> @messages.inspect and return
	  render :partial => 'members/search', :collection => @messages, :as => :direct_message, :layout => false
        end
       

         #~ This is a search using json
        #~ def search_twitter(query)
	       #~ query=CGI.escape(query)
	       #~ JSON.parse(
	                    #~ open("http://search.twitter.com/search.json?q=#{query}").read
			    #~ )['results']
        #~ end
	
	
	def timeline
		#@messages = self.home_timeline()
		
		 #render :text => @messages.inspect
		 #@messages= Twitter::Search.new.to('prasadmca003')
		#  render :partial => 'members/timelines', :locals => @messages, :layout => false
		#~ Twitter.user_timeline('prasadmca003', :count => 200).each do |tweet| 
             #~ puts tweet.inspect 
              #~ end 
		#~ Twitter.configure do |config|
			  #~ config.consumer_key = TWOAUTH_KEY
			  #~ config.consumer_secret = TWOAUTH_SECRET
			  #~ config.oauth_token = session[:request_token] 

			  #~ config.oauth_token_secret = session[:request_token_secret] 
			#~ end

			# Update your status
			#Twitter.update("I'm tweeting from the Twitter Ruby Gem!")

			# Read the most recent tweet in your home timeline
			#twitter_time_lines= Twitter::OAuth.new(TWOAUTH_KEY , TWOAUTH_SECRET )
                      #tweets= twitter_time_lines.authorize_from_access(session[:request_token] ,session[:request_token_secret] )
		       #~ aaaa=  Twitter::Base.new()
		       #~ @messages=@member.statuses
		        #~ render :partial => 'members/search', :collection => @messages, :as => :direct_message, :layout => false
		#~ @messages = self.timelines()
		#@aaa= @member.home_timeline.first.text
                 #tweets =twitter.home_timeline

		#~ render :text=> twitter.inspect and return
				#~ if (request.xhr?)
			#~ @messages = self.timelines()
			#~ render :partial => 'members/direct_message', :collection => @messages, :as => :direct_message, :layout => false
		#~ else
			#~ flash[:error] = 'method only supporting XmlHttpRequest'
			#~ member_path(@member)
		#~ end
		#~ http://dev.twitter.com/pages/oauth_single_token#ruby
		end
	
protected

	# controller helpers
	
	def init_member
		begin
			screen_name = params[:id] unless params[:id].nil?
			screen_name = params[:member_id] unless params[:member_id].nil?
			@member = Member.find_by_screen_name(screen_name)
			raise ActiveRecord::RecordNotFound unless @member
		rescue
			flash[:error] = 'Sorry, that is not a valid user.'
			redirect_to root_path
			return false
		end
	end
	
	
	def access_check
		return if current_user.id == @member.id
		flash[:error] = 'Sorry, permissions prevent you from viewing other user details.'
		redirect_to member_path(current_user) 
		return false		
	end	

	

end
