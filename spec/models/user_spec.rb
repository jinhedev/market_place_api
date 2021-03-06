require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryBot.build(:user) }
  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }
  it { should be_valid }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_uniqueness_of(:auth_token) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }

  it { should have_many(:products) }

  describe '#generate authentication_token!' do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("anuniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "anuniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryBot.create(:user, auth_token: "anuniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  describe '#products association' do
    before do
      @user.save
      3.times { FactoryBot.create :product, user: @user }
    end

    it 'destroys the association products on self destruct' do
      products = @user.products
      @user.destroy
      products.each do |p|
        expect(Product.find(p)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
