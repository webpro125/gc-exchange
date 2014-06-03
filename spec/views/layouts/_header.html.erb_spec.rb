require 'rspec'

describe 'layouts/_header.html.erb' do
  it 'should render "Global Consultant Exchange" in the header' do
    render
    rendered.should include("Global Consultant Exchange")
  end
end
