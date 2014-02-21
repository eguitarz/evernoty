# app.rb
require 'sinatra'
require 'evernote_oauth'

enable :sessions

get '/' do
  if session[:access_token]
  	redirect '/notes'
  else
  	redirect '/authorize'
  end
end

get '/authorize' do
	callback_url = request.url.chomp("authorize").concat('redirect')

	client = EvernoteOAuth::Client.new(
		consumer_key: 'eguitarz',
		consumer_secret: '5056cd90e0a9ce97',
		sandbox: true
	)
	session[:request_token] = client.request_token(:oauth_callback => callback_url)
      redirect session[:request_token].authorize_url
end

get '/redirect' do
	access_token = session[:request_token].get_access_token(:oauth_verifier => params[:oauth_verifier]).token
	session[:access_token] = access_token
	redirect '/'
end

get '/reset' do
	session.clear
	redirect '/'
end

get '/notes/new' do
	token = session[:access_token]
	client = EvernoteOAuth::Client.new(sandbox: true, token: token)
	note_store = client.note_store
	note = Evernote::EDAM::Type::Note.new
	note.title = 'Evernoty'
	note.content = '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Hello, world!</en-note>'
	note_store.createNote(token, note)

	haml :notes_new
end

get '/notes' do
	token = session[:access_token]
	client = EvernoteOAuth::Client.new(sandbox: true, token: token)
	note_store = client.note_store
	@notebooks = note_store.listNotebooks(token)

	haml :notes
end