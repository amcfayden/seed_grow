require 'spec_helper'

describe "Seed pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "seed creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a seed" do
        expect { click_button "Post" }.not_to change(Seed, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'seed_plant', with: "Pink Rose" }
      before { fill_in 'seed_source', with: "Almanac.com" }
      before { fill_in 'seed_zone', with: 1 }
      it "should create a seed" do
        expect { click_button "Post" }.to change(Seed, :count).by(1)
      end
    end
  end

   describe "seed destruction" do
    before { FactoryGirl.create(:seed, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a seed" do
        expect { click_link "delete" }.to change(Seed, :count).by(-1)
      end
    end
  end
end
