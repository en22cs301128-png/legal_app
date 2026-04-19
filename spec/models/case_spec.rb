require "rails_helper"

RSpec.describe Case, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      case_record = Case.new(
        title: "Smith vs Jones",
        status: "open",
        client_name: "John Smith"
      )
      expect(case_record).to be_valid
    end

    it "is invalid without a title" do
      case_record = Case.new(title: nil, status: "open", client_name: "John Smith")
      expect(case_record).not_to be_valid
      expect(case_record.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a client_name" do
      case_record = Case.new(title: "Test Case", status: "open", client_name: nil)
      expect(case_record).not_to be_valid
    end

    it "is invalid with an unknown status" do
      case_record = Case.new(title: "Test", status: "unknown", client_name: "Jane")
      expect(case_record).not_to be_valid
    end

    it "accepts valid statuses" do
      %w[open closed pending].each do |s|
        case_record = Case.new(title: "Test", status: s, client_name: "Jane")
        expect(case_record).to be_valid
      end
    end
  end

  describe "scopes" do
    before do
      Case.create!(title: "Open Case", status: "open", client_name: "Alice")
      Case.create!(title: "Closed Case", status: "closed", client_name: "Bob")
    end

    it "returns only open cases" do
      expect(Case.open_cases.count).to eq(1)
      expect(Case.open_cases.first.title).to eq("Open Case")
    end

    it "returns only closed cases" do
      expect(Case.closed_cases.count).to eq(1)
    end
  end
end
