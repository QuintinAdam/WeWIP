require 'rails_helper'

describe "interaction for TeamsController", type: :feature do
  include HotGlue::ControllerHelper
    #HOTGLUE-SAVESTART
  #HOTGLUE-END
  let(:current_user) {create(:user)}
  
  let!(:team1) {create(:team, user: current_user , name: FFaker::Movie.title, 
      slug: FFaker::Movie.title )}
   
  before(:each) do
    login_as(current_user)
  end 

  describe "index" do
    it "should show me the list" do
      visit teams_path
      expect(page).to have_content(team1.name)
      expect(page).to have_content(team1.slug)
    end
  end

  describe "new & create" do
    it "should create a new Team" do
      visit teams_path
      click_link "New Team"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Team")]')

      new_name = 'new_test-email@nowhere.com' 
      find("[name='team[name]']").fill_in(with: new_name)
      new_slug = 'new_test-email@nowhere.com' 
      find("[name='team[slug]']").fill_in(with: new_slug)
      click_button "Save"
      expect(page).to have_content("Successfully created")
      expect(page).to have_content(new_name)
      expect(page).to have_content(new_slug)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit teams_path
      find("a.edit-team-button[href='/teams/#{team1.id}/edit']").click

      expect(page).to have_content("Editing #{team1.name.squish || "(no name)"}")
      new_name = FFaker::Lorem.paragraphs(1).join 
      find("input[name='team[name]']").fill_in(with: new_name)
      new_slug = FFaker::Lorem.paragraphs(1).join 
      find("input[name='team[slug]']").fill_in(with: new_slug)
      click_button "Save"
      within("turbo-frame#team__#{team1.id} ") do
        expect(page).to have_content(new_name)
        expect(page).to have_content(new_slug)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit teams_path
      accept_alert do
        find("form[action='/teams/#{team1.id}'] > input.delete-team-button").click
      end
      expect(page).to_not have_content(team1.name)
      expect(Team.where(id: team1.id).count).to eq(0)
    end
  end
end

