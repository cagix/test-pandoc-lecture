# TODO

- [x] refs: abfrage über api (https://pandoc.org/lua-filters.html#pandoc.utils.references) statt yaml-variable für quellen-verzeichnis
- [ ] quellen nur als <strong>, mit NOTE

- [ ] pdf: kopie von defaults und filter, mit relocate-path, makefile für alle .md und "_" statt "/", workflow anpassen

- [ ] beamer: kopie von defaults und filter, mit relocate-path, makefile für alle .md und "_" statt "/", letzte slide: license, workflow anpassen

- [ ] yaml: ausnahme von lizenz -> in lizenz-block integrieren

- [ ] start im repo: default-branch ändern? link im readme? ...

- [x] filter für bc: yaml-toggle, alle header nach header+1 konvertieren (gfm, pdf, beamer); evtl. automatisch mit pandoc.structure.slide_level(blocks)?!

- [ ] tooling: .pandoc/ auf gitignore und clone pandoc-lecture, mini-makefile: variablen setzen und "include .pandoc/makefile" -> targets verfügbar?

- [ ] test bc & canan: seite im ilias vs neue gfm-seite im test-repo, tooling (canan: vorschau, bc: make+docker)

- [ ] pandoc-lecture ergänzen (oder fork "pandoc-lecture2"?)
