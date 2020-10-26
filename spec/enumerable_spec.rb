require '../enumarable.rb'

describe 'Enumerable' do
  describe '#my_each' do
    arr = [1, 2, 3, 4]
    hash = { 'a' => 1, 'b' => 2, 'c' => 3 }
    range = (1..4)

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
    arr = [1, 2, 3, 4]
    hash = { 'a' => 1, 'b' => 2, 'c' => 3 }
    range = (1..4)

    it 'return enum if no block given' do
      expect(arr.my_each_with_index).to be_an Enumerator
      expect(hash.my_each_with_index).to be_an Enumerator
      expect(range.my_each_with_index).to be_an Enumerator
    end

    it 'iterates in an array' do
      expect(arr.my_each_with_index { |n, i| puts n, i }).to eq(arr.each_with_index { |n, i| puts n, i })
    end

    it 'iterates in a hash' do
      expect(hash.my_each_with_index { |n, i| puts n, i }).to eq(hash.each_with_index { |n, i| puts n, i})
    end

    it 'iterates in a range' do
      expect(range.my_each_with_index { |n, i| puts n, i }).to eq(range.each_with_index { |n, i| puts n, i})
    end
  end

  # each_with_index { |val,index| puts "index: #{index} for #{val}" if val < 30}


end
