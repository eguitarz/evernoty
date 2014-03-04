require 'evernote_oauth'
require 'nokogiri'
require 'open-uri'
require "#{File.dirname(__FILE__)}/evernote"

DEVELOPER_TOKEN = ENV['EVERNOTE_TOKEN']

client = EvernoteOAuth::Client.new(
	token: DEVELOPER_TOKEN,
	sandbox: true
 )

puts 'Accessing...'
note_store = client.note_store
notebooks = note_store.listNotebooks
notebooks.each do |notebook|
  puts "Notebook: #{notebook.name}";
end

uri = 'http://tw.yahoo.com'
document = Nokogiri::HTML( open(uri) )
document.css('script').remove
text = ''
node = find_node(document, 'body')
text = node.inner_text

p text

make_note(note_store, 'Evernoty', "#{text}")