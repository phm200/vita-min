module DocumentTypes
  class Form1095A < DocumentType
    class << self
      def relevant_to?(intake)
        intake.bought_health_insurance_yes?
      end

      def key
        "1095-A"
      end
    end
  end
end
