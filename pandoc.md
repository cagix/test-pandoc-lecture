# Pandoc

## Slides (Beamer, PPTX)

1. MD: Liste der Slide-Abhängigkeiten (Markdown-Dateien) erstellen: `pandoc -L crawl.lua -M beamer=true`
2. MD: Ziel in build-Ordner: `$(patsubst %.md,$(OUTPUT_DIR)/%.pdf,$(MARKDOWN_SRC))`
3. MD: Ziel nicht vorhanden/zu alt: neu bauen: `pandoc ... src -o ziel`

## GFM/Docsify

1. MD: Liste der Markdown-Abhängigkeiten (Markdown-Dateien) erstellen: `pandoc -L crawl.lua`
2. Summary.md erstellen: `pandoc -L crawl.lua -M summary=true` und in Zielordner verschieben
3. Basierend auf Summary.md eine Gesamtdatei book.md erstellen: Dateien einlesen und Headings demoten
4. PNG: Liste aller referenzierten lokalen Abbildungen erstellen: `pandoc -L crawl.lua -M image=true`
5. MD: Ziel in build-Ordner: `$(patsubst %,$(OUTPUT_DIR)/%,$(MARKDOWN_SRC))`
6. PNG: Ziel in build-Ordner: `$(patsubst %,$(OUTPUT_DIR)/%,$(IMAGES))`
7. PNG: Ziel nicht vorhanden/zu alt:
    - Zielordner erstellen: `mkdir -p ..`
    - Kopieren des Originals
    - Invertieren des Originals mit ImageMagick (falls vorhanden)
8. MD: Ziel nicht vorhanden/zu alt:
    - Kopieren des Originals
    - Verarbeiten der Kopie mit Pandoc: `pandoc ... ziel -o ziel`

## Book (PDF)

1. Summary.md erstellen: `pandoc -L crawl.lua -M summary=true`
2. Basierend auf Summary.md eine Gesamtdatei book.md erstellen: Dateien einlesen und Headings demoten
3. Book.md bearbeiten und nach PDF konvertieren, Ausgabe in build-Ordner


