require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない

    let!(:user) { FactoryBot.create(:user, name: "山田") }

    let!(:task) { FactoryBot.create(:task, name: "task", status: "未着手", user: user) }
  

    let!(:second_task) { FactoryBot.create(:second_task, name: "終わったタスク",status: "完了", user: user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.get_by_name('task')).to include(task)
        expect(Task.get_by_name('task')).not_to include(second_task)
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # テストデータの作成
        task1 = FactoryBot.create(:task, name: "タスク1", status: "未着手", user: user)
        task2 = FactoryBot.create(:task, name: "タスク2", status: "着手中", user: user)
        task3 = FactoryBot.create(:task, name: "タスク3", status: "完了", user: user)
        task4 = FactoryBot.create(:task, name: "タスク4", status: "完了", user: user)
        # ステータスに完全一致するタスクを取得
        tasks_with_status_in_progress = Task.get_by_status("着手中")
    
        # 期待値の検証
        expect(tasks_with_status_in_progress).to include(task2)
        expect(tasks_with_status_in_progress).not_to include(task1, task3)
      end
    end


    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        # テストデータの作成
        task1 = FactoryBot.create(:task, name: "家事", status: "未着手", user: user)
        task2 = FactoryBot.create(:task, name: "筋トレ", status: "着手中", user: user)
        task3 = FactoryBot.create(:task, name: "筋トレ", status: "完了", user: user)

        # タイトルとステータスに基づいてタスクを検索
        filtered_tasks = Task.get_by_name('家事').get_by_status("未着手")

        # 期待値の検証
        expect(filtered_tasks).to include(task1)
        expect(filtered_tasks).not_to include(task2, task3)
      end
    end
  end


  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user, name: "山田") }

    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', detail: '腹筋')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '運動', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細とステータスに内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = user.tasks.build(name: '運動', detail: '腹筋', status: '未着手')
        expect(task).to be_valid
      end
    end
  end
end