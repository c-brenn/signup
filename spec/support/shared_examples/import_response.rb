RSpec.shared_examples 'an import response' do | added, errors, error_checksums |
  let(:expected_hash) { {results: {added: added, errors: errors, error_checksums: error_checksums}}.to_json }
  it { is_expected.to respond_with :ok }
  it "responds with correct additions/errors/checksums" do
    expect(response.body).to eq expected_hash
  end
end
