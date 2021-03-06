require 'rails_helper'

RSpec.describe Api::MembersController, type: :controller do

  let(:token) { create(:api_key) }
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  describe 'POST #add-members' do

    context 'with valid authentication' do
      before(:each) do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token.access_token)
      end

      def member_with_checkum(email)
        (attributes_for(:member, email: email).stringify_keys).merge!({"checksum" => email})
      end

      before(:each) do
        post 'add_members', params, headers
      end
      let(:params) { {members: Array.new(3) { attributes_for(:member) }} }

      context 'with valid members' do
        it_behaves_like 'an import response', 3, 0, []
      end

      context 'with some invalid members' do
        let(:params) { {members: (Array.new(3) { attributes_for(:member) }) << member_with_checkum('bad@bad') } }

        it_behaves_like 'an import response', 3, 1, ['bad@bad']
      end

      context 'with some duplicate members' do
        let(:params) { {members: Array.new(3) { member_with_checkum('duplicate@e.com') }} }

        it_behaves_like 'an import response', 1, 2, ['duplicate@e.com', 'duplicate@e.com']
      end

      context 'with no members at all' do
        let(:params) { {} }

        it { is_expected.to respond_with :unprocessable_entity }
      end
    end

    context 'without valid auth' do
      before do
        post 'add_members', {}
      end
      it { is_expected.to respond_with :unauthorized }
    end
  end
end
