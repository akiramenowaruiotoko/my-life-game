class TargetsController < ApplicationController
  before_action :set_user_where, only: [:index, :show]
  before_action :set_current_user, only: [:new, :edit]
  before_action :set_targets, only: [:new, :edit]
  before_action :set_target_find_id, only: [:edit, :update, :destroy, :move_to_index]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @user = User.find(params[:id])
    set_targets
  end
  
  def new
    @target = Target.new
  end
  
  def create
    @target = Target.create(target_params)
    if @target.save
      redirect_to action: :new
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
  end

  def update
    if @target.update(target_params)
      redirect_to action: :new
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @target.destroy
    redirect_back(fallback_location: root_path)
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @target.user_id
  end

  def set_user_where
    @users = User.where(private_mode: 0)
  end

  def set_current_user
    @user = User.find(current_user.id)
  end

  def set_targets
    @targets = @user.targets.order('target_date DESC')
  end

  def set_target_find_id
    @target = Target.find(params[:id])
  end

  private

  def target_params
    params.require(:target).permit(:target_date, :content, :achieve).merge(user_id: current_user.id)
  end
end
