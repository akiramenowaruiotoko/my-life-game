class FightsController < ApplicationController
  before_action :set_fight

  def create
    @fight = current_user.fights.create(target_id: params[:target_id])
  end

  def destroy
    @fight = current_user.fights.find_by(target_id: @target.id)
    @fight.destroy
  end

  private

  def set_fight
    @target = Target.find(params[:target_id])
  end
end
