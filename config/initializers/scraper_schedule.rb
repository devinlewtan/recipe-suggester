require 'nokogiri'
require 'open-uri'
require 'rufus-scheduler'
require 'rake'
require 'rubygems'
require 'watir'
require 'selenium-webdriver'
###
@@browser = Watir::Browser.new :chrome, headless: true
scheduler = Rufus::Scheduler.new
include RecipeHelper
scheduler.every "1d" do
    puts "BEGIN SCHEDULER at #{Time.now}"
    scrape
    puts "END SCHEDULER at #{Time.now}"
end
