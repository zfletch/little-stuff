# Doubly-linked list exercise.
# I added a #to_s for the DoublyLinkedList which exercises the #each method.
# I cannot quite remember the requirements--I hope I haven't misunderstood
# how you wanted #each to work.
#
# If you wanted a singly-linked list, the logic is fussier--it's been a long time
# since I implemented such, but, I'll be happy to do it when/if someone asks.
#
# I'm sorry, I felt very thumb-fingered coding in that little tool under
# your gaze (as it were).  And, I do not often implement things like linked
# lists.
#
# You may notice the new, Ruby 2.3 "safe navigation" operator, &.
#
# You did not ask for an #unshift method for the DoublyLinkedList, to my knowledge.
# That is why, in this little implementation, Node takes an optional left-ptr
# param but no optional right-ptr; we'll never be unshifting nodes onto the beginning
# of the list.
#
# Finally:  please note that in real life I'd have written an RSpec file or some kind
# of unit test for these classes.  Also, since Node is used only as a private
# aspect of DoublyLinkedList, I'd probably move the class definition for Node within
# DoublyLinkedList--as in, DoublyLinkedList::Node. Opinions vary on that kind of thing.
class DoublyLinkedList
  include Enumerable

  attr_accessor :head
  attr_accessor :tail

  def each(&block)
    head&.each(&block)
  end

  def push(*values)
    values.each do |value|
      if tail.nil?
        self.head = self.tail = Node.new(value)
      else
        self.tail = self.tail.right = Node.new(value, tail)
      end
    end

    self
  end

  def pop
    return nil unless tail_node = tail # Empty list. Depending on requirement, raise error, instead?

    self.tail = tail_node.left

    if tail.nil?
      self.head = nil
    else
      tail.right = nil
    end

    tail_node.left = nil # Pbly not necessary, but perhaps helps GC
    tail_node.value
  end

  def shift
    return nil unless head_node = head # Empty list

    self.head = head_node.right

    if head.nil?
      self.tail = nil
    else
      head.left = nil
    end

    head_node.right = nil # Pbly not necessary, but perhaps helps GC
    head_node.value
  end

  def to_s
    inspect
  end

  def inspect
    "<<#{to_a.join(", ")}>>"
  end

  class Node
    attr_reader :value
    attr_accessor :left
    attr_accessor :right

    def each(&block) # This works but isn't a complete implementation of Enumerable's #each
      yield(value)
      right&.each(&block)
    end

    def initialize(value, left = nil)
      @value = value # Do we care about a nil value?
      self.left = left
    end
  end
end

