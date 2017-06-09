class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    pr = self.prev
    nx = self.next

    pr.next = nx
    nx.prev = pr

    self.next = nil
    self.prev = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  # first link after the HEAD sentinal
  def first
    @head.next
  end

  # first link before the TAIL sentinal
  def last
    @tail.prev
  end

  def empty?
    count = 0
    node = @head.next
    until node.val.nil? && node.key.nil?
      node = node.next
      count += 1
    end
    count == 0
  end

  def get(key)
    link = get_link(key)
    if link.nil?
      nil
    else
      link.val
    end
  end

  def get_link(key)
    self.each do |link|
      return link if link.key == key
    end
    nil
  end

  def include?(key)
    self.any? {|el| el.key == key}
  end

  def append(key, val)
    link = Link.new(key, val)

    link.next = @tail
    link.prev = @tail.prev

    link.prev.next = link
    @tail.prev = link
  end

  def update(key, val)
    self.each do |link|
      link.val = val if link.key == key
    end
  end

  def remove(key)
    self.get_link(key).remove
  end

  def each
    link = @head.next
    until link.val.nil? && link.key.nil?
      yield link
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
