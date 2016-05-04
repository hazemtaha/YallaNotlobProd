class UserController < Devise::RegistrationsController
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :gender, :image)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :username, :gender, :image)
  end
  def to_json
  	super(:only => [:username, :email, :gender, :image ])
  end
  def user_lookup
    # check if there is any user or group already invited
      if params[:invited] == nil
        @invited = [0,]
      else
        @invited = params[:invited]
      end
      if params[:groups_invited] == nil
        @groups_invited = [0,]
      else
        @groups_invited = params[:groups_invited]
      end
      # get users suggestions for the given query, check if the returned users is already friended and check if they not invited before
      @users = User.where("username LIKE ?","%#{params[:query]}%").where("id in (?)",current_user.friends.ids).where("id not in (?)", @invited)
      # get group suggestions for the given query, check if they owned by the requested user and check if they invited before
      @groups = Group.where("name LIKE ?","%#{params[:query]}%").where("user_id = #{current_user.id}").where("id not in (?)", @groups_invited)
      # @users = User.all
      @results = {suggestions: []}
      # populate suggestions with users
      @users.each { |user| @results[:suggestions].push({value: user.username,data: {id: user.id, img: user.image}}) }
      # populate suggestions with groups
      @groups.each { |group|
        # get all members data in this group
        @members = []
        group.group_members.each { |member|
          # check if there is a user in the group already invited before
          if !@invited.include? member.user_id.to_s
            @members.push(User.select(:id,:username,:image).find(member.user_id))
          end
        }
        @results[:suggestions].push({value: group.name,data: {id: group.id, members: @members }})}
      # puts("results")
      # puts @results
      render json: @results.to_json
  end
end
