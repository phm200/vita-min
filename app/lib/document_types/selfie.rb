module DocumentTypes
  class Selfie < DocumentType
    class << self
      def relevant_to?(_intake)
        true
      end

      def key
        "Selfie"
      end
    end
  end
end
