# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'byebug'

# Class
class Scraper
  attr_reader :url, :unparsed_page, :parsed_page, :job_adds, :title, :company, :city, :date, :all, :job

  def initialize
    @url = 'https://www.backpackerjobboard.com.au/jobs-in/western-australia/?p=1'
    @unparsed_page = HTTParty.get(url)
    @parsed_page = Nokogiri::HTML(unparsed_page)
    @job_adds = parsed_page.css('div.job-details')
  end

  def search(to_find)
    @job_adds.each do |job_add|
      @job = {
        title: job_add.css('h3').text,
        company: job_add.css('span')[1].text,
        city: job_add.css('span')[3].text,
        date: job_add.css('span.job-datestamp').text
      }
      #   jobs = []
      #   jobs << @job

      case to_find
      when 'title'
        p @job[:title]
      when 'company'
        p @job[:company]
      when 'city'
        p  @job[:city]
      when 'date'
        p  @job[:date]
      when 'all'
        p  @job[:title]
        p  @job[:company]
        p  @job[:city]
        p  @job[:date]
        p  '----------'
      end
    end
    'That\'s all! Good luck, and good rutes'
  end

  def invalid_input(to_find)
    invalid = true
    if to_find == 'city' || to_find == 'company' || to_find == 'date' || to_find == 'title' || to_find == 'all'
      invalid = false
    end

    invalid
  end
end
