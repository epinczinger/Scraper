require 'nokogiri'
require 'byebug'
require 'open-uri'

# Class
class Scraper
  attr_reader :url, :unparsed_page, :parsed_page, :title, :company, :city, :date, :all, :job, :page

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
      p results(to_find)
    end
    change_page(to_find)
  end

  def change_page(to_find)
    return unless @page < 2

    @page += 1
    @url = "https://www.backpackerjobboard.com.au/jobs-in/western-australia/?p=#{@page}"
    @unparsed_page = URI.open(@url)
    @parsed_page = Nokogiri::HTML(unparsed_page)
    @job_adds = parsed_page.css('div.job-details')
    search(to_find)
  end

  def results(to_find)
    case to_find
    when 'title'
      @job[:title]
    when 'company'
      @job[:company]
    when 'city'
      @job[:city]
    when 'date'
      @job[:date]
    when 'all'
      p @job[:title]
      p @job[:company]
      p @job[:city]
      p @job[:date]
      '---------'
    end
  end

  def invalid_input(to_find)
    invalid = true
    invalid = false if to_find.match?(/city|company|date|title|all/)

    invalid
  end
end
