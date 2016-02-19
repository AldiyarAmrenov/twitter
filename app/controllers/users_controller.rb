class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Вы успешно зарегистрировались'
      redirect_to @user 
    else 
      render 'new'
    end
  end
    
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
    
  def index
      @users = User.paginate(page: params[:page])
  end
    
  def edit
      @users = User.find(params[:id])
  end 
    
  def update
       @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Изменения прошли успешно'
      redirect_to @user 
    else 
      flash[:danger] = 'Не удалось изменить'
      render 'new'
    end
  end 
   
  def destroy
     User.find(params[:id]).destroy
     flash[:info] = 'Удаление прошло успешно'
     redirect_to users_path
  end
    
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
    
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end