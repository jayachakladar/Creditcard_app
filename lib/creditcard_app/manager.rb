require 'creditcard_app/luhn'
require 'creditcard_app/account'
require 'creditcard_app/balance'

class Manager
  
  def initialize    
    @account = Hash.new
    @status = Hash.new
    @balance = Hash.new
    
    @acct = Account.new(@account, @status)
    @acct_balance = Balance.new(@account, @status, @balance)
    
  end
  
  def process_request(request)
    @request_parameters = request.split(" ")    
    @luhn = Luhn.new(@request_parameters[2]);
    self.send(@request_parameters[0].downcase)
  end
  
  def add
    if @request_parameters[2].size <= 19
     if @luhn.check
       name = @request_parameters[1]
       acct_num = @request_parameters[2]
       acct_limit = @request_parameters[3]
       @acct.create(name, acct_num, acct_limit,true)
       @acct_balance.create(name)
     else
       name = @request_parameters[1]
       acct_num = @request_parameters[2]
       acct_limit = @request_parameters[3]
       @acct.create(name, acct_num, acct_limit,false)
     end
    else
      puts "Account number number must be upto 19 digits"
    end
    return
  end
  
  def charge
    # if user is active, and charge is not going over limit, apply charge and create new balance
    name = @request_parameters[1]
    amount = @request_parameters[2]
    @acct_balance.charge(name, amount)
  end
  
  def credit
    # if user is active, decrease balance going to negative if needed
    name = @request_parameters[1]
    amount = @request_parameters[2]
    @acct_balance.credit(name, amount)
  end
  
  def report
    @status.sort.each do |acct|
      if acct[1]
        puts "#{acct[0]}: $#{@balance[acct[0]]}"
      else
        puts "#{acct[0]}: error"
      end
    end
  end
  
end