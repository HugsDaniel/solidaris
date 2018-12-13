require 'rails_helper'

feature 'Mission application' do
  let!(:mission) { create(:mission_with_organization) }
  let!(:user) { create(:user) }

  scenario 'logged in user can subscribe to a mission' do
    log_in user

    visit mission_path(mission)

    expect {
      click_link 'Participer à cette mission'
    }.to change(Application, :count).by(1)

    expect(current_path).to eq account_missions_path
    expect(page).to have_content mission.title
  end

  scenario 'logged in user cannot subscribe to a mission he\'s already subscribed to' do
    log_in user

    visit mission_path(mission)
    click_link 'Participer à cette mission'

    visit mission_path(mission)

    expect(page).to have_content 'Vous participez déjà à cette mission !'
  end
end
