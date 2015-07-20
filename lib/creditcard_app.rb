require 'creditcard_app/validator'
require 'creditcard_app/manager'


class CreditcardApp

 def self.runapp
   @manager = Manager.new
   loop do
      puts "Enter an action: (Add, Charge, Credit, End)"
      request = gets.chomp 
      
      validator = Validator.new(request)
      @status, @message = validator.argument_check
      case @status
        when "quit" then @manager.report; puts @message; break
        when "error" then puts @message; next
        when "success" then
          @status, @message = @manager.process_request(request);
      end      
   end
 end


end
