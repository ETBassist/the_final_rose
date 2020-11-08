require 'rails_helper'

describe "As a visitor to a contestants show page" do
  before :each do
    @bachelorette1 = Bachelorette.create!(name: "Hannah Brown",
                                         season_number: 5)
    @contestant1 = @bachelorette1.contestants.create(name: "Dwight Shrute",
                                                     age: 34,
                                                     hometown: "Scranton")
  end

  it "I see that contestants details and the season number and description on their page" do
    visit "/contestants/#{@contestant1.id}"

    expect(page).to have_content(@contestant1.name)
    expect(page).to have_content(@bachelorette1.season_number)
  end
end
