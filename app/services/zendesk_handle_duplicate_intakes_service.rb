class ZendeskHandleDuplicateIntakesService
  include ZendeskServiceHelper

  def instance
    EitcZendeskInstance
  end

  def find_primary(intake_ids)
    intakes_with_tickets = Intake.where.not(intake_ticket_id: nil).find(intake_ids)

    # Primary ticket cannot be closed or "not filing"
    intakes_with_tickets.reject do |intake|
      ticket = get_ticket(ticket_id: intake.intake_ticket_id)

      intake_status = ticket.fields.detect { |f| f.id == EitcZendeskInstance::INTAKE_STATUS.to_i }.value
      ticket.status == "closed" || intake_status == EitcZendeskInstance::INTAKE_STATUS_NOT_FILING
    end

    # First we look for finished intakes
    completed_intakes = intakes_with_tickets.select(&:completed_intake_sent_to_zendesk)
    return completed_intakes.first if completed_intakes.length == 1

    if completed_intakes.empty?
      intakes_with_preliminary_pdf = intakes_with_tickets.select(&:intake_pdf_sent_to_zendesk)
      return intakes_with_preliminary_pdf.first if intakes_with_preliminary_pdf.length == 1

      # tbd
    else
      #  more than one completed intake
    end
  end

  # features:
  # dry run
  # manually assign primary intake
  #
  # disqualifiers:
  # closed
  # not filing
  #
  # criteria:
  # final pdf sent
  # initial pdf sent
  #
  # tie-breakers:
  # number of documents
  # ticket status
  # number of attributes
  # dates (created/updated)
  # most recently active ticket
end