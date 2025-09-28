RSpec.feature "Books Index" do
  it "shows a list of books" do
    visit "/books"

    expect(page).to have_selector "li", text: "Practical Object-Oriented Design in Ruby"
  end
end
