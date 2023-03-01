class UsersController < ApplicationController
  before_action :authorize, only: [:show]

  def create 
    user = User.create(permitted_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: {error: user.errors}, status: 422
  end
end

def show
  user = User.find(session[:user_id])
  render json: user
end

  private

  def permitted_params
params.permit(:username, :password, :password_confirmation)
  end

  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
  end

end
