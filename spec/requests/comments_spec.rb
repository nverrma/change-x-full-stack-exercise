require 'rails_helper'

RSpec.describe '/comments' do
  let(:fund) do
    Fund.create!(
      title: 'Fund',
      total: 10_000
    )
  end

  let(:project) do
    Project.create!(
      payment_date: Date.current + 1.month,
      title: 'Project',
      fund:
    )
  end

  let(:applicant) do
    Applicant.create!(
      name: 'Applicant Name',
      overview: 'Overview',
      funding: 500,
      project_id: project.id,
      status: 'initial_review'
    )
  end

  let(:valid_attributes) do
    {
      body: 'Some Comment',
      applicant_id: applicant.id,
      status_changed_from: 'applied',
      status_changed_to: 'initial_review',
    }
  end

  describe 'GET /index' do
    it 'returns http success' do
      Comment.create! valid_attributes
      get comments_path, params: { applicant_id: applicant.id }
      expect(response).to have_http_status(:success)
    end
  end
end
