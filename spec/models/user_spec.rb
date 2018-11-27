require 'rails_helper'

describe User do
  it "is valid with a firstname, lastname, email and password" do
    contact = User.new(
      first_name: 'Aaron',
      last_name: 'Sumner',
      email: 'tester@example.com',
      password: "password")

      expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = User.new(first_name: nil)
    contact.valid?
    expect(contact.errors[:first_name]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without a lastname" do
    contact = User.new(last_name: nil)
    contact.valid?
    expect(contact.errors[:last_name]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without an email address" do
    contact = User.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid without an a password" do
    contact = User.new(password: nil)
    contact.valid?
    expect(contact.errors[:password]).to include(I18n.t('errors.messages.blank'))
  end

  it "is invalid with a duplicate email address" do
    User.create(
      first_name: 'Joe', last_name: 'Tester',
      password: 'password',
      email: 'tester@example.com'
      )
    contact = User.new(
    first_name: 'Jane', last_name: 'Tester',
    password: 'password',
    email: 'tester@example.com'
    )

    contact.valid?
    expect(contact.errors[:email]).to include(I18n.t('errors.messages.taken'))
  end
end
