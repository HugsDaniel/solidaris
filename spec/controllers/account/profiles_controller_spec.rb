require 'rails_helper'

describe Account::ProfilesController do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #edit" do
    it "assigns current user to @user" do
      get :edit
      expect(assigns(:user)).to eq user
    end
  end

  describe "POST #update" do
    it "updates user params" do
      post :update, params: { user: attributes_for(:user, first_name: "Odilon") }
      user.reload
      expect(user.first_name).to eq "Odilon"
    end
  end
end
