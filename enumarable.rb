module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    # this line is added because it returns an error when no block is given
    # e.g. in irb when we use my_each with no block it gives an error of undefined local variable or method.

    for element in self # for each element inside the array
    yield(element)
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    for element in self
      yield(element, i)
      i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each { |element| arr.push(element) if yield(element)}
    # my_each to iterate in the array and a block command where we say that element represent each element iterated, then we add the element to the array if the variable in yield is true

    # e.g.
    # [1,2,3,4,5,6].select { |n| n.even? }
    # n represents yield(element), if yield(element) is even (true) then is added to the array.

    arr
  end

  def my_all?(arg)
    if block_given?
      my_each { |element| return false if yield(element) == false}
      # iterate each element in the array and see if it matches with yield(element) conditions
      # e.g. [[1,2],2,'helo'].all? { |n| n.is_a?(Array) }
      # the first element is an Array so it returns true, but the second element (2) is a numeric values, so returns false.
      return true
      # returns true if everything matches
    elsif !arg.nil? and arg.is_a?(Class)
      my_each { |element| return false if element.class != arg}
      # if argument is a class then checks if each elements matches with the class
    elsif arg.nil?
      return false
    else
      return true
    end
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |element| return true if yield(element)}
    elsif !arg.nil? and arg.is_a?(Class)
      my_each { |element| return true if element.class == arg}
    elsif arg.nil?
      my_each { |element| return true if element.nil?}
    else
      return false
    end
  end

    def my_none?(arg = nil)
      if arg.is_a?(Class)
        my_each { |element| return false if element.class == arg}
        return true
      elsif block_given?
        my_each { |element| return false if yield(element)}
        return true
      elsif self.length == 0 or self.nil?
        return true
      elsif !block_given? and arg.nil?
        my_any? { |element| return false if element == true}
        my_each { |element| return true if element == nil or element == false}
      else
        return false
      end
    end

    def my_count(arg = nil)
        counter = 0
        if arg.nil? and !block_given?
          return self.length
        elsif !arg.nil? and arg.is_a?(Integer)
          my_each {|element| counter += 1 if element == arg}
          return counter
        elsif block_given?
          my_each {|element| counter += 1 if yield(element) }
          return counter
        end
    end

    def my_map(arg = nil)
      return to_enum(:my_map) unless block_given?

      arr = []
      my_each { |element| arr.push(yield(element)) }
      return arr
    end

    def my_inject(*arg) #take an array or a range of numbers and can receive a block, we need two value, one for accumalator
      acc = 0
      if self.is_a?(Range)
        my_each { |element, value| return yield(element, value)}
      end 
    end


end
