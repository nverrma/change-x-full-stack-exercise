# frozen_string_literal: true

# Controller for CRUD management of Applicants
class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[show edit update destroy]

  # GET /applicants
  def index
    @applicants = Applicant.includes(:project).order(:name)
  end

  # GET /applicants/1
  def show; end

  # GET /applicants/new
  def new
    @applicant = Applicant.new
  end

  # GET /applicants/1/edit
  def edit
    @comment = @applicant.comments.build
  end

  # POST /applicants
  def create
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      redirect_to @applicant, notice: 'Applicant was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applicants/1
  def update
    set_applicants_comment_instance if verify_status_change?
    if @applicant.errors.blank? && @applicant.update(applicant_params.except(:comment))
      redirect_to @applicant, notice: 'Applicant was successfully updated.'
    else
      @comment = @applicant.comments.build
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /applicants/1
  def destroy
    @applicant.destroy
    redirect_to applicants_url, notice: 'Applicant was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def set_applicants_comment_instance
    if applicant_params[:comment] && applicant_params[:comment][:body].blank?
      @applicant.errors.add(:base, "Reason for updating status can't be blank") and return
    end

    @comment = @applicant.comments.build(status_changed_from: @applicant.status,
                                         status_changed_to: applicant_params[:status],
                                         body: applicant_params[:comment][:body])
  end

  def verify_status_change?
    return false if applicant_params[:status].blank? || applicant_params[:status] == @applicant.status

    true
  end

  # Only allow a list of trusted parameters through.
  def applicant_params
    params.require(:applicant).permit(:name, :overview, :funding, :project_id, :status,
                                      comment: [:body])
  end
end
