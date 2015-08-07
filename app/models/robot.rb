class Robot
  include ActiveModel::Model

  attr_accessor :size_grid, :max_x, :max_y, :x, :y, :f, :commands, :report

  def initialize(params={})
    @x = params[:x]
    @y = params[:y]
    @f = params[:f]
    @size_grid = params[:size_grid] || "5x5"
    @max_x, @max_y = @size_grid.split('x').map(&:to_i)
    @commands = params[:commands]
    @report = nil
  end

  def execute_commands!
    commands = @commands.gsub(/\r\n/,' ')
    commands = commands.to_s.upcase.split(' ')
    commands.each_with_index do |command, index|
      case command
      when 'PLACE'
        placing_initial_coordinates(commands[index+1])
      when 'MOVE'
        move_into_new_position
      when 'LEFT'
        change_direction('LEFT')
      when 'RIGHT'
        change_direction('RIGHT')
      when 'REPORT'
        generate_report
        break
      end
    end
    check_warning!
  end

  private

    def placing_initial_coordinates(args)
      @x, @y, @f = args.split(',')
    end

    def move_into_new_position
      @x = @x.to_i
      @y = @y.to_i
      case @f
      when 'NORTH'
        @y = @y+1 unless (@y+1) > (@max_y - 1)
      when 'WEST'
        @x = @x-1 unless (@x-1) < 0
      when 'SOUTH'
        @y = @y-1 unless (@y-1) < 0
      when 'EAST'
        @x = @x+1 unless (@x+1) > (@max_x -1)
      end
    end

    def change_direction(direction)
      case @f
      when 'NORTH'
        @f = direction.eql?('LEFT') ? 'WEST' : 'EAST'
      when 'WEST'
        @f = direction.eql?('LEFT') ? 'SOUTH' : 'NORTH'
      when 'SOUTH'
        @f = direction.eql?('LEFT') ? 'EAST' : 'WEST'
      when 'EAST'
        @f = direction.eql?('LEFT') ? 'NORTH' : 'SOUTH'
      end
    end

    def generate_report
      @report = @x && @y && @f ? "#{@x},#{@y},#{@f}" : "You need to place the robot first"
    end

    def check_warning!
      errors.add(:warning, 'Your robot is on the edge of the cliff') if @x == (@max_x - 1) || @y == (@max_y - 1) || @x == 0 || @y == 0
    end
end



#
#  |0|1|2|3|4|
#  -----------
# 4| |^| | | |
#  -----------
# 3| | | | | |
#  -----------
# 2| | | | | |
#  -----------
# 1| | | | | |
#  -----------
# 0| | | | | |
#  -----------
#
#  PLACE 0,0,NORTH MOVE REPORT
#  Output: 0,1,NORTH
#
#  PLACE 0,0,NORTH LEFT REPORT
#  Output: 0,0,WEST
#
# PLACE 1,2,EAST MOVE
# MOVE
# LEFT
# MOVE
# REPORT
#
# Web page [DONE]
# Drawing the robot [DONE]
# Drawing the arrow direction [DONE]
# Navigation buttons
#
# Validations
#     ignoring if there NO Robot in the Table
#     detection if on the cliff
#     minimum size_grid is 2x2
# Rspec
#   robot controller
#   robot model [DONE]
