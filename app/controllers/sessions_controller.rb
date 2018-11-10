class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session][:name_or_mail].match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i).nil?
      user = User.find_by(alias: params[:session][:name_or_mail])
    else
      user = User.find_by(email: params[:session][:name_or_mail].downcase)
    end
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
