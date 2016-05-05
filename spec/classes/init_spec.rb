require 'spec_helper'
describe 'scaleio2' do

  context 'with defaults for all parameters' do
    it { should contain_class('scaleio2') }
  end
end
