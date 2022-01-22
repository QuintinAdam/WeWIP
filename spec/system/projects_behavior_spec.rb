require 'rails_helper'

describe "interaction for ProjectsController", type: :feature do
  include HotGlue::ControllerHelper
    #HOTGLUE-SAVESTART
  #HOTGLUE-END
  
  
  let!(:project1) {create(:project , name: FFaker::Movie.title )}
   

  describe "index" do
    it "should show me the list" do
      visit projects_path
      expect(page).to have_content(project1.name)
    end
  end

  describe "new & create" do
    it "should create a new Project" do
      visit projects_path
      click_link "New Project"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Project")]')

      new_name = 'new_test-email@nowhere.com' 
      find("[name='project[name]']").fill_in(with: new_name)
      click_button "Save"
      expect(page).to have_content("Successfully created")
      expect(page).to have_content(new_name)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit projects_path
      find("a.edit-project-button[href='/projects/#{project1.id}/edit']").click

      expect(page).to have_content("Editing #{project1.name.squish || "(no name)"}")
      new_name = FFaker::Lorem.paragraphs(1).join 
      find("input[name='project[name]']").fill_in(with: new_name)
      click_button "Save"
      within("turbo-frame#project__#{project1.id} ") do
        expect(page).to have_content(new_name)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit projects_path
      accept_alert do
        find("form[action='/projects/#{project1.id}'] > input.delete-project-button").click
      end
      expect(page).to_not have_content(project1.name)
      expect(Project.where(id: project1.id).count).to eq(0)
    end
  end
end

