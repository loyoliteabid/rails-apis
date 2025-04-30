class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :assigned_to, :status, :is_completed

  # This is a method. Rails will call this automatically because it's mentioned above.
  def is_completed
    object.status == 'completed'
  end
end
