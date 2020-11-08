require 'rails_helper'

describe 'As a visitor when I visit the contestants index' do
  before :each do
    @bachelorette1 = Bachelorette.create!(name: "Hannah Brown",
                                         season_number: 5)
    @bachelorette2 = Bachelorette.create!(name: "Jane Doe",
                                         season_number: 8)
    @contestant1 = @bachelorette1.contestants.create(name: "Dwight Shrute",
                                                     age: 34,
                                                     hometown: "Scranton")
    @contestant2 = @bachelorette1.contestants.create(name: "Michael Scott",
                                                     age: 30,
                                                     hometown: "Scranton")
    @contestant3 = @bachelorette2.contestants.create(name: "Jim Halpert",
                                                     age: 29,
                                                     hometown: "Scranton")
  end

  it "I see the details for each contestant for a bachelorette" do
    visit "/bachelorettes/#{@bachelorette1.id}/contestants"

    within("#contestant-#{@contestant1.id}") do
      expect(page).to have_link("#{@contestant1.name}")
      expect(page).to have_content(@contestant1.age)
      expect(page).to have_content(@contestant1.hometown)
    end

    within("#contestant-#{@contestant2.id}") do
      expect(page).to have_link("#{@contestant2.name}")
      expect(page).to have_content(@contestant2.age)
      expect(page).to have_content(@contestant2.hometown)
    end

    expect(page).to_not have_selector("#contestant-#{@contestant3.id}")
  end

  it "and I click a contestants name I'm take to their show page" do
    visit "/bachelorettes/#{@bachelorette1.id}/contestants"

    within("#contestant-#{@contestant2.id}") do
      click_link("#{@contestant2.name}")
    end

    expect(current_path).to eq("/contestants/#{@contestant2.id}")
  end
end

