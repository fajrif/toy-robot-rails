require 'spec_helper'

# The tests are based on the Toy Robot Simulator examples
describe Robot do
  describe "#report" do
    context "when no inputs given" do
      let(:inputs) do
        Hashie::Mash.new(
          {
            first_command: '',
            x_coordinate: 0,
            y_coordinate: 0,
            facing: '',
            commands: ''
          }
        )
      end

      subject { Robot.new(inputs) }

      it "returns nil" do
        expect(subject.report).to eq(nil)
      end
    end

    context "when out of boundary" do
      let(:inputs) do
        Hashie::Mash.new(
          {
            first_command: 'PLACE',
            x_coordinate: 0,
            y_coordinate: 0,
            facing: 'NORTH',
            commands: 'LEFT MOVE REPORT'
          }
        )
      end

      subject { Robot.new(inputs) }

      it "returns 0,0,WEST" do
        expect(subject.report).to eq('0,0,WEST')
      end
    end

    context "PLACE 0,0,NORTH with MOVE" do
      let(:inputs) do
        Hashie::Mash.new(
          {
            first_command: 'PLACE',
            x_coordinate: 0,
            y_coordinate: 0,
            facing: 'NORTH',
            commands: 'MOVE REPORT'
          }
        )
      end

      subject { Robot.new(inputs) }

      it "returns 0,1,North" do
        expect(subject.report).to eq('0,1,NORTH')
      end
    end

    context "PLACE 0,0,NORTH with LEFT" do
      let(:inputs) do
        Hashie::Mash.new(
          {
            first_command: 'PLACE',
            x_coordinate: 0,
            y_coordinate: 0,
            facing: 'NORTH',
            commands: 'LEFT REPORT'
          }
        )
      end

      subject { Robot.new(inputs) }

      it "returns 0,0,West" do
        expect(subject.report).to eq('0,0,WEST')
      end
    end

    context "PLACE 1,2,EAST with MOVE MOVE LEFT MOVE" do
      let(:inputs) do
        Hashie::Mash.new(
          {
            first_command: 'PLACE',
            x_coordinate: 1,
            y_coordinate: 2,
            facing: 'EAST',
            commands: 'MOVE MOVE LEFT MOVE REPORT'
          }
        )
      end

      subject { Robot.new(inputs) }

      it "returns 3,3,NORTH" do
        expect(subject.report).to eq('3,3,NORTH')
      end
    end
  end
end