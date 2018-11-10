require 'securerandom'

class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.alias.empty?
      @user.alias = default_alias
    end
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :alias,
                                   :password_confirmation)
    end

    def default_alias
      SecureRandom.hex(5)
    end
end
