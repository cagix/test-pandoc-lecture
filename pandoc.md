# Pandoc

1. Liste der Abhängigkeiten (Markdown, Slides, Abbildungen, Sidebar) erstellen (einmalige Ausführung): `$(eval $(shell pandoc -L crawl.lua -t plain --wrap=none))`

## Slides (Beamer, PPTX)

1. MD: Ziel in build-Ordner: `$(patsubst %.md,$(OUTPUT_DIR)/%.pdf,$(SLIDE_SRC))`
2. PDF: foreach dep: `pandoc ... -L filters --citeproc <file.md> -o build/<file.pdf>`

## GFM/Docsify

1. PNG: Ziel in build-Ordner: `$(patsubst %,$(OUTPUT_DIR)/%,$(IMAGE_SRC))`
2. PNG: foreach dep: `cp <file.png> build/<file.png>`
3. PNG: foreach dep: `imagemagick build/<file.png> build/<file_inv.png>`
4. MD: Ziel in build-Ordner: `$(patsubst %.md,$(OUTPUT_DIR)/%.pdf,$(MARKDOWN_SRC))`
5. MD: foreach dep: `pandoc ... -L filters -L ... --citeproc <file.md> -o build/<file.md>`
6. Sidebar.md erstellen: `@printf '%s\n' "$(SIDEBAR_MD)" > $@`

## Book (PDF/Docsify)

1. PNG: Ziel in build-Ordner: `$(patsubst %,$(OUTPUT_DIR)/%,$(IMAGE_SRC))`
2. PNG: foreach dep: `cp <file.png> build/<file.png>`
3. MD: Ziel in build-Ordner: `$(patsubst %.md,$(OUTPUT_DIR)/%.pdf,$(MARKDOWN_SRC))`
4. MD: foreach dep: `pandoc ... -L book.lua -L ... <file.md> -o build/<file.md>` (except citeproc!)
5. PDF: `pandoc --file-scope --citeproc -s build/$(DEPS) -o build/book.pdf`





# Einmalige Ausführung

Lua-Ausgabe z.B.:

DEPS1 := path1/file1.md path2/file2.md
DEPS2 := pathFoo/wuppie.png
SUMMARY := - [Summary](path1/file1.md) ...
Kopieren
Makefile:

# Einmal ausführen, Ausgabe sind Make-Zuweisungen, dann in Make "evaluieren"
$(eval $(shell ./crawl.lua --make-vars))

# Danach ganz normal nutzbar
all: $(DEPS1) $(DEPS2)
    @echo "$(SUMMARY)"
Kopieren
Vorteile:

nur ein Crawl
keine Marker-/Split-Spielchen
robust gegen “komische” Inhalte (solange Sie Make-konform ausgeben)

Für mehrzeilige Inhalte ist die “Make-Assignment-Ausgabe” weiterhin machbar, aber Sie müssen Make-konform serialisieren. In GNU make sind Variablen i.d.R. einzeilig; neue Zeilen bekommen Sie sauber nur über define … endef (Multi-Line Variable) oder über Escaping/$(newline)-Tricks.

Am elegantesten ist: Ihr Lua-Skript gibt für den Summary-Block eine Define-Variable aus, und Make importiert das per eval.

Lösung: Lua gibt define … endef aus

Lua-Ausgabe (Beispiel)

Ihr Skript gibt dann z.B. exakt das hier auf stdout aus:

DEPS1 := path1/file1.md path2/file2.md
DEPS2 := pathFoo/wuppie.png

define SUMMARY_MD
- [Syllabus](readme.md)
- [Vorlesungsunterlagen](lecture/readme.md)
  - [Syntaktische Analyse](lecture/02-parsing/readme.md)
    - [CFG](lecture/02-parsing/cfg.md)
    - [Parser mit ANTLR generieren](lecture/02-parsing/antlr-parsing.md)
  - [Test Markdown](lecture/03-test/readme.md)
    - [Test Markdown](lecture/03-test/test.md)
    - [NN02 - Lineare Regression und Gradientenabstieg](lecture/03-test/nn02-linear-regression.md)
    - subfolder
      - [Single page 'Foo' in a leaf bundle](lecture/03-test/subfolder/foo.md)
- [Praktikum](homework/readme.md)
  - [Blatt 04: Semantische Analyse](homework/sheet04.md)
  - [Blatt 01: Reguläre Sprachen](homework/sheet01.md)
  - [Blatt 02: CFG](homework/sheet02.md)
  - [Blatt 03: ANTLR](homework/sheet03.md)
endef

Wichtig:

Zwischen define SUMMARY_MD und endef darf alles stehen, inkl. Leerzeichen am Zeilenanfang.
Nutzen Sie als Namen gern groß (Konvention, weniger Kollisionen).
Makefile-Seite

# Einmal crawlen, Make-Zuweisungen + define importieren
$(eval $(shell ./crawl.lua --make-vars))

summary.md: Makefile
    @printf '%s\n' "$(SUMMARY_MD)" > $@


Damit schreiben Sie den mehrzeiligen Inhalt korrekt in summary.md.

Stolpersteine / Regeln (damit es robust bleibt)

1) Tabs am Zeilenanfang

In Makefiles bedeuten Tabs in Rezepten etwas Besonderes. In define … endef sind Tabs zwar erlaubt, aber wenn Ihr Summary aus Versehen mit Tabs statt Spaces einrückt, kann das später irritieren (z.B. wenn Sie es irgendwo “wieder” in ein Rezept einbetten). Empfehlung: im Summary nur Spaces erzeugen.

2) Die Sequenz endef als Zeile

Wenn im Summary eine Zeile exakt endef vorkäme, würde das das define beenden. In Markdown kommt das praktisch nicht vor, aber falls Sie ganz sicher gehen wollen: im Lua-Skript könnten Sie in so einem Fall z.B. endef → endef (mit Leerzeichen) maskieren.

3) $-Zeichen im Summary

Make expandiert Variablen mit $. Wenn Ihr Markdown $ enthält (LaTeX, Mathe), wird das sonst als Make-Variable interpretiert.

Dann müssen Sie in der Lua-Ausgabe jedes $ zu $$ verdoppeln, bevor Sie es in define schreiben.

Beispiel in Lua (konzeptionell):

summary = summary:gsub("%$", "$$")

4) Single quotes / HTML entities

Ihre Ausgabe zeigt '. Für Make ist das egal. Wenn Sie lieber echte ' schreiben: auch ok. Relevant sind primär $ und ggf. Backslashes in manchen Shell-Kontexten.

