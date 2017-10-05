# set all ingredients
def set_ingredient(fridge)
  # put ingredients you want to puts manualy
  fridge.ingredients = ["chicken","sugar","mirin","soy sauce","rice","carrot","potato","onion",
    "beef","curry mix","egg","octopus","flour","ginger","dashi","miso"]
end #def set_ingredient end

# set all recipes
def set_recipes(fridge)
  # put recipes you want to puts manumally
  recipe_ingredients = {"Teriyaki" =>["chicken","sugar","mirin","soy sauce"],
                        "Curry rice" => ["rice","curry mix","potato","onion","beef","carrot"],
                        "Oyakodon" => ["chicken","sugar","mirin","soy sauce","rice","egg","onion"],
                        "Takoyaki" => ["flour","octopus","ginger","dashi"],
                        "Nikujyaga" => ["beef","sugar","mirin","soy sauce","carrot","onion","potato"],
                        "Octopus Sashimi" => ["octopus","soy sauce"],
                        "Miso soup" => ["miso","dashi"]}

  # set recipes_array to make new instence of Recipe
  recipes_array = {"Teriyaki" => ["http://natashaskitchen.com/2015/12/11/easy-teriyaki-chicken/",15],
                  "Curry rice" => ["http://www.japanesecooking101.com/curry-and-rice-recipe/",40],
                  "Oyakodon" => ["http://www.justonecookbook.com/oyakodon/",30],
                  "Takoyaki" => ["http://www.justonecookbook.com/takoyaki-recipe/",20],
                  "Nikujyaga" => ["http://www.justonecookbook.com/nikujaga/",30],
                  "Octopus Sashimi" => ["http://www.makesushi.com/sashimi/",5],
                  "Miso soup" =>[ "http://steamykitchen.com/106-simple-10-minute-miso-soup.html",5]}

 # make new instance and put to fridge.recipes
    recipes_array.each do |key,value|
  new_recipe = Recipe.new(key,value[0],value[1])
  new_recipe.ingredients = recipe_ingredients["#{key}"]
  fridge.recipes << new_recipe
end # recipes_array each end
end #def set_recipes end

# compare what_you_have and recipes.ingredients
def find_mached_recipe(fridge)
  system "clear"
recipes_you_can_make = []
recipe_count = 1
 fridge.recipes.each do |recipe|
   if recipe.ingredients & fridge.what_you_have.map(&:name) == recipe.ingredients
    recipes_you_can_make << recipe
     recipe_count += 1
   end #if end
 end  # fridge.recipes.each end
 if recipe_count ==1
   puts "Nothing! You better go out and get some food."
   sleep 2
   abort
 else
   puts "Thank you! You can make these Japanese food"
 end # if end
   recipes_you_can_make
end #def end

# let user choose which recipe they want
def choose_recipe(recipes)
#  colors_array = [:magenta,:green,:yellow,:white,:red,:cyan,:blue]
  rows = []
  # put the list of the recipes
  recipes.each.with_index(1) do  |recipe,i|
    rows << ["#{i}","#{recipe.name}".yellow,"#{recipe.minutes} min"]
  end #recipes.each end
  table = Terminal::Table.new :rows => rows
  table = Terminal::Table.new :headings => ['Number', 'Food','Time to cook'], :rows => rows
  puts table
  # put question to let user choose
  chosen_recipe = nil
  loop do
  puts "Which do you want to cook?(press the number)"
  input = gets.to_i
  chosen_recipe = recipes[input - 1]
  if input == 0
  puts "Error"
  elsif chosen_recipe != nil
  puts "#{chosen_recipe.name}: you need these ingredients #{chosen_recipe.ingredients}\nCheck here to know how to cook!->:#{chosen_recipe.url}"
  break
  else
  puts "Error"
  end # if
 end #loop end
end # def choose_recipe end

# ask question what they have and put the answer to fridge.what_you_have array
 def get_what_they_have(fridge)
   fridge.what_you_have  = []
   # ask qestions to get answer from user
   puts "Let me ask what you have in the fridge."
   fridge.ingredients.each do |ingredient|
     puts "Do you have #{ingredient}?(y/n)"
     ingredient_answer = gets.strip.downcase
    # put the answer to what_you_have array
     case ingredient_answer
     when "y"
       new_ingredient = Ingredient.new(ingredient)
      fridge.what_you_have << new_ingredient
     when "n"
     else
      puts "Say that again? #{ingredient_answer} is not acceptable."
      redo
     end # case ingredient_answer end
   end # each end
 end #def get_what_they_have

# main menu method
def main_menu(fridge)
  # loop the menu untill break
  loop do
  # ask if user wanna make Japanese food.
  puts "Hello #{fridge.owner_name.green}. Wellcome to "+"Japanese Fridge".cyan
  sleep 2
  system "clear"
  puts "Would you like to make Japanese food?(y/n)"
  choice = gets.strip.downcase
  case choice
  # when yes
  when "y"
    get_what_they_have(fridge)
    puts "Let me think what you can make..."
    sleep 3
    system "clear"
    loop do
    choose_recipe(find_mached_recipe(fridge))
    puts " "
    puts "Press [b] to choose other recipes\nPress [x] to exit"
    exit_back_choice = gets.strip.downcase
    if exit_back_choice == "b"
      system "clear"
    elsif exit_back_choice == "x"
     puts "See you next time! Enjoy your meal :)"
     sleep 1
      abort
    end # if exit_back_choice end
    end  # loop end

    # when no
   when "n"
    puts "See you next time!"
    sleep 1
    break
  else
    puts "Say that again? #{choice} is not acceptable."
    sleep 1
    main_menu(fridge)
  end # case choice end
  end # loop end
end # def end
