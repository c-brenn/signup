require 'rails_helper'

RSpec.describe Member, type: :model do

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_length_of(:email).is_at_most 128 }
  it { is_expected.to allow_value('good@email.com').for :email }
  it { is_expected.not_to allow_value('bad@bad').for :email }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_length_of(:first_name).is_at_most 128 }

  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_length_of(:last_name).is_at_most 128 }

  it { is_expected.to validate_presence_of :year }
  it { is_expected.to validate_inclusion_of(:year).in_range 1..5 }

  describe '.import_json' do
    subject { Member.import_json(member_array) }
    let(:member_array) { Array.new(5) { build(:member) } }
    let(:expected_hash) { {added: 5, errors: 0} }

    context 'with valid members' do
      it "adds all members" do
        is_expected.to match expected_hash
      end
    end

    context 'with invalid users' do
      let(:member_array) { (Array.new(3) { build(:member) }) << build(:member, email: "bad@bad") }
      let(:expected_hash) { {added: 3, errors: 1} }

      it "ignores invalid members" do
        is_expected.to match expected_hash
      end
    end

    context 'with duplicate users' do
      let(:member_array) { (Array.new(3) { build(:member) }) << create(:member) }
      let(:expected_hash) { {added: 3, errors: 1} }

      it "ignores duplicate members" do
        is_expected.to match expected_hash
      end
    end
  end

  describe '.to_csv' do
    let(:size) { 5 }
    let!(:members) { Array.new(size) { create(:member) } }

    subject { Member.to_csv }

    it "has the right size" do
      # number of rows = num of records + header row
      expected_size = size + 1
      expect(subject.split("\n").size).to eq expected_size
    end
  end

  describe '.year_string' do
    let(:member) { build(:member, year: 2) }

    subject { member.year_string }

    context 'with undergrad year' do
      it { is_expected.to match 'II' }
    end

    context 'with non undergrad year' do
      before { member.year = 5 }

      it { is_expected.to match 'Postgrad/Staff' }
    end
  end
end
