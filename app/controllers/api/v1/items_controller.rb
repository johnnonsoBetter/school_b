class Api::V1::ItemsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index, :update, :destroy, :show]
    before_action :find_admin, only: [:create, :update, :destroy, :show, :index]
    before_action :figure_status, only: [:create, :update, :destroy, :show, :index]
    before_action :find_item, only: [:destroy, :show, :update]


    def create 

        @item = @admin.school.items.new item_params

        if @item.save 
            render json: @item, status: :created 
        else 
            render json: @item.errors.messages, status: :unprocessable_entity 
        end

    end

    def destroy 
       
        @item.destroy

    end


    def update 

       
        if @item.update(item_params) 
            render json: @item, status: :ok
        else 
            render json: @item.errors.messages, status: :unprocessable_entity 
        end
    end

    def show 
        
        render 'api/v1/items/show.json.jbuilder'
    end


    def index 
        @items = @admin.school.items
        render 'api/v1/items/index.json.jbuilder'
    end

    private
    
    def item_params 
        params.require(:item).permit(:name, :selling_price, :quantity)

    end
    
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end

    def find_item 
        @item = Item.find_by(id: params[:id])

        unless @item 
            render json: "Not Found ", status: :not_found
        end
    end

    
end
