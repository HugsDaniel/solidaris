require 'rails_helper'

describe Account::MissionsController do
  describe "GET #index" do
    context "when user is not logged in" do
      it "redirects to new user session" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    let(:user) { create(:user) }
    let(:coming_mission) { create(:mission, starting_at: Date.today + 7) }
    let(:current_mission) { create(:current_mission) }
    let(:day_mission) { create(:mission, starting_at: Date.today) }
    
    context "when user is logged in" do
      before do
        sign_in user
        user.missions << coming_mission
        user.missions << current_mission
        user.missions << day_mission
        user.save
      end

      it "assigns coming missions to @coming_missions" do
        get :index
        expect(assigns(:coming_missions)).to eq [coming_mission]
      end

      it "assigns current missions to @current_missions" do
        get :index
        expect(assigns(:current_missions)).to eq [current_mission]
      end

      it "assigns day missions to @day_missions" do
        get :index
        expect(assigns(:day_missions)).to eq [day_mission]
      end
    end
  end
end
