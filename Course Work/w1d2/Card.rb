require 'byebug'

class Card
  attr_reader :orientation
  attr_accessor :face_value

  def initialize(face_value, orientation = false)
    @face_value = face_value
    @orientation = orientation
  end

  def display_value
    if @orientation
      print "[#{@face_value}] " if @face_value == "10"
      print "[ #{@face_value}] " if @face_value != "10"
    else
      print "[  ] "
    end
  end

  def hide
    @orientation = false
  end

  def reveal
    @orientation = true
  end

  def to_s
    @face_value
  end

  def ==(other_card)
    self.face_value == other_card.face_value
  end
end
