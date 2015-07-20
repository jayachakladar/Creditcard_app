class Validator
  
  def initialize(request)
    @request = request
    @allowed_actions = ["ADD", "CHARGE", "CREDIT", "END"]
  end

  def argument_check
    request_array = @request.split(" ")
    unless request_array.first.nil?
      unless @allowed_actions.include?(request_array.first.upcase)
        msg = "Wrong action entered, please use Add, Charge, Credit or End."
        return ["error", msg]
      else
        if request_array.first.upcase == @allowed_actions.last
          msg = "Goodbye."
          return ["quit", msg]
        else
          # count number of parameters to check
          case request_array.first.upcase
            when /ADD/ then puts 
              if request_array.length == 4 
                return ["success"]
              else
                msg = "Wrong number of arguments. Usage: Add <Name> <CreditCard Number> <Credit limit>"
                return ["error", msg]
              end;
            when /CHARGE|CREDIT/ then
              if request_array.length == 3 
                return ["success"]
              else
                msg = "Wrong number of arguments. Usage: Charge|Credit <Name> <Amount>"
                return ["error", msg]
              end; 
            end
          end
        end
     else
       return ["error", msg]
     end
  end
  
end