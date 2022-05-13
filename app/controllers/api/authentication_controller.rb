class Api::AuthenticationController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    return if user.nil? || !user.valid_password?(params[:user][:password])

    token_encode = JsonWebToken.encode({ user_id: user.id })
    render json: { token: token_encode }, status: :created
  end
end
