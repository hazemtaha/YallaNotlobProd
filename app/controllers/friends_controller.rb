class FriendsController < ApplicationController
before_action :authenticate_user!	
	def new
		@friend_to_user = current_user.friends
	end
	
	def create

		@parameter = params[:name]
		
		if  @parameter.empty?
			@error_null = {'value': 'You have to put some data'}
			puts "this guy is empty"
			render json: @error_null
		else #check if it is the same user
			#if it is a wrong type
if User.exists? username: @parameter
				puts "ok fine it is a user"
			#check if he is the same user		
			if @parameter == current_user.username 
				@error_addSelf = {'same': 'You can not add your self !'}
				puts "add your self nigger"
				render json: @error_addSelf
			else
				#check if the friend exist or not
				@fid = User.find_by(username: params[:name])
				@user = current_user
				if @user.friendships.exists? friend_id: @fid.id
				    @error_addExist = {'exist': 'You already added this friend !'}
					puts "your friend is already here"
			        render json: @error_addExist
				else
					puts "it is a new friend gal save"
					@user = current_user
					@friend = Friendship.create(user_id: current_user.id, friend_id: @fid.id)
					render json: @fid
				end		
				puts "New friend Ha"	
				puts "this guy is full of data"				
			end
else
			@error_notValid = {'notValid': 'This user is not exist !'}
			puts "Nooo it is a robot"
			render json: @error_notValid				
end	
		end
			
	end #function

	def show
		@friend_to_user = User.joins("INNER JOIN friendships ON friendships.friend_id = users.id")	
	end

	def destroy
		@friend = Friendship.find_by(user_id: params[:param1],friend_id: params[:param2])
		@friend.destroy
		redirect_to :back
	end

end
