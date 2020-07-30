module Documents
  class StudentAccountStatementsController < DocumentUploadQuestionController
    def edit
      @student_names = current_intake.student_names
      super
    end

    def self.document_type
      DocumentTypes::StudentAccountStatement
    end
  end
end
