module Api 
  module V1 
    class TasksController < ApplicationController 
      before_action :set_task, only: %i[ show update destroy ]

      # GET /api/v1/tasks
      def index 
        # show all challenges
        tasks = Task.all
        render json: tasks, each_serializer: TaskSerializer, status: :ok
      end

       # POST /api/v1/tasks
      def create
        # Create one record
        task = Task.new(tasks_params)
        if task.save
          render json: {
            message: 'Task created successfully',
            data: TaskSerializer.new(task)
          }, status: :created
        else
          render json: {
            message: 'Failed to create task',
            errors: task.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

       # GET /api/v1/tasks/:id
      def show
        # Get single record
        render json: {
          message: 'Task found',
          data: TaskSerializer.new(@task)
        }, status: :ok
      end

       # PATCH / PUT /api/v1/tasks/:id
      def update
        # Update one record
        if @task.update(task_params)
          render json: {
            message: 'Task updated successfully',
            data: TaskSerializer.new(@task)
          }, status: :ok
        else
          render json: {
            message: 'Failed to update task',
            errors: @task.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

       # DELETE /api/v1/tasks/:id
      def destroy 
        # Delete one record
        if @task.destroy
          render json: {
            message: 'Task deleted successfully'
          }, status: :ok
        else
          render json: {
            message: 'Failed to delete task',
            errors: @task.errors.full_messages
          }, status: :internal_server_error
        end
      end

      private
      
      # Use callbacks to share common setup or constraints between actions.
      def set_task
        @task = Task.find_by(id: params[:id])
        unless @task
          render json: {
            message: 'Task not found'
          }, status: :not_found
        end
      end

      def tasks_params 
        params.require(:task).permit(:title, :description, :assigned_to, :status)
      end
    end
  end
end