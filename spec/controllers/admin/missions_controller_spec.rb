require 'rails_helper'

describe Admin::MissionsController do
  let(:manager) { create(:manager) }
  let(:organization) { create(:organization, manager: manager) }

  describe "GET #index" do
    context "when user is not manager" do
      it "redirects somewhere"
    end

    let!(:organization_mission) { create(:mission,
      starting_at: Date.strptime("26.11.2018", '%d.%m.%Y'),
      organization: organization)
    }
    let!(:organization_mission_unscoped) { create(:current_mission,
      category: "Hebergement",
      address: "Paris",
      starting_at: Date.strptime("30.11.2018", '%d.%m.%Y'),
      organization: organization)}
    let!(:non_organization_mission) { create(:mission, organization: create(:organization, manager: create(:manager))) }

    context "when user is manager" do
      before do
        sign_in manager
      end

      it "renders index template" do
        get :index, params: { organization_id: organization }
        expect(response).to render_template :index
      end

      context "with no params" do
        it "assigns organization missions to @missions" do
          get :index, params: { organization_id: organization }
          expect(assigns(:missions)).to eq [organization_mission, organization_mission_unscoped]
        end
      end

      context "with params[:category]" do
        it "populates an array of missions of given category" do
          get :index, params: { category: "Collecte", organization_id: organization }
          expect(assigns(:missions)).to eq [organization_mission]
        end
      end

      context "with params[:address]" do
        it "populates an array of missions with given address" do
          get :index, params: { address: "Nantes", organization_id: organization }
          expect(assigns(:missions)).to eq [organization_mission]
        end
      end

      context "with params[:recurrency]" do
        it "populates an array of missions with given recurrency" do
          get :index, params: { recurrency: "ponctuel", organization_id: organization }
          expect(assigns(:missions)).to eq [organization_mission]
        end
      end

      context "with params[:time_range]" do
        it "populates an array of missions within given time_range" do
          get :index, params: { time_range: "25.11.2018 au 27.11.2018", organization_id: organization }
          expect(assigns(:missions)).to eq [organization_mission]
        end
      end
    end
  end

  describe "GET #new" do
    context "when user is not manager" do
      it "redirects somewhere"
    end

    context "when user is manager" do
      before do
        sign_in manager
      end

      it "renders new template" do
        get :new, params: { organization_id: organization }
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    before do
      sign_in manager
    end

    context " with valid attributes" do
      it "saves the mission in database" do
        expect{
          post :create, params: {  organization_id: organization, mission: attributes_for(:mission) }
        }.to change(Mission, :count). by 1
      end

      it "redirects to missions #index" do
        post :create, params: {  organization_id: organization, mission: attributes_for(:mission) }
        expect(response). to redirect_to admin_organization_missions_path(organization)
      end
    end

    context "with invalid attributes" do
      it "does not save the mission in database" do
        expect{
          post :create, params: {  organization_id: organization, mission: attributes_for(:invalid_mission) }
        }.not_to change(Mission, :count)
      end

      it "renders new template" do
        post :create, params: {  organization_id: organization, mission: attributes_for(:invalid_mission) }
        expect(response). to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before :each do
      @mission = create(:mission,
        address: "Nantes",
        category: "Hebergement",
        organization: organization
      )
      sign_in manager
    end

    context "with valid attributes" do
      it "locates the requested @mission" do
        patch :update, params: { organization_id: organization, id: @mission, mission: attributes_for(:mission) }
        expect(assigns(:mission)).to eq(@mission)
      end

      it "changes @mission attributes" do
        patch :update, params: {
          organization_id: organization,
          id: @mission,
          mission: attributes_for(:mission,
          category: 'Collecte',
          address: 'Paris')
        }

        @mission.reload
        expect(@mission.category).to eq('Collecte')
        expect(@mission.address).to eq('Paris')
      end

      it "redirects to admin missions index" do
        patch :update, params: { organization_id: organization, id: @mission, mission: attributes_for(:mission) }
        expect(response).to redirect_to admin_organization_missions_path(organization)
      end
    end

    context "with invalid attributes" do
      it "does not changes @mission attributes" do
        patch :update, params: {
          organization_id: organization,
          id: @mission,
          mission: attributes_for(:mission,
          category: nil,
          address: 'Paris')
        }

        @mission.reload
        expect(@mission.address).not_to eq('Paris')
        expect(@mission.category).to eq('Hebergement')
      end

      it "renders edit template" do
        patch :update, params: { organization_id: organization, id: @mission, mission: attributes_for(:invalid_mission) }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destoy" do
    before :each do
      @mission = create(:mission, organization: organization)
      sign_in manager
    end

    it "deletes the mission" do
      expect{
        delete :destroy, params: {
          organization_id: organization, id: @mission
        }
      }.to change(Mission, :count).by(-1)
    end

    it "redirects to admin missions index" do
      delete :destroy, params: { organization_id: organization, id: @mission }
      expect(response).to redirect_to admin_organization_missions_path(organization)
    end
  end
end
