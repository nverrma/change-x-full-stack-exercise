# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def project_applicants(collection, project_title)
    project = collection.find_by(title: project_title)
    applicants = project.applicants.where(status: 'approved')

    applicants.map(&:name).join(', ')
  end
end
