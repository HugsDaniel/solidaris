require 'rails_helper'

describe Application do
  let(:user) { create(:user) }
  let(:mission) { create(:mission) }

  it "is valid with a user and a mission" do
    application = Application.new(
      user: user,
      mission: mission
    )

    expect(application).to be_valid
  end

  it "is invalid without a user" do
    application = Application.new(user_id: nil)
    application.valid?
    expect(application.errors[:user]).to include("doit exister")
  end

  it "is invalid without a mission" do
    application = Application.new(mission_id: nil)
    application.valid?
    expect(application.errors[:mission]).to include("doit exister")
  end
end
