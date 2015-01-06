class TodosController < ActionController::Base
  layout 'application'

  def index
    @todos = Todo.all.order('created_at DESC')
  end

  def create
    @todo = Todo.create(todo_params)
  end

  protected

  def todo_params
    params.require(:todo).permit(:title)
  end

end
