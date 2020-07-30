module Documents
  class Form1098sController < DocumentUploadQuestionController
    def self.show?(intake)
      document_type.relevant_to? intake
    end

    def self.document_type
      DocumentTypes::Form1098
    end
  end
end
