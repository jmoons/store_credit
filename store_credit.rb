class TestCase
  def initialize(credit, item_prices)
    @credit           = credit
    @item_prices      = item_prices
    @number_of_items  = @item_prices.length
    @current_index    = 0
  end

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

  private

  def test_starting_and_candidate_index(current_index, candidate_index)
    @credit == @item_prices[current_index] + @item_prices[candidate_index]
  end

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

class StoreCreditTestRunner
  def initialize(input_file, print_mode="submission")
    @print_mode = print_mode
    @test_cases = StoreCreditInputParser.new(input_file).generate_test_cases
  end

  def run
    @test_cases.each_with_index do |test_case, index|
      test_case_result = test_case.iterate_and_test_and_return_winner
      print_result(index, test_case_result)
    end
  end

  private

  def print_result(test_case_index, test_case_result)
    if ( @print_mode == "submission" )
      puts "Case ##{test_case_index + 1}: #{test_case_result[0][:position_in_prices]} #{test_case_result[1][:position_in_prices]}"
    else
      puts "Winning Positions:  #{test_case_result[0][:position_in_prices]}, #{test_case_result[1][:position_in_prices]}"
      puts "Winning Prices:     #{test_case_result[0][:price]}, #{test_case_result[1][:price]}"
      puts "Winning Indicies:   #{test_case_result[0][:index]}, #{test_case_result[1][:index]}"
      puts "================================================="
    end
  end

end

StoreCreditTestRunner.new("test_files/A-small-practice.in").run