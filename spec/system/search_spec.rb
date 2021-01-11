require "rails_helper"

RSpec.describe "/search", type: :system do
  before do
    driven_by(:selenium_chrome)#_headless)
    11.times { create :sorn }
    create(:sorn,agencies:[create(:agency,name:"Cousin Agency")])
  end

  it "applies the agency-separator class to the agency pipe separator" do
    visit "/search?search=FAKE"

    expect(page).to have_css '.agency-separator'
  end

  scenario "publication date validation" do
    visit "/search?search=FAKE"

    find("#publication-year-button").click
    within "#publication-date-fields" do
      fill_in "Starting year", with: "2020"
      fill_in "Ending year", with: "2019"
    end
    find("#general-search-button").click

    message = find("#starting_year").native.attribute("validationMessage")
    expect(message).to eq "Starting year should be earlier than the ending year."

    # Fix the years and submit should work
    within "#publication-date-fields" do
      fill_in "Starting year", with: "2019"
      fill_in "Ending year", with: "2020"
    end
    find("#general-search-button").click
    message = find("#starting_year").native.attribute("validationMessage")
    expect(message).to eq ""

    visit "/search?search=FAKE"
    find("#publication-year-button").click
    # Just a starting year should work
    within "#publication-date-fields" do
      fill_in "Starting year", with: "2019"
    end
    find("#general-search-button").click
    message = find("#starting_year").native.attribute("validationMessage")
    expect(message).to eq ""

    visit "/search?search=FAKE"
    find("#publication-year-button").click
    # Just an ending year should work
    within "#publication-date-fields" do
      fill_in "Ending year", with: "2019"
    end
    find("#general-search-button").click
    # validation message is always on starting year
    message = find("#starting_year").native.attribute("validationMessage")
    expect(message).to eq ""

    visit "/?search=FAKE"
    find("#publication-year-button").click
    within "#publication-date-fields" do
      fill_in "Starting year", with: "1993"
    end
    find("#general-search-button").click

    message = find("#starting_year").native.attribute("validationMessage")
    expect(message).to eq "Sorry, this tool only contains SORNs starting from 1994. Please enter a later starting year"
  end

  scenario "paging doesn't break js" do
    visit "/?search=FAKE"
    find_all("nav.pagination").first.find_all(".page")[1].click
    sleep 1
    # gov banner should remain closed
    expect(find("#gov-banner").visible?).to be_falsey
  end

  # test for fields checkboxes and active filters
  scenario "active-filters" do
    visit "/?search=FAKE"
    click_on 'Sections'
    find('#sections-deselect-all').click
    find('label', text:'Source').click
    find('label', text:'Retrieval').click

    click_on 'Agencies'
    find('#agencies-deselect-all').click
    find('label', text:'Parent Agency').click
    find('label', text:'Child Agency').click

    # active filter badges should be in alphabetical order
    expect(page).to have_selector("#active-sections .active-filter", count: 2)
    expect(page).to have_selector("#active-sections:first-child", text: "retrieval")
    expect(page).to have_selector("#active-sections:last-child", text: "source")
    expect(page).to have_selector("#active-agencies .active-filter", count: 2)
    expect(page).to have_selector("#active-agencies:first-child", text: "Child Agency")
    expect(page).to have_selector("#active-agencies:last-child", text: "Parent Agency")

    find(".active-filter", text: "retrieval").find(".remove-badge").click
    # if retrieval is closed, then source is left
    expect(page).to have_selector("#active-sections:first-child", text: "source")

    binding.pry
    # retrieval is closed, it should also be unchecked
    expect(find("#fields-retrieval")).not_to be_checked

    # Ensure the deselect all buttons remove the badge headers
    find('#agencies-deselect-all').click
    expect(find("#active-agency-filters").visible?).to be_falsey
  end
end