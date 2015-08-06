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

# Create single page that accepts text commands in text area
#
# Mocks:
# Toy Robot Simulator
#
# Grid size | 5x5 |
#
# |======================|    Ctrl+Shift+N : NORTH
# |                      |    Ctrl+Shift+S : SOUTH
# |                      |    Ctrl+Shift+W : WEST
# |                      |    Ctrl+Shift+E : EAST
# |                      |
# |                      |
# |                      |
# |======================|
# WARNING Message / REPORT Message
#
# |--------------|
# | Post Command |
# |--------------|
#
