module Enumerable
  def my_each
    for element in self
    yield(element)
    end
  end

  def my_each_with_index
    i = 0
    for element in self
      yield(element, i)
      i += 1
    end
  end

end