class ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
    # @order_item = OrderItem.new
    # @order = Order.find(params[:order_id])

  end

  def create
    @order_item = OrderItem.new(order_item_params)
    respond_to do |format|
	  	if @order_item.save
        puts "success"
	        format.html { redirect_to @order_item, notice: 'Order was successfully created.' }
	        format.json { render :show, status: :created, location: @order_item }
          format.js
		else
	        format.html { render :new }
	        format.json { render json: @order_item.errors.full_messages, status: :unprocessable_entity }
          format.js
          # format.js { render :file => "/items/_errors.js.erb" }
	    end
	end
  end

  def destroy
    @item = OrderItem.find(params[:id])
    if current_user.id == @item.user_id
      @item.destroy
    end
  end

  private
  def order_item_params
    params.require(:order_item).permit(:item, :amount, :price, :comment, :user_id, :order_id)
  end
end
