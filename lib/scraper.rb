# frozen_string_literal: true

require 'nokogiri'
require 'byebug'
require 'open-uri'

# Class
class Scraper
  attr_reader :url, :unparsed_page, :parsed_page, :job_adds, :title, :company, :city, :date, :all, :job, :page

  def initialize
    @url = "https://www.backpackerjobboard.com.au/jobs-in/western-australia/?p=#{@page}"
    @unparsed_page = URI.open(@url)
    @parsed_page = Nokogiri::HTML(unparsed_page)
    @job_adds = parsed_page.css('div.job-details')
    @page = 1
  end

  def search(to_find)
    @job_adds.each do |job_add|
      @job = {
        title: job_add.css('h3').text,
        company: job_add.css('span')[1].text,
        city: job_add.css('span')[3].text,
        date: job_add.css('span.job-datestamp').text
      }
      results(to_find)
    end
    change_page(to_find)
  end

  def change_page(to_find)
    if @page < 2

      @page += 1
      @url = "https://www.backpackerjobboard.com.au/jobs-in/western-australia/?p=#{@page}"
      @unparsed_page = URI.open(@url)
      @parsed_page = Nokogiri::HTML(unparsed_page)
      @job_adds = parsed_page.css('div.job-details')
      search(to_find)
    end
  end

  def results(to_find)
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
      p  '---------'
    end
  end

  def invalid_input(to_find)
    invalid = true
    if to_find == 'city' || to_find == 'company' || to_find == 'date' || to_find == 'title' || to_find == 'all'
      invalid = false
    end

    invalid
  end
end
