module Documents
  class Form1099bsController < DocumentUploadQuestionController
    def self.show?(intake)
      document_type.relevant_to? intake
    end

    def self.document_type
      DocumentTypes::Form1099B
    end
  end
end
