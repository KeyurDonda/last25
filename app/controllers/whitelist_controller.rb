class WhitelistController < ApplicationController
    	def index
      	  @users = User.order( 'id desc' ).all
    	end
	end
