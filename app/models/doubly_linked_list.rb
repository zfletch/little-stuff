class DoublyLinkedList
  include Enumerable

  attr_accessor :head
  attr_accessor :tail
  attr_reader :size

  def each(&block)
    head&.each(&block)
  end

  def empty?
    tail.nil?
  end

  def initialize
    @size ||= 0
  end

  def inspect
    "<<#{to_s}>>"
  end

  def push(*values)
    values.each do |value|
      @size += 1

      if tail.nil?
        self.head = self.tail = Node.new(value)
      else
        self.tail = self.tail.right = Node.new(value, tail)
      end
    end

    self
  end

  alias << push

  def pop
    return nil unless tail_node = tail

    self.tail = tail_node.left

    if tail.nil?
      self.head = nil
    else
      tail.right = nil
    end

    @size -= 1
    tail_node.left = nil # Probably not necessary, but perhaps helps GC
    tail_node.value
  end

  def shift
    return nil unless head_node = head

    self.head = head_node.right

    if head.nil?
      self.tail = nil
    else
      head.left = nil
    end

    @size -= 1
    head_node.right = nil # Probably not necessary, but perhaps helps GC
    head_node.value
  end

  def to_a
    [].tap do |result|
      each { |value| result.push(value) }
    end
  end

  def to_s
    if size <= 50
      to_a.to_s
    else
      take(50).to_s + "...(#{size} total size)"
    end
  end

  private

  class Node
    attr_reader :value
    attr_accessor :left
    attr_accessor :right

    def each(&block)
      yield(value)
      right&.each(&block)
    end

    def initialize(value, left = nil)
      @value = value # TODO Do we care about a nil value?
      self.left = left
    end
  end
end
