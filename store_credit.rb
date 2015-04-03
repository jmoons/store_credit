class TestCase
  def initialize(credit, item_prices)
    @credit           = credit
    @item_prices      = item_prices
    @number_of_items  = @item_prices.length
    @current_index    = 0
  end

  def execute_test
    @result_hash = iterate_and_test_and_return_winner
    self
  end

  def print_results(print_mode="submission")
    if ( print_mode == "submission" )
      "#{@result_hash[0][:position_in_prices]} #{@result_hash[1][:position_in_prices]}"
    else
      puts "Winning Positions:  #{@result_hash[0][:position_in_prices]}, #{@result_hash[1][:position_in_prices]}"
      puts "Winning Prices:     #{@result_hash[0][:price]}, #{@result_hash[1][:price]}"
      puts "Winning Indicies:   #{@result_hash[0][:index]}, #{@result_hash[1][:index]}"
    end
  end

  private

  def iterate_and_test_and_return_winner
    if ( (@current_index + 1) == @number_of_items)
      puts "I found no winners sucka!"
      return
    end

    found_match = false

    ( (@current_index + 1)...(@number_of_items) ).each do |candidate_index|
      if (test_starting_and_candidate_index(@current_index, candidate_index) )
        found_match = true
        return  [
                  {:index => @current_index,    :position_in_prices => @current_index   + 1, :price => @item_prices[@current_index]}, 
                  {:index => candidate_index,  :position_in_prices  => candidate_index + 1,  :price => @item_prices[candidate_index]} 
                ]
      end
    end
    if (!found_match)
      @current_index += 1
      iterate_and_test_and_return_winner
    end

  end

  def test_starting_and_candidate_index(current_index, candidate_index)
    @credit == @item_prices[current_index] + @item_prices[candidate_index]
  end

end

def print_separator
  puts "================================================="
end

class StoreCreditInputParser
  def initialize(file_to_parse)
    @file_to_parse = File.open(file_to_parse, "r")
    @number_of_test_cases = @file_to_parse.readline.to_i
  end

  def generate_test_cases
    test_cases = []
    (1 .. @number_of_test_cases).each do |test_case_number|
      credit            = @file_to_parse.readline.to_i
      number_of_prices  = @file_to_parse.readline
      prices            = @file_to_parse.readline.split(' ').map(&:to_i)

      test_cases << TestCase.new(credit, prices)
    end
    @file_to_parse.close

    test_cases
  end

end

scip = StoreCreditInputParser.new("test_files/A-small-practice.in").generate_test_cases
scip.each_with_index{ |test_case, index| puts "Case ##{index + 1}: #{test_case.execute_test.print_results}"}

# tc1 = TestCase.new(100, [5, 75, 25]).execute_test.print_results("dude")
# print_separator
# tc2 = TestCase.new(200, [150, 24, 79, 50, 88, 345, 3]).execute_test.print_results
# print_separator