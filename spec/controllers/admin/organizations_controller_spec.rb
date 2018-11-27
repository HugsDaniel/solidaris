require 'rails_helper'

describe Admin::OrganizationsController do
  let(:manager) { create(:manager) }
  let(:organization) { create(:organization, manager: manager) }

  describe "GET #index" do
    context "when user is not manager" do
      it "redirects somewhere"
    end

    context "when user is manager" do
      before do
        sign_in manager
      end

      it "renders index template" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns organization missions to @missions" do
        get :index
        expect(assigns(:organizations)).to eq [organization]
      end
    end
  end

  describe "GET #show" do
    context "when user is not manager" do
      it "redirects somewhere"
    end

    context "when user is manager" do
      before :each do
        sign_in manager
      end

      it "assigns organization to @organization" do
        get :show, params: { id: organization }
        expect(assigns(:organization)).to eq organization
      end

      it "renders show template" do
        get :show, params: { id: organization }
        expect(response).to render_template :show
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
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    before :each do
      sign_in manager
    end

    context " with valid attributes" do
      it "saves the organization in database" do
        expect{
          post :create, params: {  organization: attributes_for(:organization) }
        }.to change(Organization, :count). by 1
      end

      it "redirects to organization #show" do
        post :create, params: {  organization: attributes_for(:organization) }
        expect(response). to redirect_to organization_path(assigns(:organization))
      end
    end

    context "with invalid attributes" do
      it "does not save the organization in database" do
        expect{
          post :create, params: { organization: attributes_for(:invalid_organization) }
        }.not_to change(Organization, :count)
      end

      it "renders the new template" do
        post :create, params: { organization: attributes_for(:invalid_organization) }
        expect(response). to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before :each do
      @organization = create(:organization,
        name: "Emmaus",
        category: "Hebergement",
        manager: manager
      )
      sign_in manager
    end

    context "with valid attributes" do
      it "locates the requested @organization" do
        patch :update, params: { id: @organization, organization: attributes_for(:organization) }
        expect(assigns(:organization)).to eq(@organization)
      end

      it "changes @organization attributes" do
        patch :update, params: {
          id: @organization,
          organization: attributes_for(:organization,
          category: 'Collecte',
          name: 'Horizon')
        }

        @organization.reload
        expect(@organization.category).to eq('Collecte')
        expect(@organization.name).to eq('Horizon')
      end

      it "redirects to admin missions index" do
        patch :update, params: { id: @organization, organization: attributes_for(:organization) }
        expect(response).to redirect_to organization_path(assigns(:organization))
      end
    end

    context "with invalid attributes" do
      it "does not changes @organization attributes" do
        patch :update, params: {
          id: @organization,
          organization: attributes_for(:organization,
          name: nil,
          address: 'Paris')
        }

        @organization.reload
        expect(@organization.address).not_to eq('Paris')
        expect(@organization.name).to eq('Emmaus')
      end

      it "renders edit template" do
        patch :update, params: { organization_id: organization, id: @organization, organization: attributes_for(:invalid_organization) }
        expect(response).to render_template :edit
      end
    end
  end
end
