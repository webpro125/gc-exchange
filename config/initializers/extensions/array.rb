class Array
  def group_by_count
    self.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
  end
end