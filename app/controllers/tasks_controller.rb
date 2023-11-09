class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_required

  def index
    @tasks = current_user.tasks


    if params[:sort_expired] == "true"
      @tasks = @tasks.order(deadline: :asc)
    elsif params[:sort_priority] == "true"
      @tasks = @tasks.order(rank: :asc)
    else
      @tasks = @tasks.order(created_at: :desc)
    end
    
    if params[:name].present?
      @tasks = @tasks.get_by_name(params[:name])
    end
    if params[:status].present?
      @tasks = @tasks.get_by_status params[:status]
    end
    
    @tasks = @tasks.page(params[:page]).per(10)
  end




  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
    redirect_to tasks_path, notice: "タスクを作成しました！"
    else
    render :new
    end
  end


  def confirm
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    render :new if @task.invalid?
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
