require_relative '../lib/scraper.rb'
require 'byebug'
require 'open-uri'
require 'nokogiri'

describe Scraper do
  scrap = Scraper.new

  context '#search' do
    it 'return a hash with jobs' do
      expect(scrap.job).to be_a(Hash)
    end
  end

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

  context '#change_page' do
    scrap.change_page('all')

    it 'changes the number of the page' do
      expect(scrap.page).to eq 2
    end
    it 'check if the url changed' do
      expect("https://www.backpackerjobboard.com.au/jobs-in/western-australia/?p=#{@page}").to eq 'https://www.backpackerjobboard.com.au/jobs-in/western-australia/?p='
    end
  end

  context '#results' do
    it 'prints results asked by user when type "date"' do
      expect(scrap.results('date')).to eq scrap.job[:date]
    end
    it 'prints results asked by user when type "city"' do
      expect(scrap.results('city')).to eq scrap.job[:city]
    end
    it 'prints results asked by user when type "title"' do
      expect(scrap.results('title')).to eq scrap.job[:title]
    end
    it 'prints results asked by user when type "company" ' do
      expect(scrap.results('company')).to eq scrap.job[:company]
    end
  end
end
