require 'rails_helper'

describe Organization do
  it "is valid with a name, description, kind, category, email, phone_number and manager" do
    organization = Organization.new(
      name: 'Emmaus',
      description: 'SUperbe asso de ouf malade, adorable',
      kind: "association",
      category: "Education",
      email: 'tester@example.com',
      phone_number: "0677889900",
      manager: create(:manager))

      expect(organization).to be_valid
  end

  it "is invalid without a name" do
    organization = Organization.new(name: nil)
    organization.valid?
    expect(organization.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without a description" do
    organization = Organization.new(description: nil)
    organization.valid?
    expect(organization.errors[:description]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without a kind" do
    organization = Organization.new(kind: nil)
    organization.valid?
    expect(organization.errors[:kind]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without a category" do
    organization = Organization.new(category: nil)
    organization.valid?
    expect(organization.errors[:category]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without an email" do
    organization = Organization.new(email: nil)
    organization.valid?
    expect(organization.errors[:email]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without a phone number" do
    organization = Organization.new(phone_number: nil)
    organization.valid?
    expect(organization.errors[:phone_number]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without a manager" do
    organization = Organization.new(manager_id: nil)
    organization.valid?
    expect(organization.errors[:manager]).to include(I18n.t('errors.messages.required'))
  end

  it "is invalid with a duplicate name" do
    Organization.create(
      name: 'Emmaus',
      description: 'SUperbe asso de ouf malade, adorable',
      kind: "association",
      category: "Education",
      email: 'tester@example.com',
      phone_number: "0677889900",
      manager: create(:manager))

    organization = Organization.new(
      name: 'Emmaus',
      description: 'SUperbe asso de ouf malade, adorable',
      kind: "association",
      category: "Education",
      email: 'tester@example.com',
      phone_number: "0677889900",
      manager: create(:manager))

    organization.valid?
    expect(organization.errors[:name]).to include(I18n.t('errors.messages.taken'))
  end
end
