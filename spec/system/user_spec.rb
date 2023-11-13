require 'rails_helper'

RSpec.describe 'ログインとログアウト', type: :feature do
  before do
    # ユーザを作成する
    User.create!(email: 'test@example.com', password: '123456')
  end
  it 'ログインする' do
    # トップページを開く
    visit root_path
    # ログインフォームにEmailとパスワードを入力する
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: '123456'
    # ログインボタンをクリックする
    click_on 'ログイン'
    # ログインに成功したことを検証する
    expect(page).to have_content 'ログインしました'
  end
end