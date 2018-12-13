require 'rails_helper'

feature 'User' do
  scenario 'can see own informations' do
    user = create(:user)
    log_in user

    visit missions_path

    click_link 'Profil'

    expect(current_path).to eq account_profile_path
    expect(page).to have_content user.first_name
    expect(page).to have_content user.email
    expect(page).to have_content user.experiences
    expect(page).to have_content user.description
    expect(page).to have_content user.skills
  end

  scenario 'can update own informations' do
    user = create(:user)
    log_in user

    visit account_profile_path

    click_link 'Editer votre profil'

    expect(current_path).to eq "/account/profile/edit.#{user.id}"

    fill_in 'First name', with: 'Fooo'
    click_button 'Enregistrer mes modifications'

    expect(current_path).to eq account_profile_path
    expect(page).to have_content 'Fooo'
  end
end
