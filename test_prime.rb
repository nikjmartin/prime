#!/usr/bin/ruby

require "./prime"
require "test/unit"

class TestPrime < Test::Unit::TestCase
  
  def test_generate_prime_numbers
  
    file = File.open("./first_thousand_primes.txt", "r")
    data = file.read
    file.close
    expected_primes = data.scan(/\d+/)
    expected_primes.collect! { |i| i.to_i }
    
    assert_equal(expected_primes, generate_primes(1000))
  end
  
  def test_generate_multiplication_table
    expected_multiplication_table = Hash[
      1, Hash[4, 4, 5, 5, 6, 6],
      2, Hash[4, 8, 5, 10, 6, 12],
      3, Hash[4, 12, 5, 15, 6, 18],
    ]
    generated_multiplication_table = generate_multiplication_table([1, 2, 3], [4, 5, 6])
    assert_equal(expected_multiplication_table, generated_multiplication_table)
  end
end
