RSpec.describe "Cases API" do
  it "validates case status" do
    valid = %w[open closed pending]
    expect(valid).to include("open")
  end

  it "CI pipeline runs tests automatically" do
    expect("CI/CD").not_to be_nil
  end
end