require 'spec_helper'

describe "profiles/index.html.slim" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
        :first_name => "First Name",
        :last_name => "Last Name"
      ),
      stub_model(Profile,
        :first_name => "First Name",
        :last_name => "Last Name"
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
  end
end
