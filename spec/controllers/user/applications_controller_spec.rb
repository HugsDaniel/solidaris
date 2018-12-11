require 'rails_helper'

describe User::ApplicationsController do
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:manager) { create(:manager) }
    let(:organization) { create(:organization, manager: manager) }
    let(:mission) { create(:mission, organization: organization) }

    context "when user is not logged in" do
      it "redirects to new session" do
        post :create, params: { mission_id: mission.id }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when user is logged in" do
      before do
        sign_in user
      end

      it "creates an application for this user" do
        expect {
           post :create, params: { mission_id: mission.id }
        }.to change(Application, :count).by 1
      end

      it "redirects to user missions" do
        post :create, params: { mission_id: mission.id }
        expect(response).to redirect_to account_missions_path
      end
    end
  end
end
