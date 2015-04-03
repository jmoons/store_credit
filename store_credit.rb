class TestCase
  def initialize(credit, item_prices)
    @credit           = credit
    @item_prices      = item_prices
    @number_of_items  = @item_prices.length
  end

  def begin_test
    iterate_and_test_collection(0)
  end

  private

  def iterate_and_test_collection(starting_index)
    if ( (starting_index + 1) == @number_of_items)
      puts "I found no winners sucka!"
      return
    end

    found_match = false

    ( (starting_index + 1) ... @number_of_items ).each do |candidate_index|
      if ( test_starting_and_candidate_index(starting_index, candidate_index) )
        found_match = true
        winners = [ {:index => starting_index, :position_in_prices => starting_index + 1, :price => @item_prices[starting_index]},
                    {:index => candidate_index, :position_in_prices => candidate_index + 1, :price => @item_prices[candidate_index]} ]
        print_winners( winners )
        break
      end
    end
    if (!found_match)
      iterate_and_test_collection(starting_index += 1)
    end
  end

  def test_starting_and_candidate_index(starting_index, candidate_index)
    @credit == @item_prices[starting_index] + @item_prices[candidate_index]
  end

  def print_winners(winners)
    puts "Winning Positions:  #{winners[0][:position_in_prices]}, #{winners[1][:position_in_prices]}"
    puts "Winning Prices:     #{winners[0][:price]}, #{winners[1][:price]}"
    puts "Winning Indicies:   #{winners[0][:index]}, #{winners[1][:index]}"
  end
end

def print_separator
  puts "================================================="
end

tc1 = TestCase.new(100, [5, 75, 25]).begin_test
print_separator
tc2 = TestCase.new(200, [150, 24, 79, 50, 88, 345, 3]).begin_test
print_separator
tc3 = TestCase.new(8, [2, 1, 9, 4, 4, 56, 90, 3]).begin_test
print_separator
tc3 = TestCase.new(8, [2, 1, 9, 4, 1, 56, 90, 3]).begin_test


# Output
# Case #1: 2 3
# Case #2: 1 4
# Case #3: 4 5