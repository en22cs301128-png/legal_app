require "rails_helper"

RSpec.describe "Cases API", type: :request do
  let(:valid_params) do
    { case: { title: "New Case", status: "open", client_name: "Alice" } }
  end

  describe "GET /cases" do
    it "returns all cases" do
      Case.create!(title: "Case 1", status: "open", client_name: "Alice")
      get "/cases"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "POST /cases" do
    it "creates a new case" do
      expect {
        post "/cases", params: valid_params
      }.to change(Case, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it "returns errors for invalid case" do
      post "/cases", params: { case: { title: nil, status: "open", client_name: "Bob" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key("errors")
    end
  end

  describe "DELETE /cases/:id" do
    it "deletes the case" do
      c = Case.create!(title: "Delete Me", status: "open", client_name: "Bob")
      expect {
        delete "/cases/#{c.id}"
      }.to change(Case, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
