class Friend
  # TODO: your code goes here!
  def greeting(who = nil)
    who.nil? ? "Hello!" : "Hello, #{who}!"
  end
end
