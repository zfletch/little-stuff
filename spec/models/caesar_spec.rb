require 'rails_helper'

describe "Caesar" do
  describe "#encode" do
    let(:input) { "azAZ 09+" }
    let(:number) { 1 }

    subject { Caesar.encode(input, number) }

    context "shift one" do
      it { should eq("b{B[!1:,") }
    end

    context "shift two" do
      let(:number) { 2 }

      it { should eq("c|C\\\"2;-") }
    end

    context "shift zero (edge-case)" do
      let(:number) { 0 }

      it { should eq(input) }
    end

    context "shift beyond last char in UTF-8" do
      let(:input) { "\u{1FFFF}" }

      it "wraps to the first character in UTF-8" do
        should eq("\x00")
      end
    end

    context "shift before first char in UTF-8 (edge-case, unprintable)" do
      let(:input) { "\x00" }
      let(:number) { -1 }

      it "wraps to the last character in UTF-8" do
        should eq("\u{1FFFF}")
      end
    end

    context "empty string (edge-case)" do
      let(:input) { "" }
      let(:number) { 1 }

      it { should eq("") }
    end

    # This aspect of the cipher was not called out as a requirement
    # of the exercise, but it is interesting nonetheless.
    describe "symmetric aspect of #encode" do
      let(:input) { Caesar.encode("a\u{1ffff}zAZ 09+\x00", 13) }

      subject { Caesar.encode(input, -13) }

      it { should eq("a\u{1ffff}zAZ 09+\x00") }
    end
  end
end
