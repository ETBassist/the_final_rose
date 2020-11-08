require 'rails_helper'

RSpec.describe Contestant, type: :model do
  describe 'relationships' do
    it {should belong_to :bachelorette}
    it {should have_many(:outings).through(:contestant_outings)}
  end

  describe 'class methods' do
    it '::average_age' do
      bachelorette1 = Bachelorette.create!(name: "Hannah Brown",
                                          season_number: 5,
                                          season_description: "EVEN MORE DRAMA")
      bachelorette2 = Bachelorette.create!(name: "Jane Doe",
                                          season_number: 8,
                                          season_description: "WHEN WILL IT END")
      bachelorette1.contestants.create(name: "Dwight Shrute",
                                      age: 34,
                                      hometown: "Scranton")
      bachelorette1.contestants.create(name: "Michael Scott",
                                      age: 30,
                                      hometown: "Scranton")
      bachelorette2.contestants.create(name: "Jim Halpert",
                                      age: 29,
                                      hometown: "Scranton")
      expect(Contestant.average_age).to eq(31.0)
    end

    it '::unique_hometowns' do
      bachelorette1 = Bachelorette.create!(name: "Hannah Brown",
                                          season_number: 5,
                                          season_description: "EVEN MORE DRAMA")
      bachelorette2 = Bachelorette.create!(name: "Jane Doe",
                                          season_number: 8,
                                          season_description: "WHEN WILL IT END")
      contestant1 = bachelorette1.contestants.create(name: "Dwight Shrute",
                                      age: 34,
                                      hometown: "Scranton")
      contestant2 = bachelorette1.contestants.create(name: "Michael Scott",
                                      age: 30,
                                      hometown: "Smallville")
      bachelorette2.contestants.create(name: "Jim Halpert",
                                      age: 29,
                                      hometown: "Scranton")
      expect(Contestant.unique_hometowns).to eq([contestant1.hometown, contestant2.hometown])
    end
  end
end
