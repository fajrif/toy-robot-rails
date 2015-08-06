class RobotsController < ApplicationController
  def new
    @robot = Robot.new
  end

  def command
    @robot = Robot.new(params[:robot])
    @output = @robot.report
    @output.present? ? render(:index) : render(:new)
  end
end
