shared_examples_for "finding the right Role" do
  it "finds the right Role" do
    expect(Arrthorizer::Role.get(arg)).to be expected_role
  end
end

