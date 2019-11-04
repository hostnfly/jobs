class MissionsController < ApplicationController
  # GET /missions/1
  # GET /missions/1.json
  def index
    @missions = Mission.all
  end

  # POST /missions/generate
  def generate
    Missions::GenerateService.new().perform

    redirect_to_index
  end

  # GET /missions/1
  # GET /missions/1.json
  def show
  end

  private
  def redirect_to_index
    redirect_to "/missions"
  end
end
