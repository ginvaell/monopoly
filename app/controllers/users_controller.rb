class UsersController < ApplicationController
  http_basic_authenticate_with name: "pxjoke", password: "67829516", except: [:index, :show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit(:name))
    @user.money = 15000;
 
  if @user.save
    redirect_to users_path 
  else
    render 'new'
  end
end
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:spend]
      money = @user.money.to_i - params[:spend].to_i           
      @user.update(:money => money) 
      redirect_to users_path      
    elsif params[:recieve]
      money = @user.money.to_i + params[:recieve].to_i            
      @user.update(:money => money)   
      redirect_to users_path    
    elsif params[:transfer_to] and params[:transfer_count]
      @transfer_to = User.find(params[:transfer_to])
      p = @user.money.to_i - params[:transfer_count].to_i
      m = @transfer_to.money.to_i + params[:transfer_count].to_i    
      if @transfer_to != @user
        @user.update(:money => p)
        @transfer_to.update(:money => m)

      end   
      redirect_to users_path    
    else
      if @user.update(params[:user].permit(:name, :money))
        redirect_to users_path   
      else
        render 'edit'
      end

  end
  end

  def spend
    @user = User.find(params[:id])    
  end

  def recieve
    @user = User.find(params[:id])    
  end
  
  def transfer
    @user = User.find(params[:id])
    @users = User.all

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
 
    redirect_to users_path
  end

  def index
    @users = User.all
  end
  private
  def user_params
    params.require(:user).permit(:name)
  end
  
 
end
