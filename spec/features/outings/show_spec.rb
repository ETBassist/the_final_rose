require 'rails_helper'

describe 'As a visitor when I go to an outings show page' do
  before :each do
    @bachelorette1 = Bachelorette.create!(name: "Hannah Brown",
                                         season_number: 5,
                                         season_description: "EVEN MORE DRAMA")
    @contestant1 = @bachelorette1.contestants.create(name: "Dwight Shrute",
                                                     age: 34,
                                                     hometown: "Scranton")
    @contestant2 = @bachelorette1.contestants.create(name: "Michael Scott",
                                                     age: 30,
                                                     hometown: "Scranton")
    @outing1 = @contestant1.outings.create!(name: 'Sleep with the fishes',
                                            location: 'River quai',
                                            date: '10/10/10')
    @outing1.contestants << @contestant2
  end

  it 'I see the details of that outing' do
    visit "/outings/#{@outing1.id}"

    expect(page).to have_content(@outing1.name)
    expect(page).to have_content(@outing1.location)
    expect(page).to have_content(@outing1.date)
  end

  it 'I see a count of contestants on that outing and all their names' do
    visit "/outings/#{@outing1.id}"
    
    expect(page).to have_content("2 Contestants on this Outing:")
    expect(page).to have_content(@contestant1.name)
    expect(page).to have_content(@contestant2.name)
  end
end
