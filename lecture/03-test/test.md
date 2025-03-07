---
archetype: lecture-cg
title: "Test Markdown"
author: "Carsten Gips (HSBI)"
readings:
  - key: "@Parr2014"
tldr: |
    Text für TL;DR ...
outcomes:
  - k1: "K1"
  - k2: "K2"
  - k3: "K3.1"
  - k3: "K3.2"
assignments:
  - topic: sheet01
youtube:
  - link: "https://youtu.be/YuUHBvPUS4k"
    name: "VL Parser mit ANTLR"
  - link: "https://youtu.be/FJOEPY-TMmw"
    name: "Demo ANTLR Parser"
challenges: |
    **Lexer und Parser mit ANTLR: Programmiersprache Lox**

    Betrachten Sie folgenden Code-Schnipsel in der Sprache ["Lox"](https://www.craftinginterpreters.com/the-lox-language.html):

    ```
    fun fib(x) {
        if (x == 0) {
            return 0;
        } else {
            if (x == 1) {
                return 1;
            } else {
                fib(x - 1) + fib(x - 2);
            }
        }
    }

    var wuppie = fib(4);
    ```

    Erstellen Sie für diese fiktive Sprache einen Lexer+Parser mit ANTLR.
    Implementieren Sie mit Hilfe des Parse-Trees und der Listener oder Visitoren einen einfachen Pretty-Printer.

    (Die genauere Sprachdefinition finden Sie bei Bedarf unter [craftinginterpreters.com/the-lox-language.html](https://www.craftinginterpreters.com/the-lox-language.html).)
---


## Hello World

Hier ist normaler Markdown-Text, mit **fett** und auch *kursiv*.

-   Stichpunkt 1
-   Stichpunkt 2
-   Stichpunkt 3

1.  Aufzählung 1
2.  Aufzählung 2
3.  Aufzählung 3
    1.  Unterpunkt 3.1
    2.  Unterpunkt 3.2


## Math

### Inline

$\mathbf{g} = (g_1, \dots, g_m)\in \{ 0,1\}^m$

*    $a^ib^{2*i}$ ist nicht regulär
*    $a^ib^{2*i}$ für $0 \leq i \leq 3$ ist regulär

### Block

$$\Phi(\mathbf{g}_i) = F(\Gamma(\mathbf{g}_i)) - w\cdot\sum_j(Z_j(\Gamma(\mathbf{g}_i)))^2$$

$$p_{sel}(\mathbf{g}_k) = \frac{\Phi(\mathbf{g}_k)}{\sum_j \Phi(\mathbf{g}_j)}$$

$$
g_i^{(t+1)} = \left\{
\begin{array}{ll}
    \neg g_i^{(t)} & \mbox{ falls } \chi_i \le p_{mut}\\[5pt]
    \phantom{\neg} g_i^{(t)} & \mbox{ sonst }
\end{array}
\right.
$$


## Links

### Link to WWW

[craftinginterpreters.com/the-lox-language.html](https://www.craftinginterpreters.com/the-lox-language.html)

### Internal Links

[selbe ebene: readme.md](readme.md)

[unterordner: subfolder/foo.md](subfolder/foo.md)

[zurück nach oben I: ../02-parsing/antlr-parsing.md](../02-parsing/antlr-parsing.md)

[zurück nach oben II: ../../homework/sheet01.md](../../homework/sheet01.md)


## Code

```antlr
grammar Hello;

start : stmt* ;

stmt  : ID '=' expr ';' | expr ';' ;
expr  : term ('+' term)* ;
term  : atom ('*' atom)* ;
atom  : ID | NUM ;

ID    : [a-z][a-zA-Z]* ;
NUM   : [0-9]+ ;
WS    : [ \t\n]+ -> skip ;
```

Java-Code kompilieren: `javac *.java`


## Images

!["B" (small)](img/b.png)

!["B", width="20%"](img/b.png){width="20%"}

!["wuppie" (wide)](img/wuppie.png)

!["wuppie", width="20%"](img/wuppie.png){width="20%"}

!["wuppie" via web](https://github.com/cagix/pandoc-thesis/blob/master/figs/wuppie.png)


## Tabellen

| Rechtsbündig | Linksbündig | Default | Zentriert |
|-------------:|:------------|---------|:---------:|
|          foo | foo         | foo     |    foo    |
|          123 | 123         | 123     |    123    |
|          bar | bar         | bar     |    bar    |

: Tabelle als Markdown-Pipe-Table, vgl. [@SICP]


## Zitieren, Quellen

Normales Zitieren [@Siek2023racket] ...

Mit Seitenangabe [@Siek2023racket, Seite 111] oder Kapitel [@Siek2023racket, Kapitel 111] ...

Als Author-Zitat @Siek2023racket ...


## GFM

### Details

<details>

<summary>Zusammenfassung: NIX :)</summary>

Lalelu ...

</details>

### Alert Extension

GH introduced "alerts" with distinctive styling, like

> [!NOTE]
> Foo bar, wuppie fluppie!

> [!TIP]
> Foo bar, wuppie fluppie!

> [!IMPORTANT]
> Foo bar, wuppie fluppie!

> [!WARNING]
> Foo bar, wuppie fluppie!

> [!CAUTION]
> Foo bar, wuppie fluppie!

(see https://github.blog/changelog/2023-12-14-new-markdown-extension-alerts-provide-distinctive-styling-for-significant-content/)


Let's stick with Pandocs divs in Markdown content and use filters for export:

::: note
Foo bar, wuppie fluppie!
:::

- Export to GH Markdown using ["distinctive alerts"](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts)
- Export to Hugo using [notice shortcode](https://mcshelby.github.io/hugo-theme-relearn/shortcodes/notice/index.html)
- Export to Beamer using [beamercolorbox](https://tex.stackexchange.com/questions/411069/creating-beamer-box-environment) (also [beameruserguide.pdf](https://tug.ctan.org/macros/latex/contrib/beamer/doc/beameruserguide.pdf); or `block`, `alertblock`, `examples` - cf. https://www.overleaf.com/learn/latex/Beamer%23Creating_a_table_of_contents)

This should probably be in line with #180 ...
