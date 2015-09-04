require 'rails_helper'

RSpec.describe AccessController, type: :controller do

  describe 'GET #index' do

    context 'when not logged in' do
      before do
        get 'index'
      end

      it { is_expected.to respond_with :unauthorized }
    end

    context 'when logged in' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
        get 'index'
      end

      it { is_expected.to respond_with :ok }
      it "returns an access token" do
        expect(response.body['token']).to be_a(String)
      end
    end
  end
end
