class Robot
  include ActiveModel::Model

  attr_accessor :first_command, :x_coordinate, :y_coordinate, :facing, :commands

  def initialize(params={})
    @first_command = params[:first_command]
    @x_coordinate = params[:x_coordinate]
    @y_coordinate = params[:y_coordinate]
    @facing = params[:facing]
    @commands = params[:commands]
  end

  def report
    output = result
    output if @first_command.eql?('PLACE') && output.present?
  end

  private

    def result
      commands = @commands.to_s.upcase.split(' ')
      commands.each do |command|
        case command
        when 'MOVE'
          calculate_coordinates
        when 'LEFT'
          determine_facing('LEFT')
        when 'RIGHT'
          determine_facing('RIGHT')
        when 'REPORT'
          @result = "#{@x_coordinate},#{@y_coordinate},#{@facing}"
          break
        end
      end
      @result ? @result : ''
    end

    def calculate_coordinates
      @x_coordinate = @x_coordinate.to_i
      @y_coordinate = @y_coordinate.to_i
      case @facing
      when 'NORTH'
        @y_coordinate = @y_coordinate+1
        @y_coordinate = @y_coordinate-1 if @y_coordinate > 4
      when 'WEST'
        @x_coordinate = @x_coordinate-1
        @x_coordinate = @x_coordinate+1 if @x_coordinate < 0
      when 'SOUTH'
        @y_coordinate = @y_coordinate-1
        @y_coordinate = @y_coordinate+1 if @y_coordinate < 0
      when 'EAST'
        @x_coordinate = @x_coordinate+1
        @x_coordinate = @x_coordinate-1 if @x_coordinate > 4
      end
    end

    def determine_facing(direction)
      case @facing
      when 'NORTH'
        @facing = direction.eql?('LEFT') ? 'WEST' : 'EAST'
      when 'WEST'
        @facing = direction.eql?('LEFT') ? 'SOUTH' : 'NORTH'
      when 'SOUTH'
        @facing = direction.eql?('LEFT') ? 'WEST' : 'EAST'
      when 'EAST'
        @facing = direction.eql?('LEFT') ? 'NORTH' : 'SOUTH'
      end
    end
end
