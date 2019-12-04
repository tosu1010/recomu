require 'nokogiri'
require 'open-uri'

url = 'https://ja.wikipedia.org/wiki/%E9%9F%B3%E6%A5%BD%E3%81%AE%E3%82%B8%E3%83%A3%E3%83%B3%E3%83%AB%E4%B8%80%E8%A6%A7'
charset = nil

html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
for i in 1..10 do
  list = doc.at_xpath("//*[@id='mw-content-text']/div/ul[#{i}]").css('li')
  list.each do |elem|
    Tag.create(name: elem.text)
  end
end
