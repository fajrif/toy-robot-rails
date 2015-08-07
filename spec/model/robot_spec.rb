require 'spec_helper'

describe Robot do
  describe "Initialize robot" do
    context "when no params given" do
      let(:params) do
        Hashie::Mash.new(
          {
            commands: ''
          }
        )
      end

      subject { Robot.new(params) }

      it "returns nil" do
        expect(subject.report).to eq(nil)
        expect(subject.size_grid).to eq("5x5")
      end
    end

    context "when commands given without PLACE" do
      let(:params) do
        Hashie::Mash.new(
          {
            commands: 'LEFT MOVE REPORT'
          }
        )
      end

      subject { Robot.new(params) }

      it "returns NOTHING" do
        subject.execute_commands!
        expect(subject.errors.count).to eq(1)
        expect(subject.report).to eq(nil)
      end
    end

    context "PLACE 0,0,NORTH with MOVE" do
      let(:params) do
        Hashie::Mash.new(
          {
            commands: 'PLACE 0,0,NORTH MOVE REPORT'
          }
        )
      end

      subject { Robot.new(params) }

      it "returns 0,1,North" do
        subject.execute_commands!
        expect(subject.report).to eq('0,1,NORTH')
      end
    end

    context "PLACE 0,0,NORTH with LEFT" do
      let(:params) do
        Hashie::Mash.new(
          {
            commands: 'PLACE 0,0,NORTH with LEFT REPORT'
          }
        )
      end

      subject { Robot.new(params) }

      it "returns 0,0,West" do
        subject.execute_commands!
        expect(subject.report).to eq('0,0,WEST')
      end
    end

    context "PLACE 1,2,EAST with MOVE MOVE LEFT MOVE" do
      let(:params) do
        Hashie::Mash.new(
          {
            commands: 'PLACE 1,2,EAST with MOVE MOVE LEFT MOVE REPORT'
          }
        )
      end

      subject { Robot.new(params) }

      it "returns 3,3,NORTH" do
        subject.execute_commands!
        expect(subject.report).to eq('3,3,NORTH')
      end
    end
  end
end
