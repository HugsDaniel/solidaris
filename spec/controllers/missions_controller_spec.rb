require 'rails_helper'

describe MissionsController do
  let!(:mission) { create(:mission, starting_at: Date.strptime("26.11.2018", '%d.%m.%Y')) }
  let!(:mission_outside_of_params) { create(:current_mission, category: "Hebergement", address: "Paris", starting_at: Date.strptime("30.11.2018", '%d.%m.%Y'))}

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end

    it "populates an array of all missions" do
      get :index
      expect(assigns(:missions)).to eq [mission_outside_of_params, mission]
    end

    context "with params[:category]" do
      it "populates an array of missions with the category" do
        get :index, params: { category: "Collecte" }
        expect(assigns(:missions)).to eq [mission]
      end
    end

    context "with params[:address]" do
      it "populates an array of missions with the address" do
        get :index, params: { address: "Nantes" }
        expect(assigns(:missions)).to eq [mission]
      end
    end

    context "with params[:recurrency]" do
      it "populates an array of missions with the recurrency" do
        get :index, params: { recurrency: "ponctuel" }
        expect(assigns(:missions)).to eq [mission]
      end
    end

    context "with params[:time_range]" do
      it "populates an array of missions with the time_range" do
        get :index, params: { time_range: "25.11.2018 au 27.11.2018" }
        expect(assigns(:missions)).to eq [mission]
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested mission to @mission" do
      get :show, params: { id: mission }
      expect(assigns(:mission)).to eq mission
    end

    it "assigns the mission's organization to @organization" do
      get :show, params: { id: mission }
      expect(assigns(:organization)).to eq mission.organization
    end
  end
end
