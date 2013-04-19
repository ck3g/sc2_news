class WelcomeController < ApplicationController
  def hide_guest_instructions
    cookies[:hide_guest_instructions] = { value: true, expires: 1.year.from_now }
    redirect_to root_path
  end
end
