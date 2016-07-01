class CorgiPerk

  def initialize(perk_id, shopping_list)
    @id = perk_id
    @shopping_list = shopping_list
  end

  def bone
    info = @shopping_list.get_bone_info(@id)
    happiness = @shopping_list.get_bone_happiness(@id)
    result = "Bone: #{info}: #{happiness}"
    happiness > 30 ? "* #{result}" : result
  end

  def kibble
    info = @shopping_list.get_kibble_info(@id)
    happiness = @shopping_list.get_kibble_happiness(@id)
    result = "Kibble: #{info}: #{happiness}"
    happiness > 30 ? "* #{result}" : result
  end

  def silly_outfit
    info = @shopping_list.get_silly_outfit_info(@id)
    happiness = @shopping_list.get_silly_outfit_happiness(@id)
    result = "Silly Outfit: #{info}: #{happiness}"
    happiness > 30 ? "* #{result}" : result
  end

end

# Phase 1: #method_missing

# Employ #method_missing to refactor. The goal is for your
# #method_missing to be functionally equivalent to #bone,
# #kibble, and #silly_outfit.
# Hint: Within #method_missing you can use #send to call
# methods on your @shopping_list. Note that you can pass
# #send a string, allowing for interpolation.


# Phase 2: Dynamic Dispatch

# Next try using #send in conjunction with #define_method within
# a class method, e.g. ::define_perk(perk), that dynamically builds
# all of your class' instance methods. You can call this method
# upon initialization. This technique is called dynamic dispatch.
