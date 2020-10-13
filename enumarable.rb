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

end
