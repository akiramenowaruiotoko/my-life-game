class AchievesController < ApplicationController
  def create
    @achieve = Achieve.create(target_id: params[:target_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @target = Target.find(params[:target_id])
    @achieve = Achieve.find_by(target_id: @target.id)
    @achieve.destroy
    redirect_back(fallback_location: root_path)
  end
end
