require 'evernote_oauth'

client = EvernoteOAuth::Client.new(
	consumer_key: 'eguitarz',
  consumer_secret: '5056cd90e0a9ce97',
  sandbox: true
 )
request_token = client.request_token(:oauth_callback => 'http://localhost/')
request_token.authorize_url