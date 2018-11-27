require 'rails_helper'

describe OrganizationsController do
  let(:manager) { create(:manager) }
  let(:organization) { create(:organization, manager: manager) }

  describe "GET #index" do
    it "populates an array of all organizations" do
      get :index
      expect(assigns(:organizations)).to eq [organization]
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested organization to @organization" do
      get :show, params: { id: organization }
      expect(assigns(:organization)).to eq organization
    end

    it "renders the show template" do
      get :show, params: { id: organization }
      expect(response).to render_template :show
    end
  end
end
