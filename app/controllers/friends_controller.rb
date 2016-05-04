class FriendsController < ApplicationController

	def new
		@friend_to_user = current_user.friends
	end
	
	def create
		puts params[:name] 
		@fid = User.find_by(username: params[:name])
		@user = current_user
		puts @fid
		@friend = Friendship.create(user_id: current_user.id, friend_id: @fid.id)
		render json: @fid
	end

	def show
		@friend_to_user = User.joins("INNER JOIN friendships ON friendships.friend_id = users.id")	
	end

	def destroy
		@friend = Friendship.find_by(user_id: params[:param1],friend_id: params[:param2])
		@friend.destroy
		redirect_to :back
	end

end
