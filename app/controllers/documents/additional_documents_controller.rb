module Documents
  class AdditionalDocumentsController < DocumentUploadQuestionController
    def self.show?(intake)
      document_type.relevant_to? intake
    end

    def self.document_type
      DocumentTypes::Other
    end
  end
end
