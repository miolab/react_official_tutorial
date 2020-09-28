# React Official Tutorial

- __React__ の [公式チュートリアル](https://ja.reactjs.org/tutorial/tutorial.html) を、とおしで進めていきます

  - お題は、`React で「三目並べゲーム」（Tic Tac Toe）をつくる` です

    - 「ゲームか」と思った人へ対する、公式サイドからの物言い

      > 自分はゲームを作りたいのではないから、と飛ばしたくなるかもしれませんが、是非目を通してみてください。このチュートリアルで学ぶ技法はどのような React のアプリにおいても基本的なものであり、マスターすることで React への深い理解が得られます。

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

- 初期ディレクトリ構成

  ```bash
  $ tree .
  .
  ├── Dockerfile
  ├── README.md
  └── docker-compose.yml
  ```

  - [初期構成ブランチ](https://github.com/miolab/react_official_tutorial/tree/_FROZEN__init_react_with_docker) から `git clone` で入手可です

  - この状態から、ルート直下に、Reactプロジェクトディレクトリ `my_app` を次の手順で生成します

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

  - ぶじ、Reactの最初の画面が確認できました！

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
      > 各 React 要素は、__変数に格納したりプログラム内で受け渡ししたりできる、JavaScript のオブジェクト__ です。
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

Square を、クラスから __関数コンポーネント__ に書き換えます

> React における __関数コンポーネント__ とは、__render メソッドだけを有して自分の state を持たないコンポーネント__ を、よりシンプルに書くための方法です。

- `index.js`

  ```js
  // class Square extends React.Component {    -> delete
  function Square(props) {  // -> add
    // render() {           -> delete
      return (
        <button
          className="square"
          // onClick={() => this.props.onClick()}  -> delete
          onClick={props.onClick}  // -> add
        >
          {/* {this.props.value}  -> delete */}
          {props.value}  // -> add
        </button>
      );
    // }    -> delete
  }
  ```

## :book: [手番の処理](https://ja.reactjs.org/tutorial/tutorial.html#taking-turns)

- 盤面に __O__ も出せるよう、変更実装します（`index.js`）

  ```js
  class Board extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        squares: Array(9).fill(null),
        xIsNext: true,    // -> add（初期値を'X'にセット）
      };
    }

      .
      .

    handleClick(i) {
      const squares = this.state.squares.slice();
      // squares[i] = 'X';        -> delete
      // this.setState({squares: squares});  -> delete
      squares[i] = this.state.xIsNext ? 'X' : 'O';  // -> add
      this.setState({           // -> add
        squares: squares,       // -> add
        xIsNext: !this.state.xIsNext,  // -> add
      });
    }
  ```

  `handleClick` の変更実装により、`xIsNext` の値を置き換えて反転させるようにしました

  - 変更後の描画結果

    マス目クリックで、「X」「O」マークが交互に表示できるようになりました

    <img width="206" alt="" src="https://user-images.githubusercontent.com/33124627/94084930-b28aed80-fe41-11ea-80e3-faa1533ec22d.png">

- どちらのプレーヤの手番なのかを表示するように、変更実装します（`index.js`）

  ```js
  class Board extends React.Component {
      .
      .

  render() {
    // const status = 'Next player: X';    -> delete
    const status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');  // -> add
  ```

  - 変更後の描画結果

    <img width="135" alt="" src="https://user-images.githubusercontent.com/33124627/94085498-45785780-fe43-11ea-930a-5a41370a31f0.png">

## :book: [ゲーム勝者の判定](https://ja.reactjs.org/tutorial/tutorial.html#declaring-a-winner)

`index.js`

- コード末尾に、以下追記

  ```js

  function calculateWinner(squares) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (let i = 0; i < lines.length; i++) {
      const [a, b, c] = lines[i];
      if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
        return squares[a];
      }
    }
    return null;
  }
  ```

- 以下の通り修正実装し、プレイヤー勝利判定を行う

  ```js
  handleClick(i) {
    const squares = this.state.squares.slice();

    // ADD next `if` block ->
    if (calculateWinner(squares) || squares[i]) {
      return;
    }

    squares[i] = this.state.xIsNext ? 'X' : 'O';
    this.setState({
      squares: squares,
      xIsNext: !this.state.xIsNext,
    });
  }

  render() {
    // const status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');  -> delete

    // ADD next `const ~ if else` block ->
    const winner = calculateWinner(this.state.squares);
    let status;
    if (winner) {
      status = "Winner: " + winner;
    } else {
      status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');
    }

  ```

  - 変更後の描画結果

    <img width="171" alt="スクリーンショット 2020-09-24 19 15 53" src="https://user-images.githubusercontent.com/33124627/94132521-6324db80-fe9a-11ea-827f-de1567275cd3.png">

  - by 公式 ↓↓↓

    > おめでとうございます！ これで動作する三目並べゲームができました。そして React の基本についても学ぶことができました。__このゲームの真の勝者はあなた__ かもしれませんね。

    :zabuton: （絵文字がない）

# :rocket: [タイムトラベル機能の追加](https://ja.reactjs.org/tutorial/tutorial.html#adding-time-travel)

## :book: [着手の履歴の保存](https://ja.reactjs.org/tutorial/tutorial.html#storing-a-history-of-moves)

過去の手番まで「時間を巻き戻せる」タイムトラベル機能を、最後に実装します

#### 現在の状態

- プレイヤーが手番を行うタイミングで `squares` 配列をコピーする機能は実装済み  
  （配列をイミュータブルなものとして扱ってきた）

- そのため、`squares` 配列の過`去バージョンは` べて保存されており、そちらを利用して履歴をさかのぼることはできる

#### 方針

- `squares` 配列を、`history` 配列に格納保存します

  - 構造

    ```js
    history = [
      // Before first move
      {
        squares: [
          null, null, null,
          null, null, null,
          null, null, null,
        ]
      },
      // After first move
      {
        squares: [
          null, null, null,
          null, 'X', null,
          null, null, null,
        ]
      },
      // After second move
      {
        squares: [
          null, null, null,
          null, 'X', null,
          null, null, 'O',
        ]
      },
      // ...
    ]
    ```

- この `history` 配列の状態を、どのコンポーネントで保持するべきでしょうか？

## :book: [State のリフトアップ、再び](https://ja.reactjs.org/tutorial/tutorial.html#lifting-state-up-again)

結論、トップレベルの Game コンポーネント内に、history の state を置くようにします

- そうすることで、squares の state を、子コンポーネントである Board から取り除けるようにできるため

### 実装（`index.js`）

- まず、Game コンポーネントの初期 state を、コンストラクタ内でセットします

  ```js
  class Game extends React.Component {
    // ADD next constructor block ->
    constructor(props) {
      super(props);
      this.state = {
        history: [{
          squares: Array(9).fill(null),
        }],
        xIsNext: true,
      };
    }

  ```

- 続いて、`Board` コンポーネントが、Gameコンポーネントから

  - square
  - onClick

  の両プロパティを受け取るよう変更

  ```js
  class Board extends React.Component {
    // DELETE next constructor block ->
    // constructor(props) {
    //   super(props);
    //   this.state = {
    //     squares: Array(9).fill(null),
    //     xIsNext: true,
    //   };
    // }

    renderSquare(i) {
      return (
        <Square
          // value={this.state.squares[i]}  -> delete
          // onClick={() => this.handleClick(i)}  -> delete
          value={this.props.squares[i]}  // -> add
          onClick={() => this.props.onClick(i)}  // -> add
        />
      );
    }
  ```

- さらに、`Game` コンポーネントの render 関数を更新して、ゲームのステータステキストの決定や表示の際に最新履歴が使われるよう変更します

  - Game コンポーネントでがゲームのステータステキストを表示するようにしたので、対応するコードを Board コンポーネント内の render メソッドから削除します

- あわせて、handleClick メソッドを Board コンポーネントから Game コンポーネントに移動します

  - 中身をGameコンポーネント側にあわせて一部修正します

  ```js
  class Board extends React.Component {
        .
        .

    // MOVE next method `handleClick` into Game component ->
    // handleClick(i) {
    //   const squares = this.state.squares.slice();

    //   if (calculateWinner(squares) || squares[i]) {
    //     return;
    //   }

    //   squares[i] = this.state.xIsNext ? 'X' : 'O';
    //   this.setState({
    //     squares: squares,
    //     xIsNext: !this.state.xIsNext,
    //   });
    // }

    render() {
      // MOVE next block 'const ~ if else' into Game component ->
      // const winner = calculateWinner(this.state.squares);
      // let status;
      // if (winner) {
      //   status = "Winner: " + winner;
      // } else {
      //   status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');
      // }

      return (
        <div>
          {/* <div className="status">{status}</div>   -> delete */}
          <div className="board-row">
            {this.renderSquare(0)}
            {this.renderSquare(1)}
            {this.renderSquare(2)}
          </div>
          <div className="board-row">
            {this.renderSquare(3)}
            {this.renderSquare(4)}
            {this.renderSquare(5)}
          </div>
          <div className="board-row">
            {this.renderSquare(6)}
            {this.renderSquare(7)}
            {this.renderSquare(8)}
          </div>
        </div>
      );
    }
  }

  class Game extends React.Component {
    constructor(props) {
        .
        .

    // PUT next method 'handleClick' and function `render` FROM Board component (and UPDATE) ->
    handleClick(i) {
      const history = this.state.history;
      const current = history[history.length - 1];
      const squares = current.squares.slice();

      if (calculateWinner(squares) || squares[i]) {
        return;
      }

      squares[i] = this.state.xIsNext ? 'X' : 'O';
      this.setState({
        history: history.concat([{
          squares: squares,
        }]),
        xIsNext: !this.state.xIsNext,
      });
    }

    render() {
      const history = this.state.history;
      const current = history[history.length - 1];
      const winner = calculateWinner(current.squares);
      let status;
      if (winner) {
        status = 'Winner: ' + winner;
      } else {
        status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');
      }

      return (
        <div className="game">
          <div className="game-board">
            {/* <Board />   -> UPDATE this Board as below */}
            <Board
              squares={current.squares}
              onClick={(i) => this.handleClick(i)}
            />
          </div>
          <div className="game-info">
            {/* <div>status</div>   -> UPDATE this div as below */}
            <div>{status}</div>
            <ol>{/* TODO */}</ol>
          </div>
        </div>
      );
    }
  }
  ```

## :book: [過去の着手の表示](https://ja.reactjs.org/tutorial/tutorial.html#showing-the-past-moves)

- 配列の `map()` メソッドについて

  - 参考ファイル : `note/map.js`

    ```js
    const numbers = [1, 2, 3];
    const doubled = numbers.map(x => x * 2);

    console.log("doubled :", doubled);
    ```

    ```bash
    $ node note/map.js
    doubled : [ 2, 4, 6 ]
    ```

- Game の render メソッド内で history に map を作用させて、`着手履歴の配列をマップして画面上のボタンを表現する` React 要素を作りだし、`過去の手番に「ジャンプ」するためのボタンの一覧を表示` できるよう実装していきます

  ```js
  class Game extends React.Component {
        .
        .

    render() {
      const history = this.state.history;
      const current = history[history.length - 1];
      const winner = calculateWinner(current.squares);

      // ADD next `const moves` block ->
      const moves = history.map((step, move) => {
        const desc = move ?
          'Go to move #' + move :
          'Go to game start';
        return (
          <li>
            <button onClick={() =>
              this.jumpTo(move)}>
              {desc}
            </button>
          </li>
        );
      });

        .
        .

      return (
        .
        .
            <div>{status}</div>
            {/* <ol>TODO</ol>   UPDATE as next ol -> */}
            <ol>{moves}</ol>
          </div>
        </div>
  ```

  > ひとまずこのコードにより、ゲーム内で行われた着手のリストが表示されるようになりましたが、同時に開発者ツールのコンソール内に以下の警告も出力されているはずです（__下記、ブラウザ表示結果参照__）

  <img width="587" alt="スクリーンショット 2020-09-27 16 44 42" src="https://user-images.githubusercontent.com/33124627/94359268-0f580380-00e1-11eb-844c-d663ce3fffd9.png">

## :book: [key を選ぶ](https://ja.reactjs.org/tutorial/tutorial.html#picking-a-key)

- ※ WIP
  - docs のみ
  - index.js 実装なし

キーワード
- `key`
  - 特別なプロパティであり、Reactの予約語（`ref`）

## :book: [タイムトラベルの実装](https://ja.reactjs.org/tutorial/tutorial.html#implementing-time-travel)

- Game コンポーネントの render メソッド内で、key を設定します

  ```js
    const moves = history.map((step, move) => {
        .
        .
      return (
        // UPDATE <li> tag
        // <li>
        <li key={move}>
          <button onClick={() =>
            this.jumpTo(move)}>
            {desc}
          </button>
        </li>
  ```

- Game の constructor 内で、state の初期値として `stepNumber: 0` を加えます
- あわせて、jumpTo メソッドを定義して、stepNumber が更新されるようにします。また、更新しようとしている stepNumber の値が偶数だった場合は xIsNext を true に設定します

  ```js
  class Game extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        history: [{
          squares: Array(9).fill(null),
        }],
        stepNumber: 0,  // -> add
        xIsNext: true,
      };
    }

    handleClick(i) {
        .
        .
    }

    // ADD jumpTo method ->
    jumpTo(step) {
      this.setState({
        stepNumber: step,
        xIsNext: (step % 2) === 0,
      });
    }
  ```



---

# WIP ->

## :book: [まとめ](https://ja.reactjs.org/tutorial/tutorial.html#wrapping-up)
