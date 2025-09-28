RSpec.feature "Books Index" do
  let(:books) do
    Hanami.app["relations.books"]
  end

  before do
    books.insert(title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz")
    books.insert(title: "Eloquent Ruby", author: "Russ Olsen")
    books.insert(title: "The Well-Grounded Rubyist", author: "David A. Black")
  end


  it "shows a list of books" do
    visit "/books"

    expect(page).to have_selector "li", text: "Practical Object-Oriented Design in Ruby, Sandi Metz"
    expect(page).to have_selector "li", text: "Eloquent Ruby, Russ Olsen"
    expect(page).to have_selector "li", text: "The Well-Grounded Rubyist, David A. Black"
  end
end
