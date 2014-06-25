require 'rspec'

describe 'layouts/_header.html.erb' do
  describe 'logged in' do
    it 'should render "Login"' do
      render
      rendered.should include('Login')
    end

    it 'should render "Register"' do
      render
      rendered.should include('Register')
    end
  end

  describe 'not logged in' do
    it 'should render "Global Consultant Exchange" in the header' do
      render
      rendered.should include('Global Consultant Exchange')
    end
  end
end
