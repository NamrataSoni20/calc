# calculate_fraction method to perform the arithmetic operations on fractions
def calculate_fraction(operation, fraction1, fraction2)
  num1, den1 = fraction1[:numerator], fraction1[:denominator]
  num2, den2 = fraction2[:numerator], fraction2[:denominator]

  case operation
  when '+'
    result_num = num1 * den2 + num2 * den1
    result_den = den1 * den2
  when '-'
    result_num = num1 * den2 - num2 * den1
    result_den = den1 * den2
  when '*'
    result_num = num1 * num2
    result_den = den1 * den2
  when '/'
    result_num = num1 * den2
    result_den = den1 * num2
  else
    puts "Invalid operator"
    return nil
  end

  simplify_fraction(result_num, result_den)
end

# simplify_fraction method to simplify fractions
def simplify_fraction(numerator, denominator)
  gcd = numerator.gcd(denominator)
  { numerator: numerator / gcd, denominator: denominator / gcd }
end

# parse_mixed_number method to parse mixed number strings into fractions
def parse_mixed_number(mixed_number)
  if mixed_number.include?('&')
    whole, fraction = mixed_number.split('&')
    numerator, denominator = fraction.split('/').map(&:to_i)
    numerator += whole.to_i * denominator
    { numerator: numerator, denominator: denominator }
  else
    { numerator: mixed_number.to_i, denominator: 1 }
  end
end

# Main program loop
loop do
  print "Enter an expression (operand operator operand): (or 'exit' to quit): "
  expression = gets.chomp
  break if expression.downcase == 'exit'

  tokens = expression.split(/\s+/)
  print tokens
  if tokens.size != 3
    puts 'Invalid expression format. Please provide an expression in the format: operand operator operand'
    redo
  end
  
  operand1 = parse_mixed_number(tokens[0])
  operator = tokens[1]
  operand2 = parse_mixed_number(tokens[2])

  result = calculate_fraction(operator, operand1, operand2)
  if result
    whole = result[:numerator] / result[:denominator]
    numerator = result[:numerator] % result[:denominator]
    denominator = result[:denominator]
    
    if whole.zero?
      puts " Result: #{numerator}/#{denominator}"
    else
      if numerator.zero? 
        puts " Result: #{whole}"
      else 
        puts " Result: #{whole}&#{numerator}/#{denominator}"
      end 
      
    end
  end
end
