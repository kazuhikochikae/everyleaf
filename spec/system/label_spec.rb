require 'rails_helper'

RSpec.describe 'ラベルテスト', type: :system do
  
  let!(:user) { User.create!(name: '山田',email: 'test@co.jp', password: '123456') }

  describe 'タスクを登録の際タスクと一緒にラベルを登録できる' do
    include FactoryBot::Syntax::Methods

    it '新しいタスクの作成時にラベルを追加できることを確認する' do
      visit root_path
      fill_in 'Email', with: 'test@co.jp'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      sleep 1
      visit new_task_path
      fill_in 'task_name', with: '田中'
      fill_in 'task_detail', with: 'rails教本'
      select '未着手', from: 'task[status]'
  
      # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
      click_on '登録する'
      # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
      # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
      expect(page).to have_content 'rails教本'

    
     
    end
  end

  describe 'タスクの詳細画面で、そのタスクに紐づいているラベル一覧を出力する' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, name: "家事",status: "未着手", user: user)
      FactoryBot.create(:second_task, name: "終わったタスク",status: "完了", user: user)
    end
    it 'タスクの詳細画面に紐づいているラベル一覧が表示されることを確認する' do
       # トップページを開く
      visit root_path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'Email', with: 'test@co.jp'
      fill_in 'Password', with: '123456'
      # ログインボタンをクリックする
      click_on 'Log in'
      # ログインに成功したことを検証する
      sleep 1
      task = FactoryBot.create(:task, user: user)
      visit task_path(task) 
      expect(page).to have_content '部屋の掃除'
     
    end
  end


  describe 'ラベルで検索ができる' do
    it 'ラベルでタスクを検索できることを確認する' do
      # トップページを開く
      visit root_path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'Email', with: 'test@co.jp'
      fill_in 'Password', with: '123456'
      # ログインボタンをクリックする
      click_on 'Log in'
      # ログインに成功したことを検証する
     
      sleep 1
      # タスクの一覧ページにアクセス
      visit tasks_path
      # プルダウンメニューからステータスを選択（例: "未着手"）
      select "Label2", from: "Label"  # "status" は実際のセレクトボックスの名前に合わせて修正
      # 検索ボタンをクリック
      click_on 'ラベル検索'
      # 選択したステータスに完全一致するタスクが表示されることを確認
      expect(page).to have_content 'Label2検索'
      # その他のステータスに関するテストも同様に実施
    end
  end

end