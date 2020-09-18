# React Official Tutorial

- __React__ の [公式チュートリアル](https://ja.reactjs.org/tutorial/tutorial.html) を、とおしで進めていきます

- __内容を一部アレンジ__ します

  - __開発環境は Docker__ とします（公式での環境設定は、ローカル直書き & Webエディタ）

### 開発環境・バージョン

```terminal
$ docker-compose run app bash

# node --version
v14.10.1

# npm view react version
16.13.1

# yarn --version
1.22.5
```

### 参考

- 公式

  - [ガイド](https://ja.reactjs.org/docs/hello-world.html)

- Docker

  - [Node](https://hub.docker.com/_/node)

---

## React 開発環境準備

- ディレクトリ構成

  ```bash
  $ tree .
  .
  ├── Dockerfile
  ├── README.md
  └── docker-compose.yml
  ```

  - [初期構成ブランチ](https://github.com/miolab/react_official_tutorial/tree/_FROZEN__init_react_with_docker)

  - この状態から、ルート直下に、Reactプロジェクトディレクトリ `my_app` を生成します（後述）

- Docker image をビルド

  ```bash
  $ docker-compose build
      .
      .
  ```

- `npx create-react-app` で React プロジェクトの初期構築をします

  ```bash
  $ docker-compose run --rm app sh -c "npx create-react-app my_app"
      .
      .
  ```

  - ルート直下に `my_app` プロジェクトディレクトリが生成されました

---

## コンテナ起動

- `docker-compose up` でコンテナを立ち上げます

  ```bash
  $ docker-compose up
    .
    .

  Starting the development server...
  app_1  | 
    .
    .
    .
  Compiled successfully!
  app_1  | 
  app_1  | You can now view my_app in the browser.
  app_1  | 
  app_1  |   Local:            http://localhost:3000
  app_1  |   On Your Network:  http://172.28.0.2:3000
  app_1  | 
  app_1  | Note that the development build is not optimized.
  app_1  | To create a production build, use yarn build.
  app_1  | 

  ```

- [http://localhost:3000](http://localhost:3000) をブラウザで確認

  <img width="708" alt="スクリーンショット 2020-09-17 20 37 10" src="https://user-images.githubusercontent.com/33124627/93542518-2df92480-f994-11ea-82a2-e5e2bb705813.png">

  - ぶじ、Reactの最初の画面が確認できました

---

## [WIP]
