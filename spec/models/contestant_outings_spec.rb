require 'rails_helper'

describe ContestantOuting, type: :model do
  describe 'relationships' do
    it { should belong_to :contestant }
    it { should belong_to :outing }
  end
end
