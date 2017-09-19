# dir_mk

## 概要

ディレクトリリストに記載されたディレクトリの作成

## 使用方法

### dir_mk.sh

    ディレクトリリストに記載されたディレクトリを作成します。
    # dir_mk.sh ディレクトリリストのファイル名

### dir_chm.sh

    ディレクトリリストに記載されたディレクトリのオーナ・グループ・パーミッションを設定します。
    # dir_chm.sh ディレクトリリストのファイル名

### ディレクトリリストの書式

    第1カラム       第2カラム  第3カラム  第4カラム
    ----------------------------------------------------
    ディレクトリ名  オーナ     グループ   パーミッション

    ・「#」で始まる行はコメント行扱いされます。
    ・空行は無視されます。
    ・カラム区切り文字は「1文字以上の半角スペース」とします。
    ・ディレクトリ名はフルパスまたは相対パスで指定します。
    ・オーナはUNAMEまたはUIDで指定します。
    ・グループはGNAMEまたはGIDで指定します。
    ・パーミッションは4桁8進数で指定します。
    ・「dir_mk.sh」スクリプトでは、第2カラム以降は無視されます。
      第2カラム以降は、「dir_chm.sh」スクリプトで使用されます。

### その他

* 上記で紹介したツールの詳細については、「ツール名 --help」を参照してください。

## 動作環境

OS:

* Linux
* Cygwin

依存パッケージ または 依存コマンド:

* make (インストール目的のみ)

## インストール

ソースからインストールする場合:

    (Linux, Cygwin の場合)
    # make install

fil_pkg.plを使用してインストールする場合:

[fil_pkg.pl](https://github.com/yuksiy/fil_tools_pl/blob/master/README.md#fil_pkgpl) を参照してください。

## インストール後の設定

環境変数「PATH」にインストール先ディレクトリを追加してください。

## 最新版の入手先

<https://github.com/yuksiy/dir_mk>

## License

MIT License. See [LICENSE](https://github.com/yuksiy/dir_mk/blob/master/LICENSE) file.

## Copyright

Copyright (c) 2006-2017 Yukio Shiiya
