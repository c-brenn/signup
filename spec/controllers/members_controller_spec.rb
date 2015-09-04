require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  let(:headers) { { 'CONTENT_TYPE' => 'application/json'  } }

  describe 'POST #add-members' do

    before(:each) do
      post 'add_members', params, headers
    end
    let(:params) { {members: Array.new(3) { attributes_for(:member) }} }

    context 'with valid members' do
     it_behaves_like 'an import response', 3, 0
    end

    context 'with some invalid members' do
      let(:params) { {members: (Array.new(3) { attributes_for(:member) }) << attributes_for(:member, email: 'bad@bad') } }

      it_behaves_like 'an import response', 3, 1
    end

    context 'with some duplicate members' do
      let(:params) { {members: Array.new(3) { attributes_for(:member, email: 'duplicate@e.com') }} }

      it_behaves_like 'an import response', 1, 2
    end

    context 'with no members at all' do
      let(:params) { {} }
      
      it { is_expected.to respond_with :unprocessable_entity }
    end
  end
end
