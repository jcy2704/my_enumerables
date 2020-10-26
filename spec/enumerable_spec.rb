require '../enumarable.rb'

describe 'Enumerable' do
  arr = [1, 2, 3, 4]
  hash = { 'a' => 1, 'b' => 2, 'c' => 3 }
  range = (1..4)
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
      expect(hash.my_each { |n| puts n }).to eq(hash.each { |n| puts n})
    end

    it 'iterates in a range' do
      expect(range.my_each { |n| puts n }).to eq(range.each { |n| puts n})
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
end
