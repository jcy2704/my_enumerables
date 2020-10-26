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
end
