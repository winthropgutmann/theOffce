require 'rubygems'
require 'mechanize'
require 'Nokogiri'
require 'pp'
require 'pry'
require 'mysql2'

# db = Mysql.new(hostname, username, password, database)

seasons = Array.new
agent = Mechanize.new { |agent|
    agent.user_agent_alias = 'Windows Chrome'
}

agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
page = agent.get('https://en.wikipedia.org/wiki/The_Office_(U.S._TV_series)')


page.links_with(:href=> /U.S._season_/).each do |link|

  if !seasons.include?(link.href)
    seasons.push(link.href)
  end
end

open('office_detail.txt', 'w') { |f|

  seasons.each do |season|
    f.puts "\n https://en.wikipedia.org"+season + "\n \n"
    agent.get("https://en.wikipedia.org"+season) do |page|
      # binding.pry
      this = page.search('table.wikitable').search('tr').search('td').map{|n| n.text}


      i=0
      loop do
        if !this[i].nil?
          # f.puts  "#{i}  #{this[i]} \n"
          no = this[i];
          title = this[i+1]
          director = this[i+2]
          writer = this[i+3]
          air_date = this[i+4]
          prod_code = this[i+5]
          viewers = this[i+6]
          desc = this[i+7]

          f.puts "no: #{no}, title: #{title}, director: #{director}, writer: #{writer}, date: #{air_date}, prod: #{prod_code}, view: #{viewers}, desc: #{desc} \n \n"
        else
          i=0
          break
        end
        i=i+8
      end
      i=0
    end
  end
}