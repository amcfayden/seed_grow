require 'spec_helper'

describe Seed do

let(:user) { FactoryGirl.create(:user) }
before { @seed = user.seeds.build(plant: "Pink Rose", source: "Almanac.com", zone: 1) }

  subject { @seed }

  it { should respond_to(:plant) }
  it { should respond_to(:source) }
  it { should respond_to(:zone) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @seed.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank plant" do
    before { @seed.plant = " " }
    it { should_not be_valid }
  end

  describe "with plant that is too long" do
    before { @seed.plant = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with blank source" do
    before { @seed.source = " " }
    it { should_not be_valid }
  end

  describe "with source that is too long" do
    before { @seed.source = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with blank zone" do
    before { @seed.zone = " " }
    it { should_not be_valid }
  end

  describe "with zone that is too long" do
    before { @seed.zone = 1 * 100 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Seed.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
