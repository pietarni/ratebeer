require 'rails_helper'

describe "Beer creation" do
  before do
    FactoryBot.create(:brewery, name: "Test Brewery", year: 2000)
    visit new_beer_path
  end

  it "creates a beer when the name is valid" do
    fill_in('beer_name', with: 'Valid Beer name')
    select('Lager', from: 'beer[style]')
    select('Test Brewery', from: 'beer[brewery_id]')
    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "Shows an error msg and doesn't save, when the name is empty" do
    fill_in('beer_name', with: '')
    select('Lager', from: 'beer[style]')
    select('Test Brewery', from: 'beer[brewery_id]')
    click_button('Create Beer')
    expect(page).to have_content("error")
    expect(Beer.count).to eq(0)
  end
end
