json.extract! resume, :id, :title, :description, :created_at, :updated_at
json.url resume_url(resume, format: :json)