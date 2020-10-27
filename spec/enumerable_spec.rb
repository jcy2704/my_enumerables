# rubocop:disable Style/EvenOdd
# rubocop:disable Layout/LineLength

require './enumarable.rb'

describe 'Enumerable' do
  let(:arr) { [1, 2, 3, 4] }
  let(:str) { %w[ant bear cat] }
  let(:hash) { { 'a' => 1, 'b' => 2, 'c' => 3 } }
  let(:range) { (1..4) }

  describe '#my_each' do
    it 'return enum if no block given' do
      expect(arr.my_each).to be_an Enumerator
      expect(hash.my_each).to be_an Enumerator
      expect(range.my_each).to be_an Enumerator
    end

    it 'iterates in an array' do
      expect(arr.my_each { |n| puts n }).to eq(arr.each { |n| puts n })
    end

    it 'iterates in a hash' do
      expect(hash.my_each { |n| puts n }).to eq(hash.each { |n| puts n })
    end

    it 'iterates in a range' do
      expect(range.my_each { |n| puts n }).to eq(range.each { |n| puts n })
    end
  end

  describe 'my_each_with_index' do
    it 'return enum if no block given' do
      expect(arr.my_each_with_index).to be_an Enumerator
      expect(hash.my_each_with_index).to be_an Enumerator
      expect(range.my_each_with_index).to be_an Enumerator
    end

    it 'iterates in an array' do
      expect(arr.my_each_with_index { |n, i| puts n, i }).to eq(arr.each_with_index { |n, i| puts n, i })
    end

    it 'iterates in a hash' do
      expect(hash.my_each_with_index { |n, i| puts n, i }).to eq(hash.each_with_index { |n, i| puts n, i })
    end

    it 'iterates in a range' do
      expect(range.my_each_with_index { |n, i| puts n, i }).to eq(range.each_with_index { |n, i| puts n, i })
    end
  end

  describe '#my_select' do
    it 'return enum if no block given' do
      expect(arr.my_select).to be_an Enumerator
      expect(hash.my_select).to be_an Enumerator
      expect(range.my_select).to be_an Enumerator
    end

    it 'return new array' do
      expect(arr.my_select { |n| n < 1 }).to eq(arr.select { |n| n < 1 })
      expect(range.my_select { |n| n == 3 }).to eq(range.select { |n| n == 3 })
    end

    it 'return new hash' do
      expect(hash.my_select { |n| n == 'a' }).to eq(hash.select { |n| n == 'a' })
    end
  end

  describe '#my_all?' do
    it 'check if every class true' do
      expect(arr.my_all? { |n| n == Integer }).to eq(arr.all? { |n| n == Integer })
    end

    it 'check if every element match arg' do
      expect(arr.my_all?(Numeric)).to eq(arr.all?(Numeric))
    end

    it 'check if everthing is true with no arg' do
      expect(arr.my_all?).to eq(arr.all?)
    end

    it 'check if matches regexp' do
      expect(str.my_all?(/t/)).to eq(str.all?(/t/))
    end

    it 'check if empty' do
      expect([].my_all?).to eq([].all?)
    end
  end

  describe '#my_any?' do
    it 'checks if at least one is true' do
      expect(str.my_any? { |n| n.length >= 3 }).to eq(str.any? { |word| word.length >= 3 })
    end

    it 'checks if one matches the regexp' do
      expect(str.my_any?(/d/)).to eq(str.any?(/d/))
    end

    it 'checks if one matches argument' do
      expect([nil, true, 99].my_any?(Integer)).to eq([nil, true, 99].any?(Integer))
    end

    it 'checks if one is true' do
      expect([nil, true, 99].my_any?).to eq([nil, true, 99].any?)
    end

    it 'checks if there is something' do
      expect([].my_any?).to eq([].any?)
    end
  end

  describe '#my_none?' do
    it 'checks if at least one is false' do
      expect(str.my_none? { |n| n.length == 5 }).to eq(str.none? { |word| word.length == 5 })
    end

    it 'checks if none matches the regexp' do
      expect(str.my_none?(/d/)).to eq(str.none?(/d/))
    end

    it 'checks if one matches argument' do
      expect([1, 3.14, 42].my_none?(Float)).to eq([1, 3.14, 42].none?(Float))
    end

    it 'checks if empty' do
      expect([].my_none?).to eq([].none?)
    end

    it 'checks if nil' do
      expect([nil].my_none?).to eq([nil].none?)
    end

    it 'return false if one true' do
      expect([false, nil, true].my_none?).to eq([false, nil, true].none?)
    end
  end

  describe '#my_count' do
    it 'count elements in array' do
      expect(arr.my_count).to eq(arr.count)
    end

    it 'count arg times' do
      expect(arr.my_count(2)).to eq(arr.count(2))
    end

    it 'count by block given' do
      expect(arr.my_count { |x| x % 2 == 0 }).to eq(arr.count { |x| x % 2 == 0 })
    end
  end

  describe '#my_map' do
    it 'returns new array with changed values' do
      expect(range.my_map { |i| i * i }).to eq(range.map { |i| i * i })
      expect(range.my_map { 'cat' }).to eq(range.map { 'cat' })
    end
  end

  describe '#my_inject' do
    it 'Sum some numbers' do
      expect((5..10).my_inject(:+)).to eq((5..10).inject(:+))
    end

    it 'Same using a block and inject' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eq((5..10).inject { |sum, n| sum + n })
    end

    it 'Multiply some numbers' do
      expect((5..10).my_inject(1, :*)).to eq((5..10).inject(1, :*))
    end

    it 'Find the longest word' do
      expect(%w[cat sheep bear].my_inject { |m, w| m.length > w.length ? m : w }).to eq(%w[cat sheep bear].inject { |m, w| m.length > w.length ? m : w })
    end
  end
end

describe 'multiply_els' do
  it 'multiply numbers in array' do
    expect(multiply_els([1, 2, 3])).to eq([1, 2, 3].inject(:*))
  end
end

# rubocop:enable Layout/LineLength
# rubocop:enable Style/EvenOdd
