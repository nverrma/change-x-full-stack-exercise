# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/index.html.erb' do
  let(:fund) do
    Fund.create!(
      title: 'Fund',
      total: 10_000
    )
  end

  let(:project) do
    Project.create!(
      payment_date: Date.current + 1.month,
      title: 'Project 1',
      fund:
    )
  end

  let(:project2) do
    Project.create!(
      payment_date: Date.current + 2.months,
      title: 'Project 2',
      fund:
    )
  end

  let(:project3) do
    Project.create!(
      payment_date: Date.current - 1.month,
      title: 'Project 3',
      fund:
    )
  end

  let(:projects) do
    Project.includes(:applicants).where('payment_date > ?', Date.current)
  end

  let(:dates) do
    projects.each_with_object(Hash.new { |k, v| k[v] = [] }) do |project, output|
      output[project.payment_date] << project.title
    end
  end

  before do
    Applicant.create!(
      name: 'Applicant 1',
      overview: 'Overview',
      funding: 500,
      project:,
      status: 0
    )

    Applicant.create!(
      name: 'Applicant 2',
      overview: 'Overview',
      funding: 500,
      project:,
      status: 4
    )

    Applicant.create!(
      name: 'Applicant 3',
      overview: 'Overview',
      funding: 500,
      project: project3,
      status: 4
    )

    project2

    assign(:projects, projects)
    assign(:dates, dates)
  end

  it 'renders a list of payments' do
    render

    cell_selector = 'tr>td'
    assert_select cell_selector, text: project.payment_date.to_s, count: 1
    assert_select cell_selector, text: project2.payment_date.to_s, count: 1
    assert_select cell_selector, text: project3.payment_date.to_s, count: 0
    assert_select cell_selector, text: 'Applicant 1', count: 0
    assert_select cell_selector, text: 'Applicant 2', count: 1
    assert_select cell_selector, text: 'Applicant 3', count: 0
    assert_select cell_selector, text: 'Project 1', count: 1
    assert_select cell_selector, text: 'Project 2', count: 1
    assert_select cell_selector, text: 'Project 3', count: 0
  end
end
