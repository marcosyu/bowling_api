require 'rails_helper'

RSpec.describe Match, type: :model do

  describe 'validations' do

    it { should validate_presence_of(:device_mac) }
    it { should validate_uniqueness_of(:device_mac) }

  end
end
