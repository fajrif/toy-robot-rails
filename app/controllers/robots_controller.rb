class RobotsController < ApplicationController
  def new
    @robot = Robot.new
  end

  def create
    @robot = Robot.new(params[:robot])
    @robot.execute_commands!
    render :new
  end
end
