require 'rails_helper'

RSpec.describe Ong::VolunteerPolicy, type: :policy do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:ong) { create(:ong, user:) }
  let!(:action) { create(:action, ong:) }
  let!(:volunteer) { create(:volunteer, action:) }

  subject { described_class }

  permissions :index? do
    it 'allows access for any user' do
      expect(subject).to permit(user, volunteer)
      expect(subject).to permit(other_user, volunteer)
    end
  end

  permissions :confirm_presence? do
    it 'allows access if the user belongs to the same ong' do
      expect(subject).to permit(user, volunteer)
    end

    it 'denies access if the user does not belong to the same ong' do
      expect(subject).not_to permit(other_user, volunteer)
    end
  end
end
