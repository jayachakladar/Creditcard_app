require 'creditcard_app/validator'
require 'creditcard_app/manager'


request_array = []
each_request = ""

unless ARGV.size == 1
  puts "These are command line input"
  ARGV.each do|a|    
    unless a.include?("$")
      each_request += " #{a}"
    else
      each_request += " #{a}"
      request_array << each_request.lstrip
      each_request = ""
    end
  end
else
  puts "This is a file input"
  begin
    File.open(ARGV.first, "r").each_line do |line|
      request_array << line    
    end
  rescue Exception => e
    puts e.message
  end
  
end

@manager = Manager.new
request_array.each do |request|
    validator = Validator.new(request)
    @status, @message = validator.argument_check
    case @status
        when "quit" then @manager.report; puts @message; break
        when "error" then puts @message; next
        when "success" then
            @status, @message = @manager.process_request(request);
    end      
end

@manager.report 