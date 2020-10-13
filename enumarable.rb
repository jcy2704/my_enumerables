# rubocop:disable Style/CaseEquality
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Style/For
# rubocop:disable Style/RedundantSelf

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for element in self
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
    my_each { |element| arr.push(element) if yield(element) }
    arr
  end

  def my_all?(arg)
    if block_given?
      my_each { |element| return false if yield(element) == false }
      true
    elsif !arg.nil? and arg.is_a?(Class)
      my_each { |element| return false if element.class != arg }
    elsif arg.nil?
      false
    else
      true
    end
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |element| return true if yield(element) }
    elsif !arg.nil? and arg.is_a?(Class)
      my_each { |element| return true if element.class == arg }
    elsif arg.nil?
      my_each { |element| return true if element.nil? }
    else
      false
    end
  end

  def my_none?(arg = nil)
    if arg.is_a?(Class)
      my_each { |element| return false if element.class == arg }
      true
    elsif block_given?
      my_each { |element| return false if yield(element) }
      true
    elsif self.length.zero? || self.nil?
      true
    elsif !block_given? && arg.nil?
      my_any? { |element| return false if element == true }
      my_each { |element| return true if element.nil? || element == false }
    else
      false
    end
  end

  def my_count(arg = nil)
    counter = 0
    if arg.nil? && !block_given?
      my_each { counter += 1 }
      counter
    elsif !arg.nil? && arg.is_a?(Integer)
      my_each { |element| counter += 1 if element == arg }
      counter
    elsif block_given?
      my_each { |element| counter += 1 if yield(element) }
      counter
    end
  end

  def my_map(arg = nil)
    return to_enum(:my_map) unless block_given? || arg

    arr = []
    if arg
      my_each { |element| arr.push(arg.call(element)) }
    else
      my_each { |element| arr.push(yield(element)) }
    end
    arr
  end

  def my_inject(arg = nil, sym = nil)
    if block_given?
      acc = arg
      my_each { |element| acc = acc.nil? ? element : yield(acc, element) }
      acc
    elsif arg.is_a?(Symbol)
      acc = nil
      my_each { |element| acc = acc.nil? ? element : acc.send(arg, element) }
      acc
    elsif arg.is_a?(Integer) && sym.nil?
      arg.times do
        my_each { |element| acc = acc.nil? ? element : yield(acc, element) }
      end
      acc
    elsif arg.is_a?(Integer) && sym.is_a?(Symbol)
      acc = arg
      my_each { |element| acc = acc.nil? ? element : acc.send(sym, element) }
      acc
    end
  end

  def multiply_els(array)
    array.my_inject(:*)
  end
end
