module Caesar
  def self.encode(string, number)
    string.chars.map { |c| (c.ord + number) % (0x1ffff + 1) }.map(&:chr).join
  end
end
