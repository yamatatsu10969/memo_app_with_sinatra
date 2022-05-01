# memo_app_with_sinatra

## メモアプリ

### 機能

- メモの追加
- メモの削除
- メモの一覧表示
- メモの詳細表示
- メモの変更
- メモの保存

### ローカルでの実行方法

必須要件

- pgライブラリはPostgreSQLを使用するため、PostgreSQLがインストールされている必要があります。
    - [PostgreSQLのインストール方法](https://www.postgresql.org/download/)
- PostgreSQLのデータベース 'memo_app' を作成してあること
    - [PostgreSQLのデータベースの作成方法](https://www.webolve.com/basic/sql/create-db-and-table-postgresql/#link3)

1. gem パッケージを取得

```bash
bundle install
```

2. ruby コマンドで実行

```bash
ruby memo_app.rb
```

3. http://localhost:4567/memos にアクセス
