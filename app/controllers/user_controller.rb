class UserController < ApplicationController
  
   before_action :authenticate_user!
  
  def show
    user = User.find(params[:id])  
  end
  
  def update
    user = User.find(params[:id]) 
    if user.update(user_params)
      render json: "User update successfully"
    else
      render json: "Error accured , user not updated"
    end
  end  
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
end
