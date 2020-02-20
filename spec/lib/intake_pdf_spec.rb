require "rails_helper"

RSpec.describe IntakePdf do
  include PdfSpecHelper

  let(:intake_pdf) { IntakePdf.new(intake) }

  describe "#output_file" do
    context "with an empty intake record" do
      let(:intake) { create :intake }

      it "returns a pdf with default fields and values" do
        output_file = intake_pdf.output_file
        result = filled_in_values(output_file.path)
        expect(result).to eq({
          "first_name" => nil,
          "middle_initial" => nil,
          "last_name" => nil,
          "date_of_birth" => nil,
          "job" => nil,
          "spouse_first_name" => nil,
          "spouse_middle_initial" => nil,
          "spouse_last_name" => nil,
          "spouse_date_of_birth" => nil,
          "spouse_job" => nil,

          "street_address" => "",
          "apt" => nil,
          "city" => "",
          "state" => "",
          "zip_code" => "",
          "phone_number" => nil,
          "email" => nil,
          "multistate" => "",

          "on_visa" => "",
          "spouse_on_visa" => "",
          "not_on_visa" => "",
          "student" => "",
          "spouse_student" => "",
          "not_student" => "",
          "blind" => "",
          "spouse_blind" => "",
          "not_blind" => "",
          "disabled" => "",
          "spouse_disabled" => "",
          "not_disabled" => "",
          "issued_pin" => "",
          "spouse_issued_pin" => "",
          "not_issued_pin" => "",

          "refund_deposit" => nil,
          "refund_check" => nil,
          "savings_split_refund" => nil,
          "savings_purchase_bond" => nil,
          "savings_other" => nil,
          "balance_due_transfer" => nil,

          "never_married" => "",
          "married" => "",
          "lived_with_spouse" => "",
          "divorced" => "",
          "divorced_date" => "",
          "separated" => "",
          "separated_date" => "",
          "widowed" => "",
          "widowed_date" => "",

          "dependent_1_name" => nil,
          "dependent_1_date_of_birth" => nil,
          "dependent_1_relationship" => nil,
          "dependent_1_months_in_home" => nil,
          "dependent_1_marital_status" => nil,
          "dependent_1_on_visa" => nil,
          "dependent_1_north_american_resident" => nil,
          "dependent_1_student" => nil,
          "dependent_1_disabled" => nil,
          "dependent_2_name" => nil,
          "dependent_2_date_of_birth" => nil,
          "dependent_2_relationship" => nil,
          "dependent_2_months_in_home" => nil,
          "dependent_2_marital_status" => nil,
          "dependent_2_on_visa" => nil,
          "dependent_2_north_american_resident" => nil,
          "dependent_2_student" => nil,
          "dependent_2_disabled" => nil,
          "dependent_3_name" => nil,
          "dependent_3_date_of_birth" => nil,
          "dependent_3_relationship" => nil,
          "dependent_3_months_in_home" => nil,
          "dependent_3_marital_status" => nil,
          "dependent_3_on_visa" => nil,
          "dependent_3_north_american_resident" => nil,
          "dependent_3_student" => nil,
          "dependent_3_disabled" => nil,
          "dependent_4_name" => nil,
          "dependent_4_date_of_birth" => nil,
          "dependent_4_relationship" => nil,
          "dependent_4_months_in_home" => nil,
          "dependent_4_marital_status" => nil,
          "dependent_4_on_visa" => nil,
          "dependent_4_north_american_resident" => nil,
          "dependent_4_student" => nil,
          "dependent_4_disabled" => nil,

          "english_conversation_very_well" => nil,
          "english_conversation_well" => nil,
          "english_conversation_not_well" => nil,
          "english_conversation_not_at_all" => nil,
          "english_conversation_no_answer" => nil,
          "english_newspaper_very_well" => nil,
          "english_newspaper_well" => nil,
          "english_newspaper_not_well" => nil,
          "english_newspaper_not_at_all" => nil,
          "english_newspaper_no_answer" => nil,
          "anyone_disabled_yes" => nil,
          "anyone_disabled_no" => nil,
          "anyone_disabled_no_answer" => nil,
          "anyone_veteran_yes" => nil,
          "anyone_veteran_no" => nil,
          "anyone_veteran_no_answer" => nil,
          "race_american_indian_alaskan_native" => nil,
          "race_asian" => nil,
          "race_black_african_american" => nil,
          "race_native_hawaiian_pacific_islander" => nil,
          "race_white" => nil,
          "race_no_answer" => nil,
          "spouse_race_american_indian_alaskan_native" => nil,
          "spouse_race_asian" => nil,
          "spouse_race_black_african_american" => nil,
          "spouse_race_native_hawaiian_pacific_islander" => nil,
          "spouse_race_white" => nil,
          "spouse_race_no_answer" => nil,
          "ethnicity_hispanic" => nil,
          "ethnicity_not_hispanic" => nil,
          "ethnicity_no_answer" => nil,
          "spouse_ethnicity_hispanic" => nil,
          "spouse_ethnicity_not_hispanic" => nil,
          "spouse_ethnicity_no_answer" => nil,

          "had_wages" => "",
          "job_count" => "",
          "had_tips" => "",
          "had_retirement_income" => "",
          "had_social_security_income" => "",
          "had_unemployment_income" => "",
          "had_disability_income" => "",
          "had_interest_income" => "",
          "had_asset_sale_income" => "",
          "reported_asset_sale_loss" => "",
          "received_alimony" => "",
          "had_rental_income" => "",
          "had_farm_income" => "",
          "had_gambling_income" => "",
          "had_local_tax_refund" => "",
          "had_self_employment_income" => "",
          "reported_self_employment_loss" => "",
          "had_other_income" => "",
          "other_income_types" => "",
          "paid_mortgage_interest" => "",
          "paid_local_tax"  => "",
          "paid_medical_expenses" => "",
          "paid_charitable_contributions" => "",
          "paid_student_loan_interest" => "",
          "paid_dependent_care" => "",
          "paid_retirement_contributions" => "",
          "paid_school_supplies" => "",
          "paid_alimony" => "",
          "had_student_in_family" => "",
          "sold_a_home" => "",
          "had_hsa" => "",
          "bought_health_insurance" => "",
          "received_homebuyer_credit" => "",
          "bought_energy_efficient_items" => nil,
          "had_debt_forgiven" => "",
          "had_disaster_loss" => "",
          "adopted_child" => "",
          "had_tax_credit_disallowed" => "",
          "received_irs_letter" => "",
          "made_estimated_tax_payments" => "",
          "additional_info" => "",
        })
      end
    end

    context "with a complete intake record" do
      let(:intake) do
        create(
          :intake,
          street_address: "789 Garden Green Ln",
          city: "Gardenia",
          state: "nj",
          zip_code: "08052",
          multiple_states: "yes",
          ever_married: "yes",
          married: "yes",
          lived_with_spouse: "yes",
          divorced: "no",
          divorced_year: "2015",
          separated: "no",
          separated_year: "2016",
          widowed: "no",
          widowed_year: "2017",
          had_wages: "yes",
          had_tips: "yes",
          had_retirement_income: "yes",
          had_social_security_income: "yes",
          had_unemployment_income: "yes",
          had_disability_income: "no",
          had_interest_income: "yes",
          had_asset_sale_income: "yes",
          reported_asset_sale_loss: "yes",
          received_alimony: "yes",
          had_rental_income: "yes",
          had_farm_income: "no",
          had_gambling_income: "yes",
          had_local_tax_refund: "yes",
          had_self_employment_income: "yes",
          reported_self_employment_loss: "yes",
          had_other_income: "yes",
          other_income_types: "garden gnoming",
          paid_mortgage_interest: "no",
          paid_local_tax: "yes",
          paid_medical_expenses: "yes",
          paid_charitable_contributions: "yes",
          paid_student_loan_interest: "yes",
          paid_dependent_care: "no",
          paid_retirement_contributions: "yes",
          paid_school_supplies: "yes",
          paid_alimony: "yes",
          had_student_in_family: "no",
          sold_a_home: "no",
          had_hsa: "no",
          bought_health_insurance: "yes",
          received_homebuyer_credit: "yes",
          had_debt_forgiven: "yes",
          had_disaster_loss: "yes",
          adopted_child: "no",
          had_tax_credit_disallowed: "yes",
          received_irs_letter: "no",
          made_estimated_tax_payments: "yes",
          additional_info: "if there is another gnome living in my garden but only i have an income, does that make me head of household?",
          demographic_disability: "yes",
          demographic_english_conversation: "well",
          demographic_english_reading: "not_well",
          demographic_primary_american_indian_alaska_native: false,
          demographic_primary_asian: false,
          demographic_primary_black_african_american: false,
          demographic_primary_ethnicity: "not_hispanic_latino",
          demographic_primary_native_hawaiian_pacific_islander: true,
          demographic_primary_prefer_not_to_answer_race: nil,
          demographic_primary_white: true,
          demographic_questions_opt_in: "yes",
          demographic_spouse_american_indian_alaska_native: true,
          demographic_spouse_asian: false,
          demographic_spouse_black_african_american: false,
          demographic_spouse_ethnicity: "not_hispanic_latino",
          demographic_spouse_native_hawaiian_pacific_islander: false,
          demographic_spouse_prefer_not_to_answer_race: nil,
          demographic_spouse_white: false,
          demographic_veteran: "no",
          was_full_time_student: "no",
          was_on_visa: "no",
          had_disability: "yes",
          was_blind: "no",
          issued_identity_pin: "no",
          spouse_was_full_time_student: "yes",
          spouse_was_on_visa: "no",
          spouse_had_disability: "no",
          spouse_was_blind: "no",
          spouse_issued_identity_pin: "no",
        )
      end
      before do
        create(
          :user,
          intake: intake,
          first_name: "Hoofie",
          last_name: "Heifer",
          birth_date: "1961-04-19",
          email: "hoofie@heifer.horse",
          phone_number: "14158161286",
        )
        create(
          :spouse_user,
          intake: intake,
          first_name: "Hattie",
          last_name: "Heifer",
          birth_date: "1959-11-01",
        )
        create(
          :dependent,
          intake: intake,
          first_name: "Percy",
          last_name: "Pony",
          relationship: "Child",
          birth_date: Date.new(2005, 3, 2),
          months_in_home: 12,
          was_married: "no",
          disabled: "no",
          north_american_resident: "yes",
          on_visa: "no",
          was_student: "no"
        )
        create(
          :dependent,
          intake: intake,
          first_name: "Parker",
          last_name: "Pony",
          relationship: "Some kid at my house",
           birth_date: Date.new(2001, 12, 10),
          months_in_home: 4,
          was_married: "yes",
          disabled: "no",
          north_american_resident: "yes",
          on_visa: "no",
          was_student: "yes"
        )
        create(
          :dependent,
          intake: intake,
          first_name: "Penny",
          last_name: "Pony",
          relationship: "Progeny",
          birth_date: Date.new(2010, 10, 15),
          months_in_home: 12,
          was_married: "no",
          disabled: "yes",
          north_american_resident: "yes",
          on_visa: "yes",
          was_student: "no"
        )
        create(
          :dependent,
          intake: intake,
          first_name: "Polly",
          last_name: "Pony",
          relationship: "Baby",
          birth_date: Date.new(2018, 8, 27),
          months_in_home: 5,
          was_married: "no",
          disabled: "yes",
          north_american_resident: "yes",
          on_visa: "no",
          was_student: "no"
        )
      end

      it "returns a filled out pdf" do
        output_file = intake_pdf.output_file
        result = filled_in_values(output_file.path)
        expect(result).to eq({
          "first_name" => "Hoofie",
          "middle_initial" => nil,
          "last_name" => "Heifer",
          "date_of_birth" => "4/19/1961",
          "job" => nil,
          "spouse_first_name" => "Hattie",
          "spouse_middle_initial" => nil,
          "spouse_last_name" => "Heifer",
          "spouse_date_of_birth" => "11/1/1959",
          "spouse_job" => nil,

          "street_address" => "789 Garden Green Ln",
          "apt" => nil,
          "city" => "Gardenia",
          "state" => "NJ",
          "zip_code" => "08052",
          "phone_number" => "(415) 816-1286",
          "email" => "hoofie@heifer.horse",
          "multistate" => "Yes",

          "on_visa" => "",
          "spouse_on_visa" => "",
          "not_on_visa" => "Yes",
          "student" => "",
          "spouse_student" => "Yes",
          "not_student" => "",
          "blind" => "",
          "spouse_blind" => "",
          "not_blind" => "Yes",
          "disabled" => "Yes",
          "spouse_disabled" => "",
          "not_disabled" => "",
          "issued_pin" => "",
          "spouse_issued_pin" => "",
          "not_issued_pin" => "Yes",

          "refund_deposit" => nil,
          "refund_check" => nil,
          "savings_split_refund" => nil,
          "savings_purchase_bond" => nil,
          "savings_other" => nil,
          "balance_due_transfer" => nil,

          "never_married" => "",
          "married" => "Yes",
          "lived_with_spouse" => "Yes",
          "divorced" => "",
          "divorced_date" => "2015",
          "separated" => "",
          "separated_date" => "2016",
          "widowed" => "",
          "widowed_date" => "2017",

          "dependent_1_name" => "Percy Pony",
          "dependent_1_date_of_birth" => "3/2/2005",
          "dependent_1_relationship" => "Child",
          "dependent_1_months_in_home" => "12",
          "dependent_1_marital_status" => "S",
          "dependent_1_on_visa" => "N",
          "dependent_1_north_american_resident" => "Y",
          "dependent_1_student" => "N",
          "dependent_1_disabled" => "N",

          "dependent_2_name" => "Parker Pony",
          "dependent_2_date_of_birth" => "12/10/2001",
          "dependent_2_relationship" => "Some kid at my house",
          "dependent_2_months_in_home" => "4",
          "dependent_2_marital_status" => "M",
          "dependent_2_on_visa" => "N",
          "dependent_2_north_american_resident" => "Y",
          "dependent_2_student" => "Y",
          "dependent_2_disabled" => "N",

          "dependent_3_name" => "Penny Pony",
          "dependent_3_date_of_birth" => "10/15/2010",
          "dependent_3_relationship" => "Progeny",
          "dependent_3_months_in_home" => "12",
          "dependent_3_marital_status" => "S",
          "dependent_3_on_visa" => "Y",
          "dependent_3_north_american_resident" => "Y",
          "dependent_3_student" => "N",
          "dependent_3_disabled" => "Y",

          "dependent_4_name" => "Polly Pony",
          "dependent_4_date_of_birth" => "8/27/2018",
          "dependent_4_relationship" => "Baby",
          "dependent_4_months_in_home" => "5",
          "dependent_4_marital_status" => "S",
          "dependent_4_on_visa" => "N",
          "dependent_4_north_american_resident" => "Y",
          "dependent_4_student" => "N",
          "dependent_4_disabled" => "Y",

          "english_conversation_very_well" => "",
          "english_conversation_well" => "Yes",
          "english_conversation_not_well" => "",
          "english_conversation_not_at_all" => "",
          "english_conversation_no_answer" => "",
          "english_newspaper_very_well" => "",
          "english_newspaper_well" => "",
          "english_newspaper_not_well" => "Yes",
          "english_newspaper_not_at_all" => "",
          "english_newspaper_no_answer" => "",
          "anyone_disabled_yes" => "Yes",
          "anyone_disabled_no" => "",
          "anyone_disabled_no_answer" => "",
          "anyone_veteran_yes" => "",
          "anyone_veteran_no" => "Yes",
          "anyone_veteran_no_answer" => "",
          "race_american_indian_alaskan_native" => "",
          "race_asian" => "",
          "race_black_african_american" => "",
          "race_native_hawaiian_pacific_islander" => "Yes",
          "race_white" => "Yes",
          "race_no_answer" => "",
          "spouse_race_american_indian_alaskan_native" => "Yes",
          "spouse_race_asian" => "",
          "spouse_race_black_african_american" => "",
          "spouse_race_native_hawaiian_pacific_islander" => "",
          "spouse_race_white" => "",
          "spouse_race_no_answer" => "",
          "ethnicity_hispanic" => "",
          "ethnicity_not_hispanic" => "Yes",
          "ethnicity_no_answer" => "",
          "spouse_ethnicity_hispanic" => "",
          "spouse_ethnicity_not_hispanic" => "Yes",
          "spouse_ethnicity_no_answer" => "",

          "had_wages" => "Yes",
          "job_count" => "",
          "had_tips" => "Yes",
          "had_retirement_income" => "Yes",
          "had_social_security_income" => "Yes",
          "had_unemployment_income" => "Yes",
          "had_disability_income" => "",
          "had_interest_income" => "Yes",
          "had_asset_sale_income" => "Yes",
          "reported_asset_sale_loss" => "Yes",
          "received_alimony" => "Yes",
          "had_rental_income" => "Yes",
          "had_farm_income" => "",
          "had_gambling_income" => "Yes",
          "had_local_tax_refund" => "Yes",
          "had_self_employment_income" => "Yes",
          "reported_self_employment_loss" => "Yes",
          "had_other_income" => "Yes",
          "other_income_types" => "garden gnoming",
          "paid_mortgage_interest" => "",
          "paid_local_tax"  => "Yes",
          "paid_medical_expenses" => "Yes",
          "paid_charitable_contributions" => "Yes",
          "paid_student_loan_interest" => "Yes",
          "paid_dependent_care" => "",
          "paid_retirement_contributions" => "Yes",
          "paid_school_supplies" => "Yes",
          "paid_alimony" => "Yes",
          "had_student_in_family" => "",
          "sold_a_home" => "",
          "had_hsa" => "",
          "bought_health_insurance" => "Yes",
          "received_homebuyer_credit" => "Yes",
          "bought_energy_efficient_items" => nil,
          "had_debt_forgiven" => "Yes",
          "had_disaster_loss" => "Yes",
          "adopted_child" => "",
          "had_tax_credit_disallowed" => "Yes",
          "received_irs_letter" => "",
          "made_estimated_tax_payments" => "Yes",
          "additional_info" => "if there is another gnome living in my garden but only i have an income, does that make me head of household?",
        })
      end
    end
  end
end