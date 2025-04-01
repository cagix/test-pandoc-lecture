# TODO

- [x] refs: abfrage über api (https://pandoc.org/lua-filters.html#pandoc.utils.references) statt yaml-variable für quellen-verzeichnis
- [x] quellen nur als <strong>, mit NOTE

- [x] filter für bc: yaml-toggle, alle header nach header+1 konvertieren (gfm, pdf, beamer); evtl. automatisch mit pandoc.structure.slide_level(blocks)?!

- [ ] filter: integrate all filters, e.g. for `bsp`, `origin`, ... (gfm, beamer, pdf)

- [ ] pdf: kopie von defaults und filter, mit relocate-path, makefile für alle .md und "_" statt "/", workflow anpassen

- [ ] beamer: kopie von defaults und filter, mit relocate-path, makefile für alle .md und "_" statt "/", letzte slide: license, workflow anpassen

- [ ] yaml: ausnahmen von lizenz -> in lizenz-block integrieren; als neue yaml-variable oder automatisch über `origin` sammeln?

- [ ] gfm: link zu pdf und beamer einfügen (automatisch oder per variable? branch+pfad könnte über Makefile -> YAML -> Filter bekannt sein...)

- [ ] tooling: .pandoc/ auf gitignore und clone pandoc-lecture, mini-makefile: repo clonen und updaten; variablen setzen und "include .pandoc/makefile"

- [ ] test bc & canan: seite im ilias vs neue gfm-seite im test-repo, tooling (canan: vorschau, bc: make+docker)

- [ ] start im repo: default-branch ändern? link im readme! (inkl. link zu pdf) ...

- [ ] pandoc-lecture ergänzen (oder fork "pandoc-lecture2"?)
