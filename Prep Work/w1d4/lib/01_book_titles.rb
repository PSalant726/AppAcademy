class Book
  # TODO: your code goes here!
  attr_reader :title
  
  def title= (new_title)
    exceps = ["a", "an", "and", "for", "in", "of", "the", "to"]
    @title = new_title.split.map do |word| 
      word.capitalize! unless exceps.include?(word)
      word
    end
    @title[0].capitalize!
    @title = @title.join(" ")
  end
end