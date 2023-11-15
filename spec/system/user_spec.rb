require 'rails_helper'

RSpec.describe 'システムテスト', type: :system do
  
  let!(:user) { User.create!(name: '山田', email: 'test@co.jp', password: '123456') }
  let!(:admin_user) { User.create!(name: 'Admin', email: 'admin@co.jp', password: 'password', admin: true) }

  describe 'ユーザ登録のテスト' do
    it 'ユーザの新規登録ができること' do
      visit new_user_path
      fill_in 'Name', with: '新規ユーザ'
      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Create my account'
    end
  end

  describe 'セッション機能のテスト' do
    it 'ログインができること' do
      visit root_path
      fill_in 'Email', with: 'test@co.jp'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
    end

    it '自分の詳細画面(マイページ)に飛べること' do
      visit root_path
      fill_in 'Email', with: 'test@co.jp'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      sleep 1
      visit user_path(user)
    end

    it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
      visit root_path
      fill_in 'Email', with: 'test@co.jp'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      sleep 1
      visit user_path(admin_user)
      expect(page).to have_content 'タスク一覧'
    end

    it 'ログアウトができること' do
      visit root_path
      fill_in 'Email', with: 'test@co.jp'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      sleep 1
      click_on 'Logout'
      expect(page).to have_content 'ログアウトしました'
    end
  end

  describe '管理画面のテスト' do
    it '管理ユーザは管理画面にアクセスできること' do
      visit root_path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'Email', with: 'admin@co.jp'
      fill_in 'Password', with: 'password'
      # ログインボタンをクリックする
      click_on 'Log in'
      sleep 1
      visit admin_users_path
      expect(page).to have_content '管理画面のユーザー一覧画面'
    end

    it '一般ユーザは管理画面にアクセスできないこと' do
      visit root_path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'Email', with: 'test@co.jp'
      fill_in 'Password', with: '123456'
      # ログインボタンをクリックする
      click_on 'Log in'
      sleep 1
      visit admin_users_path
    end

    it '管理ユーザはユーザの新規登録ができること' do
      visit root_path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'Email', with: 'admin@co.jp'
      fill_in 'Password', with: 'password'
      # ログインボタンをクリックする
      click_on 'Log in'
      sleep 1
      visit new_admin_user_path
      fill_in 'Name', with: '新規ユーザ'
      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Create my account'
      expect(page).to have_content '新規登録に成功しました'
    end

    it '管理ユーザはユーザの詳細画面にアクセスできること' do
      visit root_path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'Email', with: 'admin@co.jp'
      fill_in 'Password', with: 'password'
      # ログインボタンをクリックする
      click_on 'Log in'
      sleep 1
      visit admin_user_path(user)
      expect(page).to have_content 'ページ'
    end

    it '管理ユーザはユーザの編集画面からユーザを編集できること' do
      visit root_path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'Email', with: 'admin@co.jp'
      fill_in 'Password', with: 'password'
      # ログインボタンをクリックする
      click_on 'Log in'
      sleep 1
      visit edit_admin_user_path(user)
      fill_in 'Name', with: '変更された名前'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Create my account'
      expect(page).to have_content 'userを編集しました'
    end

    it '管理ユーザはユーザの削除をできること' do
      visit root_path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'Email', with: 'admin@co.jp'
      fill_in 'Password', with: 'password'
      # ログインボタンをクリックする
      
      click_on 'Log in'
      # ログインに成功したことを検証する
      sleep 1
      visit admin_users_path
      page.accept_confirm do
        all('table tr')[1].click_on '削除'
      end
      expect(page).to have_content 'userを削除しました'
    end
  end
end
