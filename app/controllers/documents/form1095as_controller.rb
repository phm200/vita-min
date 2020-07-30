module Documents
  class Form1095asController < DocumentUploadQuestionController
    def self.show?(intake)
      document_type.relevant_to? intake
    end

    def self.document_type
      DocumentTypes::Form1095A
    end
  end
end
