RSpec.shared_examples 'an import response' do | added, errors |
  let(:expected_hash) { {results: {added: added, errors: errors}}.to_json }
  it { is_expected.to respond_with :ok }
  it "responds with correct number of additions/errors" do
    expect(response.body).to eq expected_hash
  end
end
