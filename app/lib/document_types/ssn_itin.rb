module DocumentTypes
  class SsnItin < DocumentType
    class << self
      def relevant_to?(_intake)
        true
      end

      def key
        "SSN or ITIN"
      end
    end
  end
end
