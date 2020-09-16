# React Official Tutorial

- __React__ の [公式チュートリアル](https://ja.reactjs.org/tutorial/tutorial.html) を、通しでやっていきます

- 一部内容をアレンジします

  - 開発環境は Docker とします

### 参考

- 公式

  - [ガイド](https://ja.reactjs.org/docs/hello-world.html)

- Docker

  - [Node](https://hub.docker.com/_/node)

---

## [WIP] 環境準備

- ディレクトリ構成

  ```
  $ tree .
  .
  ├── Dockerfile
  ├── README.md
  └── docker-compose.yml
  ```

  - ルート直下に、Reactプロジェクトディレクトリ `my_app` を生成します（後述）

- ビルド & Reactプロジェクト作成

  ```bash
  $ docker-compose build
      .
      .

  $ docker-compose run --rm app sh -c "npx create-react-app my_app"
      .
      .

  ```


