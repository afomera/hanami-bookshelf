RSpec.feature "Home" do
  scenario "visiting the home page" do
    visit "/"

    expect(page).to have_content("Welcoem to Bookshelf")
  end
end
