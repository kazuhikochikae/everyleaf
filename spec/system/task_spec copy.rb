require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

 

  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, name: "task",status: "未着手", user: user)
      FactoryBot.create(:second_task, name: "終わったタスク",status: "完了", user: user)
    end

    context 'ログインした場合' do
      it 'ログインする' do
        # トップページを開く
        visit root_path
        # ログインフォームにEmailとパスワードを入力する
        fill_in 'Email', with: 'foo@example.com'
        fill_in 'Password', with: '123456'
        # ログインボタンをクリックする
        click_on 'ログイン'
        # ログインに成功したことを検証する
        expect(page).to have_content 'ログインしました'
      end
    end


    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'name', with: "task"
        # 検索ボタンを押す
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        # プルダウンを選択する「select」について調べてみること

        # タスクの一覧ページにアクセス
        visit tasks_path
        # プルダウンメニューからステータスを選択（例: "未着手"）
        select "完了", from: "status"  # "status" は実際のセレクトボックスの名前に合わせて修正
        # 検索ボタンをクリック
        click_on '検索'
        # 選択したステータスに完全一致するタスクが表示されることを確認
        expect(page).to have_content '終わったタスク'
        # その他のステータスに関するテストも同様に実施

      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # タスクの一覧ページにアクセス
        visit tasks_path
        # タイトルのあいまいな検索キーワードを入力（例: "task"）
        fill_in 'name', with: "task"
        # プルダウンメニューからステータスを選択（例: "未着手"）
        select "未着手", from: "status"  # "status" は実際のセレクトボックスの名前に合わせて修正
        # 検索ボタンをクリック
        click_on '検索'
        # タイトルに検索キーワードが含まれ、かつステータスに完全一致するタスクが表示されることを確認
        expect(page).to have_content 'task'
        expect(page).to have_content '未着手'
        # その他の条件に関するテストも同様に実施
      end
    end
  end


  
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      # 1. new_task_pathに遷移する（新規作成ページに遷移する）
      # ここにnew_task_pathにvisitする処理を書く
      visit new_task_path
      # 2. 新規登録内容を入力する
      #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
      # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      fill_in 'task_name', with: '勉強'
      fill_in 'task_detail', with: 'rubyの教本'
      select '未着手', from: 'task[status]'
      # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
      # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
      click_on '登録する'
      # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
      # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
      expect(page).to have_content 'rubyの教本'
    end
  end
end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        FactoryBot.create(:task)
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content '家事'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end

    # テスト内容を追加で記載する
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # ここに実装する
        FactoryBot.create(:task)
        visit tasks_path
        task_test = all('td').first
        expect(task_test).to have_content '家事' 
      end
    end

  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do

        task = FactoryBot.create(:task)
        visit task_path(task) 

        expect(page).to have_content '部屋の掃除'

       end
     end
  end
end