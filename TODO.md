# TODO

1.  refs: abfrage über api (https://pandoc.org/lua-filters.html#pandoc.utils.references) statt yaml-variable für quellen-verzeichnis
2.  quellen nur als <strong>, mit NOTE

3.  pdf: kopie von defaults und filter, mit relocate-path, makefile für alle .md und "_" statt "/", workflow anpassen

4.  beamer: kopie von defaults und filter, mit relocate-path, makefile für alle .md und "_" statt "/", letzte slide: license, workflow anpassen

5.  yaml: ausnahme von lizenz -> in lizenz-block integrieren

6.  start im repo: default-branch ändern? link im readme? ...

7.  filter für bc: yaml-toggle, alle header nach header+1 konvertieren (gfm, pdf, beamer); evtl. automatisch mit pandoc.structure.slide_level(blocks)?!

8.  tooling: .pandoc/ auf gitignore und clone pandoc-lecture, mini-makefile: variablen setzen und "include .pandoc/makefile" -> targets verfügbar?

9.  test bc & canan: seite im ilias vs neue gfm-seite im test-repo, tooling (canan: vorschau, bc: make+docker)

10. pandoc-lecture ergänzen (oder fork "pandoc-lecture2"?)
