# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: github.com/cyu/rack-cors

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'http://localhost:3000'

#     resource '*',
#       headers: :any,
#       expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
#       methods: [:get, :post, :put, :patch, :delete, :options, :head]
#   end
# end
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.development?
      origins 'admin.localhost:3000'
    else
      origins 'https://admin.confamsch.com.ng'
    end

    resource '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end

   allow do
    if Rails.env.development?
      origins 'teacher.localhost:3000'
    else
      origins 'https://teacher.confamsch.com.ng'
    end

    resource '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end

  allow do
    if Rails.env.development?
      origins 'parent.localhost:3000'
    else
      origins  'https://parent.confamsch.com.ng'
    end

    resource '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end


  allow do
    if Rails.env.development?
      origins 'localhost:3000'
    else
      origins  'teacher.localhost:5000'
    end

    resource '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end

  allow do
    if Rails.env.development?
      origins 'localhost:3000'
    else
      origins  'parent.localhost:5000'
    end

    resource '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end

  allow do
    if Rails.env.development?
      origins 'localhost:3000'
    else
      origins  'admin.localhost:5000'
    end

    resource '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end


  allow do
    if Rails.env.development?
      origins 'localhost:3000'
    else
      origins  'https://confamsch.com.ng'
    end

    resource '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
