module LoginMacros
  def log_in(user)
    visit missions_path
    click_link 'Se connecter'
    fill_in 'Courriel', with: user.email
    fill_in 'Mot de passe', with: user.password
    click_button 'Log in'
  end
end
