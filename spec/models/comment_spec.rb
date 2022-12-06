require 'rails_helper'

RSpec.describe Comment do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:status_changed_from) }
    it { is_expected.to validate_presence_of(:status_changed_to) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:applicant) }
  end
end
