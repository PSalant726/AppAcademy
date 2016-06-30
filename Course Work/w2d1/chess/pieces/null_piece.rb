require 'singleton'

class NullPiece
  include Singleton

  def side
    :n
  end

  def present?
    false
  end

  def to_s
    "   "
  end
end
