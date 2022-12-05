require 'rails_helper'

RSpec.describe Applicant do
  describe 'Associations' do
    it { is_expected.to belong_to(:project) }
  end

  describe 'Model Methods' do
    let(:fund) do
      Fund.create!(
        title: 'Fund Title',
        total: 10_000
      )
    end

    let(:project) do
      Project.create!(
        payment_date: Date.current + 1.month,
        title: 'Project Title',
        fund:
      )
    end

    let(:applicant) do
      described_class.create!(
        name: 'Applicant Name',
        overview: 'Overview',
        funding: 500,
        project_id: project.id,
        status: 'initial_review'
      )
    end

    describe '#project_title' do
      it 'return the applicants project title' do
        expect(applicant.project_title).to eq applicant.project.title
      end
    end
  end
end
