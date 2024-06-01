class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  def index
    @users = User.all
    render json: @users.as_json
  end

  def show
    render json: @user.as_json
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      
    end
  end

  def update
    if @user.update(user_params)
      render json: @user.as_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password_digest, :phone_number)
  end
end
