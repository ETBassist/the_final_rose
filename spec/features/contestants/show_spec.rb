require 'rails_helper'

describe "As a visitor to a contestants show page" do
  before :each do
    @bachelorette1 = Bachelorette.create!(name: "Hannah Brown",
                                         season_number: 5,
                                         season_description: "EVEN MORE DRAMA")
    @contestant1 = @bachelorette1.contestants.create(name: "Dwight Shrute",
                                                     age: 34,
                                                     hometown: "Scranton")
    @outing1 = @contestant1.outings.create!(name: 'Sleep with the fishes',
                                            location: 'River quai',
                                            date: '10/10/10')
    @outing2 = @contestant1.outings.create!(name: 'Helicopter Ride',
                                            location: 'The sky?',
                                            date: '10/11/10')
  end

  it "I see that contestants details and the season number and description on their page" do
    visit "/contestants/#{@contestant1.id}"

    expect(page).to have_content(@contestant1.name)
    expect(page).to have_content(@bachelorette1.season_number)
    expect(page).to have_content(@bachelorette1.season_description)
  end

  it 'I see all the outings that contestant has been on and a link to that outing' do
    visit "/contestants/#{@contestant1.id}"

    within("#outing-#{@outing1.id}") do
      expect(page).to have_link("#{@outing1.name}")
    end

    within("#outing-#{@outing2.id}") do
      click_link("#{@outing2.name}")
    end

    expect(current_path).to eq("/outings/#{@outing2.id}")
  end
end
