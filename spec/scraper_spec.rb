# frozen_string_literal: true

require_relative '../lib/scraper.rb'
require 'byebug'
require 'open-uri'
require 'nokogiri'

describe Scraper do
  scrap = Scraper.new

  




  context '#invalid_input' do
    it 'Verify the input "city" to be correct' do
      expect(scrap.invalid_input('city')).to be false
    end
    it 'Verify the input "title" to be correct' do
      expect(scrap.invalid_input('title')).to be false
    end
    it 'Verify the input "company" to be correct' do
      expect(scrap.invalid_input('company')).to be false
    end
    it 'Verify the input "date" to be correct' do
      expect(scrap.invalid_input('date')).to be false
    end
    it 'Verify the input "all" to be correct' do
      expect(scrap.invalid_input('all')).to be false
    end
    it 'Verify the input "arfs" to be invalid' do
      expect(scrap.invalid_input('arfs')).to be true
    end
  end
end
