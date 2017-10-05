
class Fridge
# inside ingredients : array
# owner's name :string
#recipes : array
  attr_accessor :owner_name, :ingredients ,:recipes,:what_you_have
  def initialize(owner_name)
    @owner_name = owner_name
    @ingredients = []
    @recipes = []
    @what_you_have = []
  end
end
