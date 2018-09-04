def omniauth_stub(opts = {})
  default = {
    provider: opts[:provider],
    uid: '1234',
    opts[:provider] => {
      first_name: 'salty',
      last_name: 'dog',
      email: 'saltydog@test.com'
    }
  }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  stub = OmniAuth::AuthHash.new(
    'provider' => provider,
    'uid' => credentials[:uid],
    'info' => {
      'first_name' => user_hash[:first_name],
      'last_name' => user_hash[:last_name],
      'email' => user_hash[:email]
    }
  )

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[provider] = stub
end
