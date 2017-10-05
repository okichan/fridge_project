class Recipe
  # name : string
  # needed ingredients : array
  # URL how to make
  attr_accessor :name, :ingredients, :url ,:minutes

  def initialize(name,url,minutes)
    @name = name
    @url = url
    @ingredients = []
    @minutes = minutes
  end

end
