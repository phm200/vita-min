module Questions
  class ConsentController < QuestionsController
    layout "application"

    def form_params
      super.merge(
        primary_consented_to_service_ip: request.remote_ip,
      )
    end

    def after_update_success
      if current_intake.eip_only
        CreateZendeskEipIntakeTicketJob.perform_later(current_intake.id)
      else
        CreateZendeskIntakeTicketJob.perform_later(current_intake.id)
      end
    end
  end
end
