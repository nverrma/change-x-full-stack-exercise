# frozen_string_literal: true

# Controller for upcoming Payments
class PaymentsController < ApplicationController
  def index
    @projects = Project.includes(:applicants).where('payment_date > ?', Date.current)

    @dates = @projects.each_with_object(Hash.new { |k, v| k[v] = [] }) do |project, output|
      output[project.payment_date] << project.title
    end
  end
end
