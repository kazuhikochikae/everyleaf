class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    @tasks = @tasks.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?

    if params[:sort_expired] == "true"
      @tasks = Task.order(deadline: :asc)

    elsif params[:sort_priority] == "true"
      @tasks = Task.order(rank: :asc)
      
    else
      @tasks = Task.order(created_at: :desc)
    
    end
    @tasks = @tasks.page(params[:page]).per(10) 




    if params[:name].present?
      @tasks = @tasks.get_by_name params[:name]
      end
      if params[:status].present?
      @tasks = @tasks.get_by_status params[:status]
      end


  end




  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
    redirect_to tasks_path, notice: "タスクを作成しました！"
  else
    render :new
  end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"  
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :rank)
  end

  def set_task
    @task = Task.find(params[:id])
  end

 
end
