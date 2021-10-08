class Api::V1::ItemsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index, :update]
    before_action :find_admin, only: [:create, :update]
    before_action :figure_status, only: [:create, :update]


    def create 

        @item = @admin.school.items.new item_params

        

        if @item.save 
            render json: @item, status: :created 
        else 
            render json: @item.errors.messages, status: :unprocessable_entity 
        end


        
    end


    def update 

        @item = Item.find_by(id: params[:id])

        

        if @item.update(item_params) 
            render json: @item, status: :ok
        else 
            render json: @item.errors.messages, status: :unprocessable_entity 
        end
    end

    private
    
    def item_params 
        params.require(:item).permit(:name, :selling_price)

    end
    
    def find_admin 
        @admin = current_api_v1_admin
    end

    def figure_status
        check_permission_for @admin
    end

    
end
