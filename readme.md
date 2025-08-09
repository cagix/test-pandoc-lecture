---
archetype: home
has_license: true
no_beamer: true
title: "IFM 3.1 (PO23) / IFM 5.21 (PO18): Compilerbau (Winter 2024/25)"
---

![](admin/images/architektur_cb.png){width="80%"}

::: slides

------------------------------------------------------------------------------------

**Read Online**:

-   [GitHub
    Preview](https://github.com/cagix/test-pandoc-lecture/blob/_gfm/readme.md)
-   [Docsify
    Preview](https://docsify-this.net/?basePath=https://raw.githubusercontent.com/cagix/test-pandoc-lecture/refs/heads/_docsify&homepage=readme.md&sidebar=true&browser-tab-title=PR2&font-size=14px&searchbox=true&externalLinkTarget=_blank&mergeNavbar=true&zoom-images=true&dark-mode=auto#/)
-   [PDF-Version](https://github.com/cagix/test-pandoc-lecture/blob/_pdf/readme.pdf)

------------------------------------------------------------------------------------
:::

# Kursbeschreibung

Der Compiler ist das wichtigste Werkzeug in der Informatik. In der Königsdisziplin
der Informatik schließt sich der Kreis, hier kommen die unterschiedlichen
Algorithmen und Datenstrukturen und Programmiersprachenkonzepte zur Anwendung.

In diesem Modul geht es um ein grundlegendes Verständnis für die wichtigsten
Konzepte im Compilerbau. Wir schauen uns dazu relevante aktuelle Tools und
Frameworks an und setzen diese bei der Erstellung eines kleinen Compiler-Frontends
für C++ ein.

# Überblick Modulinhalte

1.  Lexikalische Analyse: Scanner/Lexer
    -   Reguläre Sprachen
    -   Generierung mit ANTLR
2.  Syntaxanalyse: Parser
    -   Kontextfreie Grammatiken (CFG)
    -   LL-Parser (Top-Down-Parser)
    -   Generierung mit ANTLR
3.  Semantische Analyse: Attributierte Grammatiken und Symboltabellen
    -   Namen und Scopes
    -   Typen, Klassen, Polymorphie
4.  Zwischencode: Intermediate Representation (IR), LLVM-IR
5.  Backend:
    -   LLVM
    -   Interpreter: AST-Traversierung
6.  C++ als zu verarbeitende Programmiersprache

# Team

-   [BC
    George](https://www.hsbi.de/minden/ueber-uns/personenverzeichnis/birgit-christina-george)
-   [Carsten
    Gips](https://www.hsbi.de/minden/ueber-uns/personenverzeichnis/carsten-gips)
    (Sprechstunde nach Vereinbarung)

# Kursformat

| Vorlesung (2 SWS) | Praktikum (2 SWS) |
|:----------------------------------------|:------------------------------------------|
| Mi, 08:00 - 09:30 Uhr (online) | S3, G1: Di, 11:30 - 13:00 Uhr (online/Präsenz J101) |
| (Carsten: *Flipped Classroom*, BC: *Vorlesung*) | S3, G2: Fr, 14:00 - 15:30 Uhr (online/Präsenz J101) |
|  | S3, G3: Mo, 09:15 - 10:45 Uhr (online/Präsenz J101) |
|  | (Carsten: *online*, BC: *Präsenz*) |

Online-Sitzungen per Zoom (**Zugangsdaten siehe [ILIAS IFM 3.1 CB (PO23, 3.
Semester)](https://www.hsbi.de/elearning/goto.php?target=crs_1400596&client_id=FH-Bielefeld)**).
Sie *können* hierzu den Raum J101 (siehe Stundenplan) nutzen.

# Fahrplan

Hier finden Sie einen abonnierbaren [Google Kalender IFM 3.1 CB (PO23, 3.
Semester)](https://calendar.google.com/calendar/ical/07021c87022fe3f132fa2e2e799b230b5ab9c7088c85d152f2beab8f1b5218af%40group.calendar.google.com/public/basic.ics)
mit allen Terminen der Veranstaltung zum Einbinden in Ihre Kalender-App.

Abgabe der Übungsblätter jeweils **Montag bis 09:00 Uhr** im
[ILIAS](https://www.hsbi.de/elearning/goto.php?target=exc_1420724&client_id=FH-Bielefeld).
Vorstellung der Lösung im jeweiligen Praktikum in der Abgabewoche.

| Monat                | Woche | Vorlesung                                                                                                                                               | Lead        | Abgabe Aufgabenblatt                         | Vorstellung Praktikum                                     |
|:---------------------|:------|:--------------------------------------------------------------------------------------------------------------------------------------------------------|:------------|:---------------------------------------------|:----------------------------------------------------------|
| Oktober              | 43    | 23.: [CFG](lecture/02-parsing/cfg.md) \|\| [B04](homework/sheet04.md) `<br>`{=html} [B04](homework/sheet04.md) `<br>`{=html} [B04](homework/sheet04.md) | Carsten, BC |                                              |                                                           |
|                      | 44    | 29.: **18:00 - 19:30 Uhr (online): Edmonton I: ANTLR + Live-Coding**                                                                                    | *Edmonton*  |                                              |                                                           |
|                      | 44    | 30.: [Parser mit ANTLR](lecture/02-parsing/antlr-parsing.md)                                                                                            | Carsten     |                                              |                                                           |
| November             | 45    | 06.: *Dienstbesprechung*                                                                                                                                |             | 04.: [B01](homework/sheet01.md) CFG          | ~~04.~~ **07. 08:00** / 05. / 08. (BC, *Präsenz*)         |
|                      | 52    | 25.: *Weihnachtspause*                                                                                                                                  |             |                                              |                                                           |
| Januar               | 01    | 01.: *Weihnachtspause*                                                                                                                                  |             |                                              |                                                           |
|                      | 02    | 08.: *Sprechstunde/Freies Arbeiten*                                                                                                                     | Carsten     | 06.: [B02](homework/sheet02.md) C++          | 06\. / 07. / 10. (Carsten, *online*)                      |
|                      | 03    | 15.: *Freies Arbeiten/Puffer*                                                                                                                           |             |                                              |                                                           |
|                      | 04    | 22.: **Parcoursprüfung: Station 2 [B04](homework/sheet04.md) (VL- und Praktika-Slots, siehe Ankündigung)**                                              | Carsten, BC | 20.: [B03](homework/sheet03.md) Mini-Projekt | 20\. / 21. / 24. (**15:00-16:30**) (Carsten/BC, *online*) |
| *(Prüfungsphase I)*  | 05    | 30.: **Feedback-Gespräche (15:30 - 18:00 Uhr, online)**                                                                                                 |             |                                              |                                                           |
| *(Prüfungsphase II)* |       | **Parcoursprüfung: Do, 27. Mar 2025, 08-18 Uhr, mdl. Prüfung (alle Themen)** (je Prüfung ca. 45', Vergabe ca. 2 Wochen vorher)                          |             |                                              |                                                           |
|                      |       | [TEST](lecture/03-test/test.md)                                                                                                                         |             |                                              |                                                           |

# Prüfungsform, Note und Credits

**Parcoursprüfung plus Testat**, 5 ECTS (PO23)

-   **Testat**: Vergabe der Credit-Points
    1.  Mindestens 4 der Übungsblätter [B01](homework/sheet01.md),
        [B02](homework/sheet02.md), [B03](homework/sheet03.md),
        [B04](homework/sheet04.md) erfolgreich bearbeitet, **und**
    2.  **aktive** Teilnahme an allen 3 Edmonton-Terminen.

    ("erfolgreich bearbeitet": Bearbeitung in 3er Teams, je mindestens 60%
    bearbeitet, fristgerechte Abgabe der Lösungen im ILIAS, Vorstellung der Lösungen
    im Praktikum)

## Prüfung im ersten Zeitraum"

-   **Stationen**:

    1.  ILIAS-Test (einzeln, 20.11.)
    2.  Vorstellung Mini-Projekt [B04](homework/sheet04.md) (3er Teams, letzte
        VL-Woche)

    Note für das Modul: Beide Stationen ergeben zu **je 50%** *oder* in der
    Gewichtung **30 Punkte (Station I) und 50 Punkte (Station II)** die Gesamtnote
    (individuelle Günstigerprüfung).

    Für Station I werden 3 Punkte Überhang gewährt: Von den 33 maximal erreichbaren
    Punkten werden 30 Punkte als 100% gewertet, darüber hinausgehende Punkte bleiben
    als Bonuspunkte erhalten.

## Prüfung im zweiten Zeitraum"

-   **Stationen**:
    1.  Mündliche Prüfung (individuell, ca. 45 Minuten, zweiter Prüfungszeitraum)

    Die Note der mündlichen Prüfung ergibt die Gesamtnote.

# Materialien

1.  ["**Compilers: Principles, Techniques, and
    Tools**"](https://learning.oreilly.com/library/view/compilers-principles-techniques/9789357054881/).
    Aho, A. V. und Lam, M. S. und Sethi, R. und Ullman, J. D. and Bansal, S.,
    Pearson India, 2023. ISBN
    [978-9-3570-5488-1](https://fhb-bielefeld.digibib.net/openurl?isbn=978-9-3570-5488-1).
    [Online](https://learning.oreilly.com/library/view/compilers-principles-techniques/9789357054881/)
    über die [O'Reilly-Lernplattform](https://www.oreilly.com/library-access/).
2.  ["**Crafting
    Interpreters**"](https://github.com/munificent/craftinginterpreters). Nystrom,
    R., Genever Benning, 2021. ISBN
    [978-0-9905829-3-9](https://fhb-bielefeld.digibib.net/openurl?isbn=978-0-9905829-3-9).
    [Online](https://www.craftinginterpreters.com/).
3.  ["**The Definitive ANTLR 4
    Reference**"](https://learning.oreilly.com/library/view/the-definitive-antlr/9781941222621/).
    Parr, T., Pragmatic Bookshelf, 2014. ISBN
    [978-1-9343-5699-9](https://fhb-bielefeld.digibib.net/openurl?isbn=978-1-9343-5699-9).
    [Online](https://learning.oreilly.com/library/view/the-definitive-antlr/9781941222621/)
    über die [O'Reilly-Lernplattform](https://www.oreilly.com/library-access/).
4.  ["Writing a C
    Compiler"](https://learning.oreilly.com/library/view/writing-a-c/9781098182229/).
    Sandler, N., No Starch Press, 2024. ISBN
    [978-1-0981-8222-9](https://fhb-bielefeld.digibib.net/openurl?isbn=978-1-0981-8222-9).
    [Online](https://learning.oreilly.com/library/view/writing-a-c/9781098182229/)
    über die [O'Reilly-Lernplattform](https://www.oreilly.com/library-access/).

# Förderungen und Kooperationen

## Kooperation mit University of Alberta, Edmonton (Kanada)

Über das Projekt ["We CAN
virtuOWL"](https://www.uni-bielefeld.de/international/profil/netzwerk/alberta-owl/we-can-virtuowl/)
der Fachhochschule Bielefeld ist im Frühjahr 2021 eine Kooperation mit der
[University of
Alberta](https://www.hsbi.de/en/international-office/alberta-owl-cooperation)
(Edmonton/Alberta, Kanada) im Modul "Compilerbau" gestartet.

Wir freuen uns, auch in diesem Semester wieder drei gemeinsame Sitzungen für beide
Hochschulen anbieten zu können. (Diese Termine werden in englischer Sprache
durchgeführt.)

# LICENSE

[<img src="https://licensebuttons.net/l/by-sa/4.0/88x31.png">](https://creativecommons.org/licenses/by-sa/4.0/)

Unless otherwise noted, this work is licensed under CC BY-SA 4.0.

Hier steht vielleicht noch mehr - zentrales Readme mit detaillierter Lizenz und
Credits. (Nicht mit generiertem Lizenz-Footer aus cb.yaml verwechseln.)
