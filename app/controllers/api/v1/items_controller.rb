class Api::V1::ItemsController < ApplicationController
    include PermissionHelper
    before_action :authenticate_api_v1_admin!, only: [:create, :index, :show]
    before_action :find_admin, only: [:create, :index, :show]
    before_action :figure_status, only: [:create, :index, :show]


    def create 

        @item = @admin.school.items.new item_params

        

        if @item.save 
            render json: @item, status: :created 
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
