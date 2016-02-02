class SinglyLinkedList
  include Enumerable

  def initialize
    @head = nil
  end

  def push(*vals)
    vals.each { |val| @head = Node.new(val, @head) }

    self
  end

  def pop
    return nil if @head.nil?

    node = @head
    @head = @head.rest

    node.val
  end

  def shift
    return nil if @head.nil?

    if @head.last?
      node = @head
      @head = nil

      return node.val
    end

    prev_node = nil
    node = @head

    until node.last?
      prev_node = node
      node = node.rest
    end

    prev_node.rest = node.rest
    node.val
  end

  def each
    return nil if @head.nil?

    @head.each { |n| yield n }
  end

  def to_s
    inspect
  end

  def inspect
    "<#{to_a.join(", ")}>"
  end

  class Node
    attr_reader :val
    attr_accessor :rest

    def initialize(val, rest = nil)
      @val = val
      @rest = rest
    end

    def each
      rest.each { |n| yield n } unless last?
      yield val 
    end

    def last?
      @rest.nil?
    end
  end
end
