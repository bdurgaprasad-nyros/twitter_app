require 'rubygems'
class WelcomeController < ApplicationController
  def index
	#~ oauth_access_token="2303caf21200220f21f711e82172422d"
	#~ user = Koala::Facebook::GraphAPI.new('f70084b25ab055d9ddf80f7ae781eae5')
	#~ user = FbGraph::User.fetch(100001900062986)
	#~ user.feed!(:message => 'Hello Hi Howare u!', :access_token => 'f70084b25ab055d9ddf80f7ae781eae5')

	#~ graph = Koala::Facebook::GraphAPI.new('5be5be0cb5bb585af4187de29d16cd01')
	#~ profile = graph.get_object("me")
	#~ friends = graph.get_connections("me", "friends")
	#~ graph.put_object("me", "feed", :message => "I am writing on my wall!")


	#~ page = FbGraph::Page.new(100001900062986)
	#~ note = page.note!(
	#~ :access_token => '2303caf21200220f21f711e82172422d',
	#~ :subject => 'testing',
	#~ :message => 'Hey, I\'m testing you!'
	#~ )

	#~ me = FbGraph::User.me('2303caf21200220f21f711e82172422d')
	#~ me.feed!(
	#~ :message => 'Updating via FbGraph',
	#~ :picture => 'https://graph.facebook.com/matake/picture',
	#~ :link => 'http://github.com/nov/fb_graph',
	#~ :name => 'FbGraph',
	#~ :description => 'A Ruby wrapper for Facebook Graph API'
	#~ )
  end
end
