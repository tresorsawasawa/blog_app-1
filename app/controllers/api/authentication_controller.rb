class Api::AuthenticationController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email])
    if user.nil? || !user.valid_password?(params[:password])
      return render json: { error: 'Email/Password is incorrect or Please sign up.' }
    end

    token_encode = JsonWebToken.encode({ user_id: user.id })
    render json: { token: token_encode }, status: :created
  end
end
