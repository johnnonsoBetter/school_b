json.extract! article, :id, :body, :image_data, :created_at, :updated_at
json.url article_url(article, format: :json)
