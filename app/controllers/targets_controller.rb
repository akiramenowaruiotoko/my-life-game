class TargetsController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @users = User.all
    @user = User.find(params[:id])
    @targets = @user.targets.order('target_date DESC')
  end

  def new
    @user = User.find(current_user.id)
    @targets = @user.targets.order('target_date DESC')
    @target = Target.new
  end
  
  def create
    @target = Target.create(target_params)
    if @target.save
      redirect_to action: :new
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(current_user.id)
    @targets = @user.targets.order('target_date DESC')
    @target = Target.find(params[:id])
  end
  
  def update
    @target = Target.find(params[:id])
    if @target.update(target_params)
      redirect_to action: :new
    else
      render :edit
    end
  end

  private
  def target_params
    
    params.require(:target).permit(:target_date, :content).merge(user_id: current_user.id)
  end
end
