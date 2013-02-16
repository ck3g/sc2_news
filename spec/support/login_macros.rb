module LoginMacros
  def login_admin
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:admin)
    end
  end
end
