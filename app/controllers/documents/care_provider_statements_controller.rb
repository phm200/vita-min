module Documents
  class CareProviderStatementsController < DocumentUploadQuestionController
    def self.show?(intake)
      document_type.relevant_to? intake
    end

    def self.document_type
      DocumentTypes::CareProviderStatement
    end
  end
end
