module Documents
  class Form1098tsController < DocumentUploadQuestionController
    def self.show?(intake)
      document_type.relevant_to? intake
    end

    def self.document_type
      DocumentTypes::Form1098T
    end
  end
end
