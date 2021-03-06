# include thrift-generated code
$:.push('./gen-rb')

require "rubygems"
require "bundler/setup"
require 'thrift'

require 'auth/auth_constants'
require 'auth/server'
require 'notes/notes_constants'
require 'notes/server'
require 'billing/billing_constants'
require 'billing/server'
require './common/connection'

auth = Connection.open(9000, Auth::Server::Client)
notes = Connection.open(9001, Notes::Server::Client)
billing = Connection.open(9002, Billing::Server::Client)

at_exit do
  auth.close
  notes.close
end

require 'sinatra'
require 'sinatra/json'

set :bind, '0.0.0.0'

post "/api/notes" do
  text = params['text']
  token = request.env['HTTP_AUTH_TOKEN']
  note = nil
  user = auth.with_reconnection { auth.endpoint.getUserByToken(token) }
  note = notes.with_reconnection { notes.endpoint.addNote(user, text) }
  premium = billing.with_reconnection { billing.endpoint.isPremiumUser(user.id) }
  if note
    json ok: true, premium: premium, note: {
      id: note.id,
      user_id: note.user_id,
      text: note.text
    }
  else
    json ok: false
  end
end

