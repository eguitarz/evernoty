require 'evernote_oauth'
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

make_note(note_store, 'Evernoty', '<h1>Test</h1>')