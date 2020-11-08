require 'rails_helper'

describe "When I visit a bachelorette show page" do
  before :each do
    @bachelorette1 = Bachelorette.create!(name: "Hannah Brown",
                                         season_number: 5,
                                         season_description: "EVEN MORE DRAMA")
    @bachelorette2 = Bachelorette.create!(name: "Jane Doe",
                                         season_number: 8,
                                         season_description: "WHEN WILL IT END")
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
  
  it "I see the name, season number, and description of season on that page" do
    visit "/bachelorettes/#{@bachelorette1.id}"

    expect(page).to have_content(@bachelorette1.name)
    expect(page).to have_content("Season #{@bachelorette1.season_number} - #{@bachelorette1.season_description}")
  end

  it "I see a link to each contestant for that bachelorette" do
    visit "/bachelorettes/#{@bachelorette1.id}"

    expect(page).to have_link("View Contestants")
    click_link("View Contestants")
    expect(current_path).to eq("/bachelorettes/#{@bachelorette1.id}/contestants")
  end
end
