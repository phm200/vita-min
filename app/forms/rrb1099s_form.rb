# frozen_string_literal: true

class Rrb1099sForm < QuestionsForm
  set_attributes_for :intake, :document

  def save
    document_file_upload = attributes_for(:intake)[:document]
    return unless document_file_upload.present?

    document = @intake.documents.create(document_type: "RRB-1099")
    document.upload.attach(document_file_upload)
  end
end