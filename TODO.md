# TODO

- [x] refs: abfrage über api (https://pandoc.org/lua-filters.html#pandoc.utils.references) statt yaml-variable für quellen-verzeichnis
- [x] quellen nur als <strong>, mit NOTE
- [x] filter für bc: yaml-toggle, alle header nach header+1 konvertieren (gfm, pdf, beamer); evtl. automatisch mit pandoc.structure.slide_level(blocks)?!
- [x] yaml: ausnahmen von lizenz -> in lizenz-block integrieren; als neue yaml-variable oder automatisch über `origin` sammeln?
- [x] filter: integrate all filters, e.g. for `bsp`, `origin`, ... (gfm)
- [x] layout: use utf8 symbols for special sections (like in https://microsoft.github.io/AI-For-Beginners/; cf. https://www.w3schools.com/charsets/ref_html_utf8.asp)


- [x] pdf: kopie von defaults und filter, mit relocate-path, makefile für alle .md und "_" statt "/", workflow anpassen
- [x] filter: integrate all filters, e.g. for `bsp`, `origin`, ... (pdf)
- [x] filter: remove `\pause`, replace `$$\begin{eqnarray}` w/ `\begin{eqnarray}` (Para Math DisplayMath "\\begin{eqnarray}...") (pdf)
- [x] action: create new action and workflow (pdf)

- [ ] beamer: kopie von defaults und filter, mit relocate-path, makefile für alle .md und "_" statt "/", letzte slide: license, workflow anpassen
- [ ] beamer: folien-seitennummern "folie x von xx" für bc
- [ ] filter: integrate all filters, e.g. for `bsp`, `origin`, ... (beamer)
- [ ] filter: remove `\pause`, replace `$$\begin{eqnarray}` w/ `\begin{eqnarray}` (Para Math DisplayMath "\\begin{eqnarray}...") (pdf)
- [ ] action: create new action and workflow (pdf)

- [ ] gfm: link zu pdf und beamer einfügen (automatisch oder per variable? branch+pfad könnte über Makefile -> YAML -> Filter bekannt sein...)


- [ ] docsify/liascript: kopie von defaults und filter, workflow anpassen

- [ ] gfm: link zu docsify- oder liascript-variante einfügen (automatisch oder per variable? branch+pfad könnte über Makefile -> YAML -> Filter bekannt sein...)


- [ ] tooling: .pandoc/ auf gitignore und clone pandoc-lecture, mini-makefile: repo clonen und updaten; variablen setzen und "include .pandoc/makefile"

- [ ] test bc & canan: seite im ilias vs neue gfm-seite im test-repo, tooling (canan: vorschau, bc: make+docker)

- [ ] start im repo: default-branch ändern? link im readme! (inkl. link zu pdf) ...

- [ ] pandoc-lecture ergänzen (oder fork "pandoc-lecture2"?)


---

Hier ist ein Vorher-/Nachher-Vergleich:

- **Vorher**: https://www.hsbi.de/elearning/data/FH-Bielefeld/lm_data/lm_1360443/02-parsing/antlr-parsing.html
- **Nachher**: https://github.com/cagix/test-pandoc-lecture/blob/_gfm_action/lecture/02-parsing/antlr-parsing.md
- **Docsify-This**: https://docsify-this.net/?basePath=https://raw.githubusercontent.com/cagix/test-pandoc-lecture/_gfm_action/lecture/02-parsing&homepage=antlr-parsing.md#/
- **LiaScript**: https://liascript.github.io/course/?https://raw.githubusercontent.com/cagix/test-pandoc-lecture/_gfm_action/lecture/02-parsing/antlr-parsing.md#1
