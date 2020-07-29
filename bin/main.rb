#!/usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'byebug'
require_relative '../lib/scraper.rb'

puts "------\nYou are gonna use Backscraper, the easiest way to find your next job!"
puts "Be ready to find the job you are looking for! \n-----"

scrap = Scraper.new

puts "------\nChoose between: \'title\', \'company\', \'city\', \'date\' or \'all\' to get the results list"

to_find = gets.chomp

while scrap.invalid_input(to_find)
  puts "Invalid input, please type: \'title\', \'company\', \'city\', \'date\' or \'all\'"
  to_find = gets.chomp
end

puts scrap.search(to_find)
