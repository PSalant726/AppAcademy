class Api::TodosController < ApplicationController

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo
    else
      render text: "FAILED TO SAVE", status: 422
    end
  end

  # def new
  #   @todo = Todo.new
  # end

  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
    @todo = Todo.find(params[:id])
    render json: @todo
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    render json: @todo
  end

  def update
    @todo = Todo.find(params[:id])

    if @todo.update(todo_params)
      render json: @todo
    else
      render text: "FAILED TO UPDATE", status: 422
    end
  end

  private

  def todo_params
      params.require(:todo).permit(:title, :body, :done)
  end

end
