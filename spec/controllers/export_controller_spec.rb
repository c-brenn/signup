require 'rails_helper'

RSpec.describe ExportController, type: :controller do

  describe 'GET #index' do

    context 'when not logged in' do
      before do
        get 'index'
      end

      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'when logged in' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        sign_in user
        get 'index'
      end

      it { is_expected.to render_template('index') }
    end
  end
end
