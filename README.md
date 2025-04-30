# 📚 Rails API Study Project

This is a small **Rails API-only** application built as a learning project to explore how Ruby on Rails can be used for building clean, testable RESTful APIs. It manages a `Task` resource with full CRUD support, JSON serialization, CORS handling, and RSpec testing.

---

## ✨ Features

- Built with Rails 7 in API-only mode
- PostgreSQL as the database
- Namespaced API routing (`/api/v1/tasks`)
- Active Model Serializer for clean JSON responses
- RSpec for request-level testing
- CORS support for frontend/backend separation

---

## 🚀 Getting Started

This guide will help you set up the app locally, even if you're new to Rails.

### 🧰 Prerequisites

- Ruby (3.x recommended)
- Rails (7+)
- PostgreSQL
- Node.js (for JS runtime)
- Git

> 💡 **Tip**: Use [rbenv](https://github.com/rbenv/rbenv) or [asdf](https://asdf-vm.com/) to manage Ruby versions.

---

### 📦 Installation Steps

1. **Clone the repository**

```bash
git clone https://github.com/your-username/your-repo-name.git
cd backend
```

2. **Install dependencies**

```bash
bundle install
```

3. **Set up your PostgreSQL database**

Update `config/database.yml` with your local DB credentials:

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

4. **Create and migrate the database**

```bash
rails db:create
rails db:migrate
```

5. **Run the server**

```bash
rails s
```

Your API will be available at:  
👉 `http://localhost:3000/api/v1/tasks`

---

## 🔀 Available API Routes

You can list all routes with:

```bash
rails routes
```

Some examples:

| Method | Endpoint            | Description        |
| ------ | ------------------- | ------------------ |
| GET    | `/api/v1/tasks`     | List all tasks     |
| POST   | `/api/v1/tasks`     | Create new task    |
| GET    | `/api/v1/tasks/:id` | Show a single task |
| PATCH  | `/api/v1/tasks/:id` | Update a task      |
| DELETE | `/api/v1/tasks/:id` | Delete a task      |

---

## 🧠 Development Notes

- Created the project using:
  ```bash
  rails new backend --api -T -d=postgresql
  ```
- Created model using:
  ```bash
  rails g model Task title:string description:text assigned_to:string status:string
  ```
- Created routes using:

  ```ruby
  namespace :api do
    namespace :v1 do
      resources :tasks
    end
  end
  ```

- Created controller manually at:  
  `app/controllers/api/v1/tasks_controller.rb`

---

## 🧼 JSON Serialization

To clean up the response format, we use [ActiveModel Serializers](https://github.com/rails-api/active_model_serializers):

Install via Gemfile:

```ruby
gem 'active_model_serializers'
```

Generate a serializer:

```bash
rails g serializer Task
```

This outputs only needed fields and adds computed ones like `is_completed`.

---

## 🌐 CORS Setup

CORS is configured using the `rack-cors` gem in `config/initializers/cors.rb`:

```ruby
gem 'rack-cors'
```

Allowed origin set to: `http://localhost:5173`

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options]
  end
end
```

---

## 🧪 Testing with RSpec

1. Add RSpec:

```bash
bundle add rspec-rails --group "development,test"
rails generate rspec:install
```

2. Create a request spec:

```bash
rails generate rspec:request api/v1/tasks
```

3. Prepare the test DB:

```bash
rails db:test:prepare
```

4. Run tests:

```bash
bundle exec rspec
```

You’ll find tests inside `spec/requests/api/v1/tasks_spec.rb`.

---
