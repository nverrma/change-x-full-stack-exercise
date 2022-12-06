class CommentsController < ApplicationController
  before_action :applicant, only: [:index]

  def index
    @comments = @applicant.comments.order(created_at: :desc)
  end

  private

  def applicant
    @applicant ||= Applicant.find(params[:applicant_id])
  end
end
