require 'spec_helper'

describe RobotsController, :type => :controller do

  describe "GET new" do
    it "should render new template" do
      get :new
      assigns(:robot).should_not be_nil
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "should render the new template" do
        post :create, :robot => { :commands => "PLACE 0,0,NORTH MOVE" }
        expect(response).to render_template(:new)
      end
    end

    describe "with invalid params" do
      it "should re-render new template" do
        post :create, :robot => {}
        expect(response).to render_template(:new)
      end
    end
  end

end
