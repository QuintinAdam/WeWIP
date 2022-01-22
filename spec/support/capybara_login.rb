def login_as(user)
  visit '/users/sign-in'
  within("#new_account") do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
  end
  click_button 'Log in'
end
