require 'rails_helper'

RSpec.describe "API::V1::Tasks", type: :request do
  let!(:task) { Task.create(title: "Test Task", description: "Just a test", assigned_to: "abid@example.com", status: "pending") }

  describe "GET /api/v1/tasks" do
    it "returns all tasks with status 200" do
      get "/api/v1/tasks"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.first["title"]).to eq("Test Task")
    end
  end

  describe "GET /api/v1/tasks/:id" do
    it "returns a single task with serializer data" do
      get "/api/v1/tasks/#{task.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["title"]).to eq("Test Task")
      expect(json["data"]["is_completed"]).to eq(false)
    end
  end

  describe "POST /api/v1/tasks" do
    it "creates a new task" do
      post "/api/v1/tasks", params: {
        task: {
          title: "New Task",
          description: "From test",
          assigned_to: "test@example.com",
          status: "pending"
        }
      }

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["data"]["title"]).to eq("New Task")
    end
  end

  describe "PATCH /api/v1/tasks/:id" do
    it "updates a task" do
      patch "/api/v1/tasks/#{task.id}", params: {
        task: {
          status: "completed"
        }
      }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["status"]).to eq("completed")
      expect(json["data"]["is_completed"]).to eq(true)
    end
  end

  describe "DELETE /api/v1/tasks/:id" do
    it "deletes a task" do
      delete "/api/v1/tasks/#{task.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Task deleted successfully")
    end
  end
end
