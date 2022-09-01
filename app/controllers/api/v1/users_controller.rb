class Api::V1::UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if(@user.valid?)
      token =encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: :ok
    else
      render json: {error: 'User Credential Invalid'}, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find_by!(id: params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def user_params
    params.permit(:username, :password, :user_type)
  end
end