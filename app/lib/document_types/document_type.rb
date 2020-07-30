module DocumentTypes
  class DocumentType
    class << self
      def relevant_to?(_intake)
        raise NotImplementedError "Child classes must define when they are relevant to an intake"
      end

      def key
        raise NotImplementedError "A key must be defined in child classes"
      end
    end
  end
end
