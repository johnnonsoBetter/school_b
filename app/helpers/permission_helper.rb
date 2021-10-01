module PermissionHelper
   def check_permission_for(user)
    unless user.permitted
        render json: "Unauthorized", status: :unauthorized
    end
   end
end
