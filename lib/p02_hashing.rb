require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty?
    hashes = []
    self.each_with_index do |el, i|
      hashes << el.hash + i.hash
    end
    hashes.reduce(:^)
  end
end

class String
  def hash
    if self.length > 1
      self.chars.hash
    else
      self.ord.hash + self.ord
    end
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.sort.hash
  end
end
