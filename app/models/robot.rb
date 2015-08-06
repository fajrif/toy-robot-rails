class Robot
  include ActiveModel::Model

  attr_accessor :size_grid, :x, :y, :f, :commands, :report

  def initialize(params={})
    @size_grid = params[:size_grid] || "5x5"
    @x = params[:x]
    @y = params[:y]
    @f = params[:f]
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
  end

  private

    def placing_initial_coordinates(args)
      @x, @y, @f = args.split(',')
    end

    def move_into_new_position
      _max_x, _max_y = @size_grid.split('x').map(&:to_i)
      @x = @x.to_i
      @y = @y.to_i
      case @f
      when 'NORTH'
        @y = @y+1
        if @y > _max_y
          @y = @y-1; warning!
        end
      when 'WEST'
        @x = @x-1
        if @x < 0
          @x = @x+1; warning!
        end
      when 'SOUTH'
        @y = @y-1
        if @y < 0
          @y = @y+1; warning!
        end
      when 'EAST'
        @x = @x+1
        if @x > _max_x
          @x = @x-1; warning!
        end
      end
    end

    def change_direction(direction)
      case @f
      when 'NORTH'
        @f = direction.eql?('LEFT') ? 'EAST' : 'WEST'
      when 'WEST'
        @f = direction.eql?('LEFT') ? 'NORTH' : 'SOUTH'
      when 'SOUTH'
        @f = direction.eql?('LEFT') ? 'WEST' : 'EAST'
      when 'EAST'
        @f = direction.eql?('LEFT') ? 'SOUTH' : 'NORTH'
      end
    end

    def generate_report
      @report = @x && @y && @f ? "#{@x},#{@y},#{@f}" : "You need to place the robot first"
    end

    def warning!
      errors.add(:warning, 'Your robot is on the edge of the cliff')
    end
end
