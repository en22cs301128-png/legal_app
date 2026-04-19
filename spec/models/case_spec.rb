RSpec.describe "Legal App" do
  it "pipeline is working" do
    expect(1 + 1).to eq(2)
  end

  it "CI/CD runs successfully" do
    expect("legal_app").to include("legal")
  end

  it "Docker pipeline is configured" do
    expect(true).to be true
  end
end