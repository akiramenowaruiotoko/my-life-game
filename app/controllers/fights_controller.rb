class FightsController < ApplicationController
  def create
    @fight = current_user.fights.create(target_id: params[:target_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @target = Target.find(params[:target_id])
    @fight = current_user.fights.find_by(target_id: @target.id)
    @fight.destroy
    redirect_back(fallback_location: root_path)
  end
end
