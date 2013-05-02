#!/usr/bin/ruby

require 'set'

# Public: Generate a list of prime numbers
#
# upper_limit - The maximum integer value for a prime to be calculated
#
# Examples
#
#   generate_primes(10)
#   # => [2, 3, 5, 7]
#
# Returns a list of prime numbers
def generate_primes(upper_limit)
  primes = Array.new
  
  # Tally is a list of factors or prime numbers found.
  # We must use a running ceiling value called max_factor to calculate factors
  # to. max_tally_for_prime stores the maximum factor tallied for each prime
  # that was found.
  tally = Set.new  
  max_tally_for_prime = Hash.new
  max_factor = 100
  
  i = 2
  while primes.length < upper_limit do
    if tally.include?(i) == false
      primes.push i
      
      # Fill tally with multiples of the prime found
      j = i
      while j <= max_factor do
        tally.add j
        max_tally_for_prime[i] = j
        j += i
      end      
    end
    i += 1
    
    # When we reach half way to the max factor the ceiling is doubled and the
    # tally is extended
    if i > max_factor/2
        max_factor = max_factor*2
        primes.each do |prime|
            j = max_tally_for_prime[prime]
            while j <= max_factor
                j += prime
                tally.add j
            end
            max_tally_for_prime[prime] = j
        end
    end
  end
  return primes
end

# Public: Generate a hash containing a multiplication matrix
#
# row_values - The multiplication factor for rows
# column_values - The multiplication factor for columns
#
# Examples
#
#   generate_multiplication_table([1, 2, 3], [4, 5, 6])
#   # => {1=>{5=>5, 6=>6, 4=>4}, 2=>{5=>10, 6=>12, 4=>8}, 3=>{5=>15, 6=>18, 4=>12}}
#
# Returns a 2D hash containing first row keys then column keys
def generate_multiplication_table(row_values, column_values)
  multiplication_table = Hash.new
  row_values.each do |row|
    multiplication_table[row] = Hash.new
    column_values.each do |column|
      multiplication_table[row][column] = row*column
    end
  end
  return multiplication_table
end

# Public: Generate a table from a 2D hash
#
# table_values - A 2D hash containing rows and columns as keys
#
# Examples
#
#   table_values = generate_multiplication_table([1, 2, 3], [4, 5, 6])
#   print construct_table(table_values)
#   # =>         |   4    |   5    |   6    
#        -----------------------------------
#           1    |   4    |   5    |   6    
#        -----------------------------------
#           2    |   8    |   10   |   12   
#        -----------------------------------
#           3    |   12   |   15   |   18
#
# Returns a tabular representation of a 2D hash as a string
def construct_table(table_values)
  table = String.new
  column_width = 8
  
  if table_values.empty? then return table end
  
  # Construct column headers first
  columns = table_values.values()[0].keys.sort
  table << "".center(column_width)
  columns.each do |column|
    table << "|" + column.to_s.center(column_width)
  end
  
  table_width = table.length
  table << "\n"
  
  # Construct each row
  rows = table_values.keys.sort
  rows.each do |row|
    table << "".center(table_width, "-") + "\n"
    table << row.to_s.center(column_width)
    
    row_values = table_values[row]
    columns.each do |column|
      multiple = row_values[column]
      table << "|" + multiple.to_s.center(column_width)
    end
    table << "\n"
  end
  return table
end

if __FILE__ == $0
  upper_limit = 10

  if ARGV.length > 0
    begin
      upper_limit = Integer(ARGV[0])
    rescue
      p "Error: Non integer value provided as first argument"
      exit
    end
  end
  
  primes = generate_primes(upper_limit)
  table_values = generate_multiplication_table(primes, primes)
  table_text = construct_table(table_values)
  print "\n#{table_text}\n"
end
