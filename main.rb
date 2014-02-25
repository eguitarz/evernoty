require 'evernote_oauth'
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