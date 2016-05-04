class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @orders = Order.all.where(user_id: current_user.id).order(created_at: :desc)
  end



  def new
  	@order = Order.new
  end

  def create
    # puts order_params[:order_type].class

  	@order = Order.new(order_params)
    # puts @order.inspect
    respond_to do |format|
	  	# if params[:invited] && @order.valid?
	  	if @order.save && params[:invited]

        # @invites = OrderInvite.where(order_id: @order.id)
          # add order invites if the order successfully added
          params[:invited].each { |invite| @order.order_invites.create(order_id: @order.id,user_id: invite) }
          @invites = @order.order_invites
	        format.html { redirect_to @order, notice: 'Order was successfully created.' }
	        format.json { render :show, status: :created, location: @order }
          format.js
		else
          if !params[:invited]
            @order.errors.messages[:friends_invited] = ["needs to be at least one firend"]
          end
          puts @order.inspect
	        format.html { render :new }
	        format.json { render json: @order.errors, status: :unprocessable_entity }
          format.js
	    end
	end
  end

  def show
    @order = Order.find(params[:id])
    puts @order.order_type
    @order_item = OrderItem.new
    @order_items = @order.order_items
    puts @order.inspect
    # puts @order_item.inspect
    # check if user is already invited to the requested order
    @invite = current_user.order_invites.find_by(order_id: params[:id])
    if @invite
      # if invited check his invite_status to joined
      @invite.invite_status = "1"
      @invite.save
    # if he is not invited or he's not the owner of the order render 404
    elsif !params[:id].to_i.in?(current_user.orders.ids)
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
  def order_invited_users
    @users = Order.find(params[:order_id]).order_invites.where(invite_status: "0").collect { |invite| invite.user }
    render json: @users.to_json
  end
  def order_joined_users
    @users = Order.find(params[:order_id]).order_invites.where(invite_status: "1").collect { |invite| invite.user }
    render json: @users.to_json
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @post = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params

      @n_params = params.require(:order).permit(:order_type, :destination, :menu_img, :user_id)
      @n_params[:order_type] = @n_params[:order_type].to_i
      return @n_params
    end
end
