module DocumentTypes
  class Identity < DocumentType
    class << self
      def relevant_to?(_intake)
        true
      end

      def key
        "ID"
      end
    end
  end
end
