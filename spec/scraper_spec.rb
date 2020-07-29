# frozen_string_literal: true

require_relative '../lib/scraper.rb'
require 'byebug'
require 'open-uri'
require 'nokogiri'

describe Scraper do
    scrap = Scraper.new
  context '#invalid_input' do
    it 'Verify the input to be "all"' do
      expect(scrap.invalid_input('city').to be false
    end
  end
end
