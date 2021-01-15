https://gist.github.com/Ikuyadeu/204d06fffd912f441b383eb02463e29b のコピー


<https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile> に書いてあったbibのコンパイルを日本語に対応．

0. VSCodeやLatexをインストールしてなければインストール（<https://code.visualstudio.com/>）
1. Latex-Workshopをインストール(<https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop>)
2. settings.json(Windows: `ファイル > 基本設定 > 設定` or `Ctrl` + `,`， Mac: `Code > 基本設定 > 設定` or `⌘` + `,`)の`{ }`内に以下を追加(設定ファイルの変更方法: https://qiita.com/y-w/items/614843b259c04bb91495)
```json
    "latex-workshop.latex.tools": [
        {
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOCFILE%.tex"
            ],
            "name": "Step 1: ptex2pdf"
        },
        {
            "command": "pbibtex",
            "args": [
                "%DOCFILE%",
                "-kanji=utf8"
            ],
            "name": "Step 2: pbibtex"
        },
        {
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOCFILE%.tex"
            ],
            "name": "Step 3: ptex2pdf"
        },
        {
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOCFILE%.tex"
            ],
            "name": "Step 4: ptex2pdf"
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "toolchain",
            "tools": [
                "Step 1: ptex2pdf",
                "Step 2: pbibtex",
                "Step 3: ptex2pdf",
                "Step 4: ptex2pdf"
            ]
        }
    ],
    "latex-workshop.view.pdf.viewer": "tab",
    "editor.renderControlCharacters": true
```
* `"editor.renderControlCharacters": true`はMacのSierraを利用している場合に見えない記号を表示するために必要，
そうでなければ消しても大丈夫
* もしbibファイルがないなら
```json
"latex-workshop.latex.tools": [
        {
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOCFILE%.tex"
            ]
        }
],
"latex-workshop.latex.recipes": [
{
    "name": "toolchain",
    "tools": [
        "Step 1: ptex2pdf"
    ]
}],
"latex-workshop.view.pdf.viewer": "tab",
"editor.renderControlCharacters": true
```
だけで十分

3. ファイルを保存または`F1`キーを押して`Build Latex Project`を入力，実行するとコンパイルされる．
4. `F1`キーの後， `View PDF File in new tab`でPDFを見れる．
5. エラーが出た場合は `表示-> 統合ターミナル`で下に端末が出るのでその中の`出力`を確認