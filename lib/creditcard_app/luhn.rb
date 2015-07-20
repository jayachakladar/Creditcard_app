class Luhn
  def initialize(acct_number)
    @acct_number = acct_number
  end
  
  def check
    @acct_number.reverse!
    @acct_number_array = @acct_number.each_char.to_a
    @acct_number_array = @acct_number_array.map {|x| x.to_i}
    s1 = sum_odd
    s2 = sum_even
    total = s1 + s2
    if total % 10 == 0
      return true
    else
      return false
    end
  end
  
  def sum_odd
    odd_array = @acct_number_array.values_at(* @acct_number_array.each_index.select {|i| i.even?})
    return odd_array.inject(0) {|sum,x| sum += x }
  end
  
  def sum_even
    even_array = @acct_number_array.values_at(* @acct_number_array.each_index.select {|i| i.odd?})
    even_array = even_array.map{|x| x * 2}
    return even_array.inject(0) {|sum,x| sum + x.to_s.split(//).inject(0) {|z, y| z + y.to_i}}
  end
  
  
end