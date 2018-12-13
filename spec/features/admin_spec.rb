require 'rails_helper'

feature 'Manager' do
  let!(:user) { create(:user) }
  let!(:manager) { create(:manager) }
  let!(:organization) { create(:organization, manager: manager) }
  let!(:mission) { create(:mission, organization: organization) }

  scenario 'Non manager cannot access admin panel' do
    log_in user

    expect(page).not_to have_content 'Administration'
  end

  scenario 'can access admin panel' do
    log_in manager

    expect(page).to have_content 'Administration'
  end

  scenario 'can add a mission' do
    log_in manager

    visit new_admin_organization_mission_path(organization)

    expect {
      choose('mission_category_collecte')
      fill_in 'mission_starting_at', with: '12.12.2018'

      click_button 'Créer'
    }.to change(Mission, :count).by 1
  end

  scenario 'can see own organizations and their missions' do
    log_in manager

    click_link 'Administration'

    expect(current_path).to eq admin_organizations_path
    expect(page).to have_content organization.name
    expect(page).to have_content 'Voir les missions'

    click_link 'Voir les missions'

    expect(page).to have_content mission.title
  end

  scenario 'can manage own missions' do
    log_in manager

    visit admin_organization_missions_path(organization)

    first(:xpath, "//a[@href='/admin/organizations/#{organization.id}/missions/#{mission.id}']").click

    expect(current_path).to eq admin_organization_mission_path(organization, mission)
    expect(page).to have_content mission.title

    visit admin_organization_missions_path(organization)

    find(:xpath, "//a[@href='/admin/organizations/#{organization.id}/missions/#{mission.id}/edit']").click

    expect(current_path).to eq edit_admin_organization_mission_path(organization, mission)

    fill_in 'Title', with: 'Foo'
    click_button 'Enregistrer mes modifs'

    expect(current_path).to eq admin_organization_missions_path(organization)
    expect(page).to have_content 'Vos changements ont été enregistrés!'
    expect(page).to have_content 'Foo'

    expect {
      find(:xpath, "//a[@id='delete-mission']").click
    }.to change(Mission, :count).by(-1)
  end

  scenario 'can see the candidates for a mission' do
    log_in manager

    visit admin_organization_mission_path(organization, mission)
    expect(page).to have_content "Vous n'avez pas encore de candidats pour cette mission"

    Application.create(user: user, mission: mission)

    visit admin_organization_mission_path(organization, mission)
    expect(page).to have_content 'Candidat(s)'
    expect(page).to have_content user.first_name
  end
end
