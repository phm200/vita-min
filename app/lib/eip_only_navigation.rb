class EipOnlyNavigation
  FLOW = [
    # Overview
    Questions::EipOverviewController, # FilingMightHelpController assumes this is the start of the EIP-only flow

    Questions::EnvironmentWarningController,

    # EIP Eligibility
    Questions::EipEligibilityController,
    Questions::EipMaybeIneligibleController,

    # Contact information
    Questions::PersonalInfoController,
    Questions::ChatWithUsController,
    Questions::PhoneNumberController,
    Questions::EmailAddressController,
    Questions::ReturningClientController, # possible off-boarding from flow
    Questions::NotificationPreferenceController,

    # Consent
    Questions::ConsentController, # create Zendesk ticket

    # Primary filer personal information
    Questions::IssuedIdentityPinController,

    # Marital Status
    Questions::EverMarriedController, # Begins requiring ZD ticket

    # Filing status
    Questions::FilingJointController,

    # Spouse email
    Questions::SpouseEmailAddressController,

    # Spouse personal information
    Questions::SpouseConsentController,
    Questions::SpouseIssuedIdentityPinController,

    # Dependents
    Questions::HadDependentsController,

    # Additional Information
    Questions::AdditionalInfoController, # appends 13614-C & consent PDF to Zendesk ticket

    # Documents
    Documents::IdGuidanceController,
    Documents::IdsController,
    Documents::SelfieInstructionsController,
    Documents::SelfiesController,
    Documents::SsnItinsController,

    # Interview time preferences
    Questions::InterviewSchedulingController,

    # Payment info
    Questions::RefundPaymentController,
    Questions::BankDetailsController,
    Questions::MailingAddressController,

    # Optional Demographic Questions
    Questions::DemographicQuestionsController,
    Questions::DemographicEnglishConversationController,
    Questions::DemographicEnglishReadingController,
    Questions::DemographicDisabilityController,
    Questions::DemographicVeteranController,
    Questions::DemographicPrimaryRaceController,
    Questions::DemographicSpouseRaceController,
    Questions::DemographicPrimaryEthnicityController,
    Questions::DemographicSpouseEthnicityController,

    # Additional Information
    Questions::FinalInfoController, # appends final 13614-C, bank details & docs to Zendesk
    Questions::SuccessfullySubmittedController,
    Questions::FeedbackController,
  ].freeze

  include ControllerNavigation
end
