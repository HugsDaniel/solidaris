require 'rails_helper'

feature 'Any user' do
  let!(:mission_one) { create(:mission_with_organization) }
  let!(:mission_two) { create(:mission_with_organization) }

  scenario 'can see missions and mission details' do
    visit missions_path

    expect(page).to have_content mission_one.title
    expect(page).to have_content mission_two.title

    find(:xpath, "//a[@href='/missions/#{mission_one.id}']").click

    expect(current_path).to eq mission_path(mission_one)
    expect(page).to have_content mission_one.title
    expect(page).to have_content mission_one.description
  end

  scenario 'can see organizations details' do
    organization = mission_one.organization

    visit mission_path(mission_one)

    click_link 'En savoir plus'

    expect(current_path).to eq organization_path(organization)
    expect(page).to have_content organization.name
    expect(page).to have_content organization.description
  end

  scenario 'cannot subscribe to a mission' do
    visit mission_path(mission_one)

    click_link 'Participer à cette mission'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Vous devez vous connecter ou vous inscrire pour continuer.'
  end
end
