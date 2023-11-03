# markdown 記法でテーブルスキーマ（モデル名、カラム名、データ型）を記載する

モデル名　 Task

| カラム名 | データ型 |
| -------- | -------- |
| name     | string   |
| detail   | text     |

---

# Heroku デプロイ手順

- heroku create で新しいアプリケーションを作成する

- Gemfile に 以下の gem を追加し、bundle install を実行
  gem 'net-smtp' ,gem 'net-imap', gem 'net-pop'

- git commit コマンドを使用して、コミットを実行

- Heroku に以下の buildpack を追加する
  $ heroku buildpacks:set heroku/ruby
  $ heroku buildpacks:add --index 1 heroku/nodejs

- PostgreSQL のアドオン追加
  $ heroku addons:create heroku-postgresql

- git push heroku master を行い、Heroku にデプロイを行う
