require 'rspec'

describe 'layouts/_header.html.erb' do
  before do
    assign(:search, Search.new)
    render
  end

  describe 'logged in' do
    it 'should render "Login"' do
      rendered.should include('Login')
    end

    it 'should render "Register"' do
      rendered.should include('Register')
    end
  end
end
