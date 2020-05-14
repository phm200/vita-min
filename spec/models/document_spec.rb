# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  document_type     :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  intake_id         :bigint
#  zendesk_ticket_id :bigint
#
# Indexes
#
#  index_documents_on_intake_id  (intake_id)
#

require "rails_helper"

describe Document do
  describe "validations" do
    let(:document) { build :document }

    it "requires essential fields" do
      document = Document.new

      expect(document).to_not be_valid
      expect(document.errors).to include :intake
      expect(document.errors).to include :document_type
    end

    describe "#document_type" do
      it "expects document_type to be a valid choice" do
        document.document_type = "Book Report"
        expect(document).not_to be_valid
        expect(document.errors).to include :document_type
      end
    end
  end

  describe "#safe?" do
    let(:intake) { create :intake }
    let(:document) do
      create :document,
            :with_upload,
            document_type: '1099-SA',
            intake: intake,
            upload_path: upload_path
    end

    context 'when the upload is missing' do
      it "returns true" do
        doc = create :document
        expect(doc.safe?).to be_truthy
      end
    end

    context 'when the upload is not infected' do
      let(:upload_path) { Rails.root.join('spec/fixtures/attachments/test-pattern.png') }

      it "returns true" do
        expect(document.safe?).to be_truthy
      end
    end

    context 'when the upload is infected' do
      let(:upload_path) { Rails.root.join('spec/fixtures/attachments/infected-file.com') }
      it "returns false" do
        expect(document.safe?).to be_falsey
      end
    end
  end
end
