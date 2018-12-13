require 'rails_helper'

feature 'Users' do
  scenario 'can sign up' do
    visit missions_path
    click_link "Se connecter"
    click_link "Sign up"

    expect {
      fill_in "Courriel", with: "newuser@example.com"
      fill_in 'Mot de passe', with: 'secret123'
      fill_in 'Confirmation du mot de passe', with: 'secret123'
      fill_in 'First name', with: 'New'
      fill_in 'Last name', with: 'User'

      click_button 'Sign up'
    }.to change(User, :count).by(1)

    expect(current_path).to eq missions_path
    expect(page).to have_content " Bienvenue ! Vous vous êtes enregistré(e) avec succès."
  end

  scenario 'can log in' do
    user = create(:user)
    # write the example!
    visit missions_path
    click_link "Se connecter"

    fill_in "Courriel", with: user.email
    fill_in "Mot de passe", with: user.password

    click_button 'Log in'

    expect(current_path).to eq missions_path
    expect(page).to have_content "Connecté"
  end

  scenario 'can log out' do
    user = create(:user)

    log_in(user)
    expect(page).to have_content "Connecté"

    click_link 'Log out'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Déconnecté.'
  end
end
