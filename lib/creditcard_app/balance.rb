class Balance

  def initialize(account, status, balance)
    @account = account
    @status = status
    @balance = balance    
  end
  
  def create(name)
    @balance[name] = 0
  end
  
  def charge(name, amount)
    if @status[name] and ((@balance[name] + amount.gsub("$", "").to_i) < @account[name].last.to_i)
      @balance[name] += amount.gsub("$", "").to_i
    end
  end
  
  def credit(name, amount)
    if @status[name]
      @balance[name] -= amount.gsub("$", "").to_i
    end
  end
end