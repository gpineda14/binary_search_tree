class Node
  attr_accessor :value, :parent, :left, :right
  def initialize(value=0)
    @parent = nil
    @value = value
    @left = nil
    @right = nil
  end
end
