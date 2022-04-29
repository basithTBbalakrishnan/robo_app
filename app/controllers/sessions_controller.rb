class SessionsController < Devise::SessionsController
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.valid_password?(params[:password])
      puts"success when login" 
      @current_user = user
      @current_user_token = user[:user_token]
      render json: "User singed in sucesfully"
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end