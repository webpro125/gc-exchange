class Array
  def group_by_count
    self.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
  end

  def cumulative_sum
    sum = 0
    self.map{|x| sum += x}
  end
end