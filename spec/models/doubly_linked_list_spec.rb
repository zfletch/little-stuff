require 'rails_helper'

RSpec.describe "DoublyLinkedList", type: :model do
  let!(:list) { DoublyLinkedList.new }

  describe "pop" do
    subject { list.pop }

    context "given an empty list" do
      it { should be_nil }
    end

    context "given a non-empty list" do
      before { list.push(1, 2) }

      it "pops the right-most element" do
        should eq(2)
        expect(list.to_a).to eq([1])
      end
    end
  end

  describe "push" do
    subject { list.push(1234) }

    context "given an empty list" do
      it { should eq(list) }
      it { subject; expect(list.to_a).to eq([1234]) }
    end

    context "given a list that already has something in it" do
      before { list.push(-100) }

      it { should eq(list) }
      it { subject; expect(list.to_a).to eq([-100, 1234]) }
    end
  end

  describe "shift" do
    subject { list.shift }

    context "given an empty list" do
      it { should be_nil }
    end

    context "given a non-empty list" do
      before { list.push(1, 2) }

      it "shifts off the left-most element" do
        should eq(1)
        expect(list.to_a).to eq([2])
      end
    end
  end

  describe "take" do
    subject { list.take(number) }

    before { list.push(1, 2, 3) }

    context "taking 0 elements (edge case)" do
      let(:number) { 0 }

      it { should eq([]) }
    end

    context "taking first elements" do
      let(:number) { 2 }

      it { should eq([1, 2]) }
    end

    context "taking more elements than are in the list (edge case)" do
      let(:number) { 20 }

      it { should eq(list.to_a) }
    end
  end

  describe "to_a" do
    subject { list.to_a }

    context "given an empty list" do
      it { should eq([]) }
    end

    context "given some elements" do
      before { list.push(1, 2) }

      it { should eq([1, 2]) }
    end
  end
end
