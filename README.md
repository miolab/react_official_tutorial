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

## :book: React 開発環境準備

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

## :book: コンテナ起動

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

# :rocket: [チュートリアル準備](https://ja.reactjs.org/tutorial/tutorial.html#setup-option-2-local-development-environment)

- `my_app/src/` に移動し、`src/` ディレクトリ内のファイルを全消去

  ```bash
  $ cd my_app/src && rm *
  ```

- `src/` 内に、公式指定の `CSS` コードと `JS` コードの各内容をそれぞれコピーし、[index.css](https://codepen.io/gaearon/pen/oWWQNa?editors=0100) , [index.js](https://codepen.io/gaearon/pen/oWWQNa?editors=0010) として新規に作成

- `index.js` のコード先頭に、以下を記述

  ```js
  import React from 'react';
  import ReactDOM from 'react-dom';
  import './index.css';

    .
    .
  ```

- Dockerコンテナを再起動

- [http://localhost:3000](http://localhost:3000) をブラウザ更新して確認

  <img width="164" alt="スクリーンショット 2020-09-18 21 51 18" src="https://user-images.githubusercontent.com/33124627/93599453-1acc7000-f9f9-11ea-88d6-6d8f9fb5a88b.png">

# :rocket: [概要](https://ja.reactjs.org/tutorial/tutorial.html#overview)

## :book: [React とは？](https://ja.reactjs.org/tutorial/tutorial.html#what-is-react)

> React は __ユーザインターフェイスを構築する__ ための、__宣言型__ で効率的で柔軟な JavaScript ライブラリです。  
> __複雑な UI を、「コンポーネント」と呼ばれる小さく独立した部品から組み立てる__ ことができます。

- キーワード

  - コンポーネント
    - （上記前述）
  - props
    - properties（パラメータ）の略
  - render
    - 表示するビューの階層構造を返すメソッド
  - JSX
    - React の構文
      > JSX では JavaScript のすべての能力を使うことができます。  
      > どのような JavaScript の式も JSX 内で中括弧に囲んで記入することができます。
  - state
    - コンポーネントに「何か」を覚えさせるもの

## :book: [スターターコードの中身を確認する](https://ja.reactjs.org/tutorial/tutorial.html#passing-data-through-props)

`index.js` が持つ、3つの React コンポーネントをあらためて俯瞰してみます

- __Square__ （マス目）コンポーネント

  1個の `<button>` をレンダリング

- __Board__ （盤面）コンポーネント

  9個のマス目をレンダリング

- __Game__ コンポーネント

  盤面および、プレースホルダー（後ほど実装）を描画

## :book: [データを Props 経由で渡す](https://ja.reactjs.org/tutorial/tutorial.html#passing-data-through-props)

親コンポーネント（Board）から、子コンポーネント（Square）へ props を渡して、アプリ内での情報を流していきます

- `index.js`

  ```js
  class Square extends React.Component {
    render() {
      return (
        <button className="square">
          {/* TODO */}    // -> delete
          {this.props.value}  // -> add
        </button>
      );
    }
  }

  class Board extends React.Component {
    renderSquare(i) {
      // return <Square />;    // -> delete
      return <Square value={i} />;  // -> add
    }
  ```

- 変更後の描画結果

  <img width="140" alt="" src="https://user-images.githubusercontent.com/33124627/93834306-619abe00-fcb6-11ea-9db5-37a2d388b51d.png">

## :book: [インタラクティブなコンポーネントを作る](https://ja.reactjs.org/tutorial/tutorial.html#making-an-interactive-component)

- 実験実装（`index.js`）

  ```js
  class Square extends React.Component {
    render() {
      return (
        // <button className="square">    -> delete
        <button className="square" onClick={() => { alert('click'); }}>  // -> add
          {this.props.value}
        </button>
      );
    }
  }
  ```

  - 変更後の描画結果

    マス目をクリックすると、アラートが出現されるよう変更しました

    <img width="600" alt="" src="https://user-images.githubusercontent.com/33124627/93840084-1b4f5a00-fcca-11ea-9a03-ebd3d02865ba.png">

- マス目クリックで __X__ が表示されるよう、コンポーネント変更実装（`index.js` ）

  ```js
  class Square extends React.Component {
    // ADD next block : constructor
    constructor(props) {
      super(props);
      this.state = {
        // state の初期化
        value: null,
      };
    }

    render() {
      return (
        // <button className="square" onClick={() => { alert('click'); }}>  -> delete
          // {this.props.value}  -> delete
        // ADD next blocks : <button ...> & { ... }
        <button
          className="square"
          onClick={() => this.setState({ value: 'X' })}
        >
          {this.state.value}
        </button>
  ```

  - 変更後の描画結果

    マス目をクリックすると、状態が変わり「X」マーク（のみ）が表示できるようになりました

    <img width="150" alt="" src="https://user-images.githubusercontent.com/33124627/93859146-3638c300-fcf8-11ea-919c-306cf16a06c6.png">

## :book: [Developer Tools](https://ja.reactjs.org/tutorial/tutorial.html#developer-tools)

- [React Developer Tools（FireFox 版）](https://addons.mozilla.org/ja/firefox/addon/react-devtools/)

  React コンポーネントの props と state を確認するための、ブラウザ拡張機能

# :rocket: [ゲームを完成させる](https://ja.reactjs.org/tutorial/tutorial.html#completing-the-game)

## :book: [State のリフトアップ](https://ja.reactjs.org/tutorial/tutorial.html#lifting-state-up)

state 管理を、Square コンポーネントではなく Board コンポーネントで行うように変更実装します

> state を親コンポーネントにリフトアップ (lift up) することは React コンポーネントのリファクタリングでよくあることですので、この機会に挑戦してみましょう。

- `index.js`

  ```js
  class Square extends React.Component {
    // * DELETE next constructor block ->
    // constructor(props) {
    //   super(props);
    //   this.state = {
    //     value: null,
    //   };
    // }

    render() {
      return (
        <button
          className="square"
          // onClick={() => this.setState({ value: 'X' })}  -> delete
          onClick={() => this.props.onClick()}  // -> add
        >
          {/* {this.state.value}  -> delete */}
          {this.props.value}
        </button>
      );
    }
  }

  class Board extends React.Component {
    // ADD next constructor block as this ->
    constructor(props) {
      super(props);
      this.state = {
        squares: Array(9).fill(null),
      };
    }

    renderSquare(i) {
      // return <Square value={i} />;  -> delete
      // ADD next return block as this ->
      return (
        <Square
          value={this.state.squares[i]}
          onClick={() => this.handleClick(i)}
        />
      );
    }

    // ADD next handleClick block as this ->
    handleClick(i) {
      const squares = this.state.squares.slice();
      squares[i] = 'X';
      this.setState({squares: squares});
    }

  ```

> Square コンポーネントは __制御されたコンポーネント (controlled component)__ になったということです。  
> Board が Square コンポーネントを全面的に制御しています。

> handleClick 内では、squares を直接変更する代わりに、.slice() を呼んで配列のコピーを作成していることに注意してください。

## :book: [イミュータビリティは何故重要なのか](https://ja.reactjs.org/tutorial/tutorial.html#why-immutability-is-important)

- 複雑な機能が簡単に実装できる

- 変更の検出

- React の再レンダータイミングの決定

  > イミュータビリティの主な利点は、React で pure component を構築しやすくなるということです。  
  > イミュータブルなデータは変更があったかどうか簡単に分かるため、コンポーネントをいつ再レンダーすべきなのか決定しやすくなります。

## :book: [関数コンポーネント](https://ja.reactjs.org/tutorial/tutorial.html#function-components)

Square を、関数コンポーネントに書き換えます

> React における関数コンポーネントとは、render メソッドだけを有して自分の state を持たないコンポーネントを、よりシンプルに書くための方法です。

- `index.js`

  ```js
  class Square extends React.Component {
    render() {
      return (
        <button
          className="square"
          // onClick={() => this.props.onClick()}  -> delete
          onClick={props.onClick}  // -> add
        >
          {/* {this.props.value}  -> delete */}
          {props.value}  // -> add
  ```

## :book: [手番の処理](https://ja.reactjs.org/tutorial/tutorial.html#taking-turns)
