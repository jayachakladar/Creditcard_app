class Account
  
  def initialize(account, status)
    @account = account
    @status = status    
  end
  
  
  def create(name, acct_num, acct_limit,flag)
    @account[name] = [acct_num, acct_limit.gsub("$", "")]
    @status[name] = flag     
  end
  
  def update
  end
  
end