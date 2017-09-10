class BinaryTree
  require './node.rb'
  attr_accessor :tree
  def initialize(arr)
    @tree = arr == arr.sort ? build_tree(arr) : build_tree_unsorted(arr)
  end

  # takes an array and creates a binary tree full of node objects
  def build_tree(arr, parent=nil)
    # base case, return final root when array only has 1 value
    if arr.size == 1
      root = Node.new(arr[0])
      root.parent = parent
      return root
    end
    # define root and add parent to root
    mid = arr.size / 2
    root = Node.new(arr[mid])
    root.parent = parent
    # define left and right tree
    root.left = build_tree(arr[0..mid - 1], root.value) unless arr[0..mid -1].size < 1
    root.right = build_tree(arr[mid + 1..arr.size], root.value) unless arr[mid + 1..arr.size].size < 1
    # return complete tree
    root

  end

  def build_tree_unsorted(arr)
    root = Node.new(arr.shift)
    arr.each { |value| enter_node(value, root)}
    root
  end

  def enter_node(value, parent)
    if value >= parent.value && parent.right.nil?
      parent.right = Node.new(value)
      parent.right.parent = parent.value
    elsif value <= parent.value && parent.left.nil?
      parent.left = Node.new(value)
      parent.left.parent = parent.value
    else
      parent.value >= value ? enter_node(value, parent.left) : enter_node(value, parent.right)
    end
  end

  def breadth_first_search(value)
    # creat queue to keep track of nodes being checked
    queue = []
    queue << @tree
    until queue.empty?
      #get size of nodes in current level
      n = queue.size
      #check each value of node in level to see if they match the value
      queue.each do |node|
        if node.value == value #return the node if its value matches with the value entered
          return node
        end
      end
      # search through the queue and get children of the nodes inside
      queue.each do |node|
        queue << node.left if node.left != nil
        queue << node.right if node.right != nil
      end
      # clear the previous level of nodes out of the queue
      n.times { queue.shift }

    end

    return nil

  end

  def depth_first_search(value)
    # create a stack to hold nodes
    stack = []
    stack << @tree
    # keep checking for child nodes until stack is empty or value found
    until stack.empty?
      s = stack.pop
      return s if s.value == value # return node if value is found
      stack << s.left if s.left !=nil
      stack << s.right if s.right != nil
    end

    return nil #return nil if value is not in any nodes

  end

  def dfs_rec(value, node = @tree)
    # base case, check if value matches entered value
    return node if node.value == value
    # recursively look through left branch and right branch values
    left = dfs_rec(value, node.left) unless node.left.nil?
    right = dfs_rec(value, node.right) unless node.right.nil?
    # return left or right branch depending on value we are searching
    left || right

  end

end
