module ControllerMacros
  def login_admin
    before do
      build :admin # Using blueprints gem for fixtures data
      sign_in @admin
    end
  end
end

# describe MyController do
#   login_admin
# 
#   it "should get index" do
#     get 'index'
#     response.should be_success
#   end
# end
