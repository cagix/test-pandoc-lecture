---
title: "IFM 3.1 (PO23) / IFM 5.21 (PO18): Compilerbau (Winter 2024/25)"
---

# Syllabus {#da39a3ee5e6b4b0d3255bfef95601890afd80709}

[Zur Kursbeschreibung](#da39a3ee5e6b4b0d3255bfef95601890afd80709)

[Kursbeschreibung](./xxx.md#da39a3ee5e6b4b0d3255bfef95601890afd80709)


![](admin/images/architektur_cb.png){width="80%"}

::: slides

------------------------------------------------------------------------

**Read Online**:

- [GitHub Preview](https://github.com/cagix/test-pandoc-lecture/blob/_gfm/readme.md)
- [Docsify Preview](https://docsify-this.net/?basePath=https://raw.githubusercontent.com/cagix/test-pandoc-lecture/refs/heads/_docsify&homepage=readme.md&sidebar=true&browser-tab-title=PR2&font-size=14px&searchbox=true&externalLinkTarget=_blank&mergeNavbar=true&zoom-images=true&dark-mode=auto#/)
- [PDF-Version](https://github.com/cagix/test-pandoc-lecture/blob/_pdf/readme.pdf)

------------------------------------------------------------------------
:::

## Kursbeschreibung {#da39a3ee5e6b4b0d3255bfef95601890afd80709}



## Kursbeschreibung

Der Compiler ist das wichtigste Werkzeug in der Informatik. In der Königsdisziplin der Informatik schließt sich der Kreis, hier kommen die unterschiedlichen Algorithmen und Datenstrukturen und Programmiersprachenkonzepte zur Anwendung.

In diesem Modul geht es um ein grundlegendes Verständnis für die wichtigsten Konzepte im Compilerbau. Wir schauen uns dazu relevante aktuelle Tools und Frameworks an und setzen diese bei der Erstellung eines kleinen Compiler-Frontends für C++ ein.

## Überblick Modulinhalte

1.  Lexikalische Analyse: Scanner/Lexer
    - Reguläre Sprachen
    - Generierung mit ANTLR
2.  Syntaxanalyse: Parser
    - Kontextfreie Grammatiken (CFG)
    - LL-Parser (Top-Down-Parser)
    - Generierung mit ANTLR
3.  Semantische Analyse: Attributierte Grammatiken und Symboltabellen
    - Namen und Scopes
    - Typen, Klassen, Polymorphie
4.  Zwischencode: Intermediate Representation (IR), LLVM-IR
5.  Backend:
    - LLVM
    - Interpreter: AST-Traversierung
6.  C++ als zu verarbeitende Programmiersprache

## Team

- [BC George](https://www.hsbi.de/minden/ueber-uns/personenverzeichnis/birgit-christina-george)
- [Carsten Gips](https://www.hsbi.de/minden/ueber-uns/personenverzeichnis/carsten-gips) (Sprechstunde nach Vereinbarung)

## Kursformat

  -------------------------------------------------------------------------------------------------------
  Vorlesung (2 SWS)                                 Praktikum (2 SWS)
  ------------------------------------------------- -----------------------------------------------------
  Mi, 08:00 - 09:30 Uhr (online)                    S3, G1: Di, 11:30 - 13:00 Uhr (online/Präsenz J101)

  (Carsten: *Flipped Classroom*, BC: *Vorlesung*)   S3, G2: Fr, 14:00 - 15:30 Uhr (online/Präsenz J101)

                                                    S3, G3: Mo, 09:15 - 10:45 Uhr (online/Präsenz J101)

                                                    (Carsten: *online*, BC: *Präsenz*)
  -------------------------------------------------------------------------------------------------------

Online-Sitzungen per Zoom (**Zugangsdaten siehe [ILIAS IFM 3.1 CB (PO23, 3. Semester)](https://www.hsbi.de/elearning/goto.php?target=crs_1400596&client_id=FH-Bielefeld)**). Sie *können* hierzu den Raum J101 (siehe Stundenplan) nutzen.

## Fahrplan

Hier finden Sie einen abonnierbaren [Google Kalender IFM 3.1 CB (PO23, 3. Semester)](https://calendar.google.com/calendar/ical/07021c87022fe3f132fa2e2e799b230b5ab9c7088c85d152f2beab8f1b5218af%40group.calendar.google.com/public/basic.ics) mit allen Terminen der Veranstaltung zum Einbinden in Ihre Kalender-App.

Abgabe der Übungsblätter jeweils **Montag bis 09:00 Uhr** im [ILIAS](https://www.hsbi.de/elearning/goto.php?target=exc_1420724&client_id=FH-Bielefeld). Vorstellung der Lösung im jeweiligen Praktikum in der Abgabewoche.

  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Monat                  Woche   Vorlesung                                                                                                                                                                                                                                   Lead          Abgabe Aufgabenblatt                                                 Vorstellung Praktikum
  ---------------------- ------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------- -------------------------------------------------------------------- -----------------------------------------------------------
  Oktober                43      23.: [CFG](xxx.md#ed1ca9f1d126c913f7ce93106335deafa8e5a251) \|\| [B04](#6dc682255c67debc1eebb45a3920a1731f87be41) `<br>`{=html} [B04](#6dc682255c67debc1eebb45a3920a1731f87be41) `<br>`{=html} [B04](#6dc682255c67debc1eebb45a3920a1731f87be41)   Carsten, BC

                         44      29.: **18:00 - 19:30 Uhr (online): Edmonton I: ANTLR + Live-Coding**                                                                                                                                                                        *Edmonton*

                         44      30.: [Parser mit ANTLR](#6cf46704b72b833be34e815ad028ca9585eca248)                                                                                                                                                                          Carsten

  November               45      06.: *Dienstbesprechung*                                                                                                                                                                                                                                  04.: [B01](#6f673c2e093cdfc53b1f78baef11fd06cc8aa415) CFG            ~~04.~~ **07. 08:00** / 05. / 08. (BC, *Präsenz*)

                         52      25.: *Weihnachtspause*

  Januar                 01      01.: *Weihnachtspause*

                         02      08.: *Sprechstunde/Freies Arbeiten*                                                                                                                                                                                                         Carsten       06.: [B02](#0db349230022c35e045dc3b052a4faea50fe5f40) C++            06\. / 07. / 10. (Carsten, *online*)

                         03      15.: *Freies Arbeiten/Puffer*

                         04      22.: **Parcoursprüfung: Station 2 [B04](#6dc682255c67debc1eebb45a3920a1731f87be41) (VL- und Praktika-Slots, siehe Ankündigung)**                                                                                                            Carsten, BC   20.: [B03](#0caafae8610423845a8dd05fc7941ec5d42fbae3) Mini-Projekt   20\. / 21. / 24. (**15:00-16:30**) (Carsten/BC, *online*)

  *(Prüfungsphase I)*    05      30.: **Feedback-Gespräche (15:30 - 18:00 Uhr, online)**

  *(Prüfungsphase II)*           **Parcoursprüfung: Do, 27. Mar 2025, 08-18 Uhr, mdl. Prüfung (alle Themen)** (je Prüfung ca. 45', Vergabe ca. 2 Wochen vorher)

                                 [TEST](#5ffe05b0cc6e0ec8341b3bea1c18f41cd3de0a4e)
  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Prüfungsform, Note und Credits

**Parcoursprüfung plus Testat**, 5 ECTS (PO23)

- **Testat**: Vergabe der Credit-Points
  1.  Mindestens 4 der Übungsblätter [B01](#6f673c2e093cdfc53b1f78baef11fd06cc8aa415), [B02](#0db349230022c35e045dc3b052a4faea50fe5f40), [B03](#0caafae8610423845a8dd05fc7941ec5d42fbae3), [B04](#6dc682255c67debc1eebb45a3920a1731f87be41) erfolgreich bearbeitet, **und**
  2.  **aktive** Teilnahme an allen 3 Edmonton-Terminen.

  ("erfolgreich bearbeitet": Bearbeitung in 3er Teams, je mindestens 60% bearbeitet, fristgerechte Abgabe der Lösungen im ILIAS, Vorstellung der Lösungen im Praktikum)

### Prüfung im ersten Zeitraum"

- **Stationen**:

  1.  ILIAS-Test (einzeln, 20.11.)
  2.  Vorstellung Mini-Projekt [B04](#6dc682255c67debc1eebb45a3920a1731f87be41) (3er Teams, letzte VL-Woche)

  Note für das Modul: Beide Stationen ergeben zu **je 50%** *oder* in der Gewichtung **30 Punkte (Station I) und 50 Punkte (Station II)** die Gesamtnote (individuelle Günstigerprüfung).

  Für Station I werden 3 Punkte Überhang gewährt: Von den 33 maximal erreichbaren Punkten werden 30 Punkte als 100% gewertet, darüber hinausgehende Punkte bleiben als Bonuspunkte erhalten.

### Prüfung im zweiten Zeitraum"

- **Stationen**:
  1.  Mündliche Prüfung (individuell, ca. 45 Minuten, zweiter Prüfungszeitraum)

  Die Note der mündlichen Prüfung ergibt die Gesamtnote.

## Materialien

1.  ["**Compilers: Principles, Techniques, and Tools**"](https://learning.oreilly.com/library/view/compilers-principles-techniques/9789357054881/). Aho, A. V. und Lam, M. S. und Sethi, R. und Ullman, J. D. and Bansal, S., Pearson India, 2023. ISBN [978-9-3570-5488-1](https://fhb-bielefeld.digibib.net/openurl?isbn=978-9-3570-5488-1). [Online](https://learning.oreilly.com/library/view/compilers-principles-techniques/9789357054881/) über die [O'Reilly-Lernplattform](https://www.oreilly.com/library-access/).
2.  ["**Crafting Interpreters**"](https://github.com/munificent/craftinginterpreters). Nystrom, R., Genever Benning, 2021. ISBN [978-0-9905829-3-9](https://fhb-bielefeld.digibib.net/openurl?isbn=978-0-9905829-3-9). [Online](https://www.craftinginterpreters.com/).
3.  ["**The Definitive ANTLR 4 Reference**"](https://learning.oreilly.com/library/view/the-definitive-antlr/9781941222621/). Parr, T., Pragmatic Bookshelf, 2014. ISBN [978-1-9343-5699-9](https://fhb-bielefeld.digibib.net/openurl?isbn=978-1-9343-5699-9). [Online](https://learning.oreilly.com/library/view/the-definitive-antlr/9781941222621/) über die [O'Reilly-Lernplattform](https://www.oreilly.com/library-access/).
4.  ["Writing a C Compiler"](https://learning.oreilly.com/library/view/writing-a-c/9781098182229/). Sandler, N., No Starch Press, 2024. ISBN [978-1-0981-8222-9](https://fhb-bielefeld.digibib.net/openurl?isbn=978-1-0981-8222-9). [Online](https://learning.oreilly.com/library/view/writing-a-c/9781098182229/) über die [O'Reilly-Lernplattform](https://www.oreilly.com/library-access/).

## Förderungen und Kooperationen

### Kooperation mit University of Alberta, Edmonton (Kanada)

Über das Projekt ["We CAN virtuOWL"](https://www.uni-bielefeld.de/international/profil/netzwerk/alberta-owl/we-can-virtuowl/) der Fachhochschule Bielefeld ist im Frühjahr 2021 eine Kooperation mit der [University of Alberta](https://www.hsbi.de/en/international-office/alberta-owl-cooperation) (Edmonton/Alberta, Kanada) im Modul "Compilerbau" gestartet.

Wir freuen uns, auch in diesem Semester wieder drei gemeinsame Sitzungen für beide Hochschulen anbieten zu können. (Diese Termine werden in englischer Sprache durchgeführt.)

## LICENSE

[`<img src="https://licensebuttons.net/l/by-sa/4.0/88x31.png">`{=html}](https://creativecommons.org/licenses/by-sa/4.0/)

Unless otherwise noted, this work is licensed under CC BY-SA 4.0.

Hier steht vielleicht noch mehr - zentrales Readme mit detaillierter Lizenz und Credits. (Nicht mit generiertem Lizenz-Footer aus cb.yaml verwechseln.)

# Vorlesungsunterlagen {#af09e2fcaf4589921086150d991647b7b52abd03}

## Syntaktische Analyse {#208bd9b4194c2c79688c8354df6850e6040cdef7}

In der syntaktischen Analyse arbeitet ein Parser mit dem Tokenstrom, der vom Lexer kommt. Mit Hilfe einer Grammatik wird geprüft, ob gültige Sätze im Sinne der Sprache/Grammatik gebildet wurden. Der Parser erzeugt dabei den Parse-Tree. Man kann verschiedene Parser unterscheiden, beispielsweise die LL- und die LR-Parser.

### CFG {#ed1ca9f1d126c913f7ce93106335deafa8e5a251}

::: attachments
- [Annotierte Folien: CFG, LL-Parser](https://raw.githubusercontent.com/Compiler-CampusMinden/AnnotatedSlides/master/frontend_parsing_cfg.ann.ba.pdf)
:::

#### Wiederholung

##### Endliche Automaten, reguläre Ausdrücke, reguläre Grammatiken, reguläre Sprachen

- Wie sind DFAs und NFAs definiert?
- Was sind reguläre Ausdrücke?
- Was sind formale und reguläre Grammatiken?
- In welchem Zusammenhang stehen all diese Begriffe?
- Wie werden DFAs und reguläre Ausdrücke im Compilerbau eingesetzt?

#### Motivation

##### Wofür reichen reguläre Sprachen nicht?

Für z. B. alle Sprachen, in deren Wörtern Zeichen über eine Konstante hinaus gezählt werden müssen. Diese Sprachen lassen sich oft mit Variablen im Exponenten beschreiben, die unendlich viele Werte annehmen können.

- $a^ib^{2*i}$ ist nicht regulär
- $a^ib^{2*i}$ für $0 \leq i \leq 3$ ist regulär

\smallskip

- Wo finden sich die oben genannten Variablen bei einem DFA wieder?
- Warum ist die erste Sprache oben nicht regulär, die zweite aber?

##### Themen für heute

- PDAs: mächtiger als DFAs, NFAs
- kontextfreie Grammatiken und Sprachen: mächtiger als reguläre Grammatiken und Sprachen
- DPDAs und deterministisch kontextfreie Grammatiken: die Grundlage der Syntaxanalyse im Compilerbau
- Der Einsatz kontextfreier Grammatiken zur Syntaxanalyse mittels Top-Down-Techniken

##### Einordnung: Erweiterung der Automatenklasse DFA, um komplexere Sprachen als die regulären akzeptieren zu können

Wir spendieren den DFAs einen möglichst einfachen, aber beliebig großen, Speicher, um zählen und matchen zu können. Wir suchen dabei konzeptionell die "kleinstmögliche" Erweiterung, die die akzeptierte Sprachklasse gegenüber DFAs vergrößert.

- Der konzeptionell einfachste Speicher ist ein Stack. Wir haben keinen wahlfreien Zugriff auf die gespeicherten Werte.

- Es soll eine deterministische und eine indeterministische Variante der neuen Automatenklasse geben.

- In diesem Zusammenhang wird der Stack auch Keller genannt.

##### Kellerautomaten (Push-Down-Automata, PDAs)

**Def.:** Ein Kellerautomat (PDA) $P = (Q,\ \Sigma,\ \Gamma,\  \delta,\ q_0,\ \perp,\ F)$ ist ein Septupel mit:

![Definition eines PDAs](lecture/02-parsing/images/Def_PDA.png){width="60%"}

Ein PDA ist per Definition nichtdeterministisch und kann spontane Zustandsübergänge durchführen.

##### Was kann man damit akzeptieren?

Strukturen mit paarweise zu matchenden Symbolen.

Bei jedem Zustandsübergang wird ein Zeichen (oder $\epsilon$) aus der Eingabe gelesen, ein Symbol von Keller genommen. Diese und das Eingabezeichen bestimmen den Folgezustand und eine Zeichenfolge, die auf den Stack gepackt wird. Dabei wird ein Symbol, (z. B. eines, das später mit einem Eingabesymbol zu matchen ist,) auf den Stack gepackt. Soll das automatisch vom Stack genommene Symbol auf dem Stack bleiben, muss es wieder gepusht werden.

##### Beispiel

Ein PDA für $L=\lbrace ww^{R}\mid w\in \lbrace a,b\rbrace^{\ast}\rbrace$:

![](lecture/02-parsing/images/pda2.png){width="45%"}

##### Deterministische PDAs

**Def.** Ein PDA $P = (Q, \Sigma, \Gamma, \delta, q_0, \perp, F)$ ist *deterministisch* $: \Leftrightarrow$

- $\delta(q, a, X)$ hat höchstens ein Element für jedes $q \in Q, a \in\Sigma$ oder $(a = \epsilon$ und $X \in \Gamma)$.

- Wenn $\delta (q, a, x)$ nicht leer ist für ein $a \in \Sigma$, dann muss $\delta (q, \epsilon, x)$ leer sein.

Deterministische PDAs werden auch *DPDAs* genannt.

##### Der kleine Unterschied

**Satz:** Die von DPDAs akzeptierten Sprachen sind eine echte Teilmenge der von PDAs akzeptierten Sprachen.

Die regulären Sprachen sind eine echte Teilmenge der von DPDAs akzeptierten Sprachen.

#### Kontextfreie Grammatiken und Sprachen

##### Kontextfreie Grammatiken

**Def.** Eine *kontextfreie (cf-)* Grammatik ist ein 4-Tupel $G = (N, T, P, S)$ mit $N, T, S$ wie in (formalen) Grammatiken und $P$ ist eine endliche Menge von Produktionen der Form:

$X \rightarrow Y$ mit $X \in N, Y \in {(N \cup T)}^{\ast}$.

$\Rightarrow, \overset{\ast}{\Rightarrow}$ sind definiert wie bei regulären Sprachen. Bei cf-Grammatiken nennt man die Ableitungsbäume oft *Parse trees*.

##### Beispiel

\vspace{-2.5cm}

$S \rightarrow a \mid S\ +\  S\ |\  S \ast S$

Ableitungsbäume für $a + a \ast a$: `\vfill`{=tex}

::: notes
Hier entsteht ein Tafelbild.
:::

##### Nicht jede kontextfreie Grammatik ist eindeutig

**Def.:** Gibt es in einer von einer kontextfreien Grammatik erzeugten Sprache ein Wort, für das mehr als ein Ableitungsbaum existiert, so heißt diese Grammatik *mehrdeutig*. Anderenfalls heißt sie *eindeutig*.

**Satz:** Es ist nicht entscheidbar, ob eine gegebene kontextfreie Grammatik eindeutig ist.

**Satz:** Es gibt kontextfreie Sprachen, für die keine eindeutige Grammatik existiert.

##### Kontextfreie Grammatiken und PDAs

**Satz:** Die kontextfreien Sprachen und die Sprachen, die von PDAs akzeptiert werden, sind dieselbe Sprachklasse.

**Satz:** Eine von einem DPDA akzeptierteSprache hat eine eindeutige Grammatik.

Vorgehensweise im Compilerbau: Eine Grammatik für die gewünschte Sprache definieren und schauen, ob sich daraus ein DPDA generieren lässt (automatisch).

#### Syntaxanalyse

##### Was brauchen wir für die Syntaxanalyse von Programmen?

- einen Grammatiktypen, aus dem sich manuell oder automatisiert ein Programm zur deterministischen Syntaxanalyse (=Parser) erstellen lässt

- einen Algorithmus zum Parsen von Programmen mit Hilfe einer solchen Grammatik

##### Syntax

Wir verstehen unter Syntax eine Menge von Regeln, die die Struktur von Daten (z. B. Programmen) bestimmen.

Diese vorgegebene Syntax wird im Compilerbau mit einer kontextfreien Grammatik beschrieben und mit einem sogenannten **Parser** analysiert.

Heute: LL-Parsing, mit dem man eine Teilmenge der eindeutigen kontextfreien Grammatiken syntaktich analysieren kann.

Dabei wird der Ableitungsbaum von oben nach unten aufgebaut.

##### Ziele der Syntaxanalyse

- Bestimmung der syntaktischen Struktur eines Programms

- aussagekräftige Fehlermeldungen, wenn ein Eingabeprogramm syntaktisch nicht korrekt ist

- Erstellung des AST (abstrakter Syntaxbaum): Der Parse Tree ohne Symbole, die nach der Syntaxanalyse inhaltlich irrelevant sind (z. B. Semikolons, manche Schlüsselwörter)

- die Symboltablelle(n) mit Informationen bzgl. Bezeichner (Variable, Funktionen und Methoden, Klassen, benutzerdefinierte Typen, Parameter, ...), aber auch die Gültigkeitsbereiche.

#### LL(k)-Grammatiken

##### First-Mengen

$S \rightarrow A \ \vert \ B \ \vert \ C$

Welche Produktion nehmen?

Wir brauchen die "terminalen k-Anfänge" von Ableitungen von Nichtterminalen, um eindeutig die nächste zu benutzende Produktion festzulegen. $k$ ist dabei die Anzahl der Vorschautoken.

**Def.:** Wir definieren $First$ - Mengen einer Grammatik wie folgt:

- $a \in T^\ast, |a| \leq k: {First}_k (a) = \lbrace a \rbrace$
- $a \in T^\ast, |a| > k: {First}_k (a) = \lbrace v \in T^\ast \mid a = vw, |v| = k \rbrace$
- $\alpha \in (N \cup T)^\ast \backslash T^\ast: {First}_k (\alpha) = \lbrace v \in T^\ast \mid  \alpha \overset{\ast}{\Rightarrow} w,\text{mit}\ w \in T^\ast, First_k(w) = \lbrace v \rbrace \rbrace$

##### Linksableitungen

**Def.:** Bei einer kontextfreien Grammatik $G$ ist die *Linksableitung* von $\alpha \in (N \cup T)^{\ast}$ die Ableitung, die man erhält, wenn in jedem Schritt das am weitesten links stehende Nichtterminal in $\alpha$ abgeleitet wird.

Man schreibt $\alpha \overset{\ast}{\Rightarrow}_l \beta.$

##### LL(k)-Grammatiken

**Def.:** Eine kontextfreie Grammatik $G = (N, T, P, S)$ ist genau dann eine *LL(k)*-Grammatik, wenn für alle Linksableitungen der Form:

$S \overset{\ast}{\Rightarrow}_l\ wA \gamma\ {\Rightarrow}_l\ w\alpha\gamma \overset{\ast}{\Rightarrow}_l wx$

und

$S \overset{\ast}{\Rightarrow}_l wA \gamma {\Rightarrow}_l w\beta\gamma \overset{\ast}{\Rightarrow}_l wy$

mit $(w, x, y \in T^\ast, \alpha, \beta, \gamma \in (N \cup T)^\ast, A \in N)$ und $First_k(x) = First_k(y)$ gilt:

$\alpha = \beta$

##### LL(1)-Grammatiken

::: notes
Hier entsteht ein Tafelbild.
:::

##### LL(k)-Sprachen

Die von *LL(k)*-Grammatiken erzeugten Sprachen sind eine echte Teilmenge der deterministisch parsbaren Sprachen.

Die von *LL(k)*-Grammatiken erzeugten Sprachen sind eine echte Teilmenge der von *LL(k+1)*-Grammatiken erzeugten Sprachen.

Für eine kontextfreie Grammatik $G$ ist nicht entscheidbar, ob es eine *LL(1)* - Grammatik $G'$ gibt mit $L(G) = L(G')$.

In der Praxis reichen *LL(1)* - Grammatiken oft. Hier gibt es effiziente Parsergeneratoren (hier: ANTLR), deren Eingabe eine LL-Grammatik ist, und die als Ausgabe den Quellcode eines (effizienten) tabellengesteuerten Parsers generieren.

##### Was brauchen wir zur Erzeugung eines LL(k)-Parsers?

- eine *LL(k)*-Grammatik
- die $First_k$-Mengen der rechten Seiten aller Produktionsregeln
- die $Follow_k$-Mengen aller Nichtterminale und der rechten Seiten aller Produktionsregeln
- das Endezeichen $\perp$ hinter dem Eingabewort

**Def.:** Wir definieren $Follow$ - Mengen einer Grammatik wie folgt:

$Follow_k(\beta) = \lbrace w \in T^\ast\ |\ \exists \alpha, \gamma \in (N \cup T)^\ast\ \text{mit}\ S \overset{\ast}{\Rightarrow}_l\ \alpha \beta \gamma\ \text{und}\ w \in First_k(\gamma) \rbrace$

##### Beispiel: First- und Follow-Mengen

::: notes
Hier entsteht ein Tafelbild.
:::

##### Algorithmus: Konstruktion einer LL-Parsertabelle {#algorithmus-konstruktion-einer-ll-parsertabelle .fragile}

**Eingabe:** Eine Grammatik $G = (N, T, P, S)$

**Ausgabe:** Eine Parsertabelle $P$

![Algorithmus zur Generierung einer LL-Parsertabelle](lecture/02-parsing/images/LL-Parsertabelle.png){width="60%"}

Statt $First_1(\alpha)$ wird oft nur $First(\alpha)$ geschrieben.

##### Beispiel: LL-Parsertabellen

::: notes
Hier entsteht ein Tafelbild.
:::

##### LL-Parser

Rekursive Programmierung bedeutet, dass das Laufzeitsystem einen Stack benutzt. Diesen Stack kann man auch "selbst programmieren", d. h. einen PDA implementieren. Dabei wird ebenfalls die oben genannte Tabelle zur Bestimmung der nächsten anzuwendenden Produktion benutzt. Der Stack enthält die zu erwartenden Eingabezeichen, wenn immer eine Linksableitung gebildet wird. Diese Zeichen im Stack werden mit dem Input gematcht.

##### Algorithmus: Tabellengesteuertes LL-Parsen mit einem PDA {#algorithmus-tabellengesteuertes-ll-parsen-mit-einem-pda .fragile}

**Eingabe:** Eine Grammatik $G = (N, T, P, S)$, eine Parsertabelle $P$ mit "$w\perp$" als initialem Kellerinhalt

**Ausgabe:** Wenn $w \in L(G)$, eine Linksableitung von $w$, Fehler sonst

![Algorithmus zum tabellengesteuerten LL-Parsen](lecture/02-parsing/images/LL-Parser.png){width="49%"}

##### Beispiel: LL-Parsen

::: notes
Hier entsteht ein Tafelbild.
:::

##### Ergebnisse der Syntaxanalyse

- eventuelle Syntaxfehler mit Angabe der Fehlerart und des -Ortes

- Format für die Weiterverarbeitung:

  - Ableitungsbaum oder Syntaxbaum oder Parse Tree
  - abstrakter Syntaxbaum (AST): Der Parse Tree ohne Symbole, die nach der Syntaxanalyse inhaltlich irrelevant sind (z. B. ;, Klammern, manche Schlüsselwörter, $\ldots$)

#### Wrap-Up

##### Das sollen Sie mitnehmen

- Die Struktur von gängigen Programmiersprachen lässt sich nicht mit regulären Ausdrücken beschreiben und damit nicht mit DFAs akzeptieren.
- Das Automatenmodell der DFAs wird um einen endlosen Stack erweitert, das ergibt PDAs.
- Kontextfreie Grammatiken (CFGs) erweitern die regulären Grammatiken.
- Deterministisch parsebare Sprachen haben eine eindeutige kontextfreie Grammatik.
- Es ist nicht entscheidbar, ob eine gegebene kontextfreie Grammatik eindeutig ist.
- Syntaxanalyse wird mit deterministisch kontextfreien Grammatiken durchgeführt.
- Eine Teilmenge der dazu gehörigen Sprachen lässt sich top-down parsen.
- Ein effizienter LL(k)-Parser realisiert einen DPDA und kann automatisch aus einer LL(k)-Grammatik generiert werden.
- Der Parser liefert in der Regel einen abstrakten Syntaxbaum.

<!-- ADD
- mehr Inhalte für CFGs (vertiefendere Erklärungen)
- spezifisches Wrap-up für CFGs
ADD -->

::: readings
- @Aho2023
- @hopcroft2003
:::

::: outcomes
- k1: PDAs
- k1: Deterministische PDAs
- k1: Kontextfreie Grammatiken
- k1: Deterministisch kontextfreie Grammatiken
- k1: Top-Down-Analyse
- k1: LL-Parser
- k2: Zusammenhang zwischen PDAs und kontextfreien Grammatiken
:::

### Parser mit ANTLR generieren {#6cf46704b72b833be34e815ad028ca9585eca248}

::: tldr
Mit ANTLR kann aus einer Grammatik ein LL(\*)-Parser generiert werden. Die Parser-Regeln in der Grammatik fangen dabei mit einem **Kleinbuchstaben** an (Erinnerung: Lexer-Regel starten mit einem Großbuchstaben).

Regeln haben einen Namen (linke Seite) und eine Produktion (rechte Seite). Dabei können beliebige Abfolgen von Lexer- und Parser-Regeln auf der rechten Seite einer Parser-Regel auftauchen. Die Token müssen jeweils matchen, die Parser-Regeln werden in einen Aufruf der jeweiligen generierten Funktion übersetzt.

Parser-Regeln können aus mehreren Alternativen bestehen, diese werden per `|` separiert. Dabei hat bei Mehrdeutigkeiten die erste passende Alternative Vorrang. Wie bei Lexer-Regeln können Teile per `?` ein- oder keinmal vorkommen, per `*` beliebig oft oder per `+` ein- oder mehrfach.

ANTLR erlaubt im Gegensatz zu allgemeinen LL-Parsern direkte Links-Rekursion. (Indirekte Links-Rekursion funktioniert allerdings nicht.)

Der von ANTLR generierte Parser erzeugt auf der Eingabe einen Parse-Tree, der die Strukturen der Grammatik widerspiegelt: Die Token bilden die Blätter und jede erfolgreich durchlaufene Parser-Regel bildet einen entsprechenden Knoten im Baum.

Für die Traversierung des Parse-Tree kann man die generierten Listener- oder Visitor-Klassen nutzen. Beim Einsatz der Listener nutzt man die vorgegebene Klasse `ParseTreeWalker`, die mit dem Parse-Tree und dem Listener den Baum per Tiefensuche traversiert und immer die jeweiligen `enterRegel`- und `exitRegel`-Methoden aufruft. Beim Visitor muss die Traversierung selbst erledigt werden, hier steht die aus der Klassenhierarchie geerbte Methode `visit` als Startpunkt zur Verfügung. In dieser Methode wird basierend auf dem Knotentyp die in den Visitor-Klassen implementierte `visitRegel`-Methode aufgerufen und man muss darauf achten, die Kindknoten durch passende Aufrufe zu traversieren. Sowohl bei den generierten Listener- als auch den Visitor-Klassen kann man die leeren Defaultmethoden bei Bedarf selbst überschreiben. Für den Zugriff auf die Regel-Elemente werden die sogenannten Kontextobjekte als Parameter übergeben.

Benannte Alternativen und Regel-Elemente sind nützlich, weil für die benannten Alternativen zusätzliche Kontextklassen erzeugt werden, über die dann auf die Bestandteile der Alternativen zugegriffen werden kann. Außerdem werden zusätzlich passende `enterAlternative`- und `exitAlternative`- bzw. `visitAlternative`-Methoden generiert. Für benannte Regel-Elemente wird ein entsprechend benanntes Attribut im Kontextobjekt angelegt, welches `public` sichtbar ist.
:::

::: youtube
- [VL Parser mit ANTLR (YT)](https://youtu.be/YuUHBvPUS4k)
- [Demo ANTLR Parser (YT)](https://youtu.be/FJOEPY-TMmw)
- [VL Parser mit ANTLR (HSBI)](https://www.hsbi.de/medienportal/m/19925b756d6fc934bfe0b5107eb5fa58373a53af49c690ebce86e15f2b212c89c80ea7665e42c78abdc8dfe0718ea46f6a9817eeba4ad1293bdb4c84f7c8f084)
:::

#### Hello World

``` antlr
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

[Konsole: Hello (grun, Parse-Tree)]{.ex href="https://github.com/Compiler-CampusMinden/CB-Vorlesung-Bachelor/blob/master/lecture/02-parsing/src/Hello.g4"}

::: notes
##### Starten des Parsers

1.  Grammatik übersetzen und Code generieren: `antlr Hello.g4`
2.  Java-Code kompilieren: `javac *.java`
3.  Parser ausführen:
    - `grun Hello start -tree` oder `grun Hello start -gui` (Grammatik "Hello", Startregel "start")

    - Alternativ mit kleinem Java-Programm:

      ``` java
      import org.antlr.v4.runtime.CharStreams;
      import org.antlr.v4.runtime.CommonTokenStream;
      import org.antlr.v4.runtime.tree.ParseTree;

      public class Main {
          public static void main(String[] args) throws Exception {
              HelloLexer lexer = new HelloLexer(CharStreams.fromStream(System.in));
              CommonTokenStream tokens = new CommonTokenStream(lexer);
              HelloParser parser = new HelloParser(tokens);

              ParseTree tree = parser.start();  // Start-Regel
              System.out.println(tree.toStringTree(parser));
          }
      }
      ```

##### Startregeln

- `start` ist eine ==Parser-Regel== =\> Eine Parser-Regel pro Grammatik wird benötigt, damit man den generierten Parser am Ende auch starten kann ...
- Alle Regeln mit kleinem Anfangsbuchstaben sind Parser-Regeln
- Alle Regeln mit großem Anfangsbuchstaben sind Lexer-Regeln

##### Formen der Subregeln

``` antlr
stmt  : ID '=' expr ';' ;
```

Um die Regel `stmt` anwenden zu können, müssen alle Elemente auf der rechten Seite der Regel erfüllt werden. Dabei müssen die Token wie `ID`, `=` und `;` matchen und die Subregel `expr` muss erfüllt werden können. Beachten Sie das abschließende Semikolon am Ende einer ANTLR-Regel!

``` antlr
stmt  : ID '=' expr ';' | expr ';' ;
```

Alternativen werden durch ein `|` getrennt. Hier muss genau eine Alternative erfüllt werden. Falls nötig, trennt man die Alternativen durch Einschließung in runden Klammern vom Rest der Regel ab: `r : a (b | c) d ;`.

``` antlr
expr  : term ('+' term)* ;
```

Der durch den `*` gekennzeichnete Teil kann beliebig oft vorkommen oder auch fehlen. Bei einem `+` müsste der Teil mind. einmal vorkommen und bei einem `?` entsprechend einmal oder keinmal.

Auch hier kann man die Operatoren durch ein zusätzliches `?` auf non-greedy umschalten (analog zu den Lexer-Regeln).

(vgl. [github.com/antlr/antlr4/blob/master/doc/parser-rules.md](https://github.com/antlr/antlr4/blob/master/doc/parser-rules.md#subrules))

##### Reihenfolge in Grammatik definiert Priorität

Falls mehr als eine Parser-Regel die selbe Input-Sequenz matcht, löst ANTLR diese Mehrdeutigkeit auf, indem es die erste Alternative nimmt, die an der Entscheidung beteiligt ist.

``` antlr
start : stmt ;

stmt  : expr | ID  ;
expr  : ID   | NUM ;
```

Bei der Eingabe "foo" würde die Alternative `ID` in der Regel `expr` "gewinnen", weil sie in der Grammatik vor der Alternative `ID` in der Regel `stmt` kommt und damit Vorrang hat.

##### Parse-Tree

Betrachten wir erneut die obige Grammatik.

Die Eingabe von "`a = 42;`" führt zu folgendem Parse-Tree:

![](lecture/02-parsing/images/hello_ex1.png){width="60%"}

Diese Eingabe führt zur Erkennung der Token `[ID, WS, =, WS, NUM, ;]`, wobei die `WS`-Token verworfen werden und der Parser den Tokenstream `[ID, =, NUM, ;]` erhält.

Die Startregel hat auf der rechten Seite kein oder mehrere `stmt`-Regeln. Die `stmt`-Regel fordert auf der rechten Seite entweder die Token `ID`und `=` sowie die Regel `expr` gefolgt vom Token `;`, oder die Regel `expr` gefolgt vom Token `;`. In unserem Beispiel kann für das "a" das Token `ID` produziert werden, das "=" matcht ebenfalls. Die "42" wird erklärt, indem für `expr` ein `term` und dort ein `atom` aufgerufen wird. Für das `atom` muss entweder ein Token `ID` oder `NUM` als nächstes Token kommen - hier wird die "42" wird als Token `NUM` verarbeitet. Da die weiteren Regelteile in `term` und `expr` optional sind, haben wir damit ein `expr` erfüllt und das nachfolgende `;`-Token schließt die erste Alternative der Regel `stmt` erfolgreich ab.

Im entstehenden Parse-Tree sind diese Abläufe und grammatikalischen Strukturen direkt erkennbar. Jede erfolgreich durchlaufene Parserregel wird zu einem Knoten im Parse-Tree. Die Token werden als Terminale (Blätter) in den Baum eingehängt.

*Anmerkung*: Der Parse-Tree ist das Ergebnis der Parsers-Phase im Compiler und dient damit als Input für die folgenden Compilerstufen. In der Regel benötigt man die oft recht komplexen Strukturen aber später nicht mehr und vereinfacht den Baum zu einem *Abstract Syntax Tree* (AST). Im Beispiel könnte man den Zweig `stmt - expr - term - atom - 42` zu `stmt - 42` vereinfachen.

Betrachten wir nun die Eingabe `foo = 2+3*4; bar = 3*4+2;`. Diese führt zu folgendem Parse-Tree:

![](lecture/02-parsing/images/hello_ex2.png){width="60%"}

Wie man sehen kann, sind in der Grammatik die üblichen Vorrangregeln für die Operationen `+` und `*` berücksichtigt - die Multiplikation wird in beiden Fällen korrekt "unter" der Addition im Baum eingehängt.

##### To EOF not to EOF?

Startregeln müssen nicht unbedingt den gesamten Input "konsumieren". Sie müssen per Default nur eine der Alternativen in der Startregel erfüllen.

Betrachten wir noch einmal einen leicht modifizierten Ausschnitt aus der obigen Grammatik:

``` antlr
start : stmt ;
```

Die Startregel wurde so geändert, dass sie nur noch genau ein Statement akzeptieren soll.

In diesem Fall würde die Startregel bei der Eingabe "aa; bb;" nur den ersten Teil "aa;" konsumieren (als Token `ID`) und das folgende "bb;" ignorieren. Das wäre in diesem Fall aber auch kein Fehler.

Wenn der gesamte Eingabestrom durch die Startregel erklärt werden soll, dann muss das vordefinierte Token `EOF` am Ende der Startregel eingesetzt werden:

``` antlr
start : stmt EOF;
```

Hier würde die Eingabe "aa; bb;" zu einem Fehler führen, da nur der Teil "aa;" durch die Startregel abgedeckt ist (Token `ID`), und der Rest "bb;" zwar sogar ein gültiges Token wären (ebenfalls `ID` und `;`), aber eben nicht mehr von der Startregel akzeptiert. Durch das `EOF` soll die Startregel aber den gesamten Input konsumieren und erklären, was hier nicht geht und entsprechend zum Fehler führt.

(vgl. [github.com/antlr/antlr4/blob/master/doc/parser-rules.md](https://github.com/antlr/antlr4/blob/master/doc/parser-rules.md#start-rules-and-eof))
:::

#### Expressions und Vorrang (Operatoren)

::: notes
Betrachten wir noch einmal den Ausschnitt für die Ausdrücke (*Expressions*) in der obigen Beispielgrammatik:
:::

``` antlr
expr  : term ('+' term)* ;
term  : atom ('*' atom)* ;
atom  : ID ;
```

::: notes
Diese typische, etwas komplex anmutende Struktur soll sicher stellen, dass die Vorrangregeln für Addition und Multiplikation korrekt beachtet werden, d.h. dass `2+3*4` als `2+(3*4)` geparst wird und nicht fälschlicherweise als `(2+3)*4` erkannt wird.

Zusätzlich muss bei LL-Parsern Links-Rekursion vermieden werden: Die Parser-Regeln werden in Funktionsaufrufe übersetzt, d.h. bei einer Links-Rekursion würde man die selbe Regel immer wieder aufrufen, ohne ein Token aus dem Token-Strom zu entnehmen.

ANTLR (ab Version 4) kann mit beiden Aspekten automatisch umgehen:

- ANTLR kann direkte Linksrekursion automatisch auflösen. Die Regel `r : r T U | V ;` kann also in ANTLR verarbeitet werden.
- ANTLR besitzt einen Mechanismus zur Auflösung von Mehrdeutigkeiten. Wie oben geschrieben, wird bei der Anwendbarkeit von mehreren Alternativen die erste Alternative genutzt.

Damit lässt sich die typische Struktur für Expression-Grammatiken deutlich lesbarer gestalten:
:::

\pause
\bigskip

``` antlr
expr  : expr '*' expr
      | expr '+' expr
      | ID
      ;
```

::: notes
Die Regel `expr` ist links-rekursiv, was normalerweise bei LL-Parsern problematisch ist. ANTLR löst diese Links-Rekursion automatisch auf (vgl. [github.com/antlr/antlr4/blob/master/doc/left-recursion.md](https://github.com/antlr/antlr4/blob/master/doc/left-recursion.md)).

Da bei Mehrdeutigkeit in der Grammatik, also bei der Anwendbarkeit mehrerer Alternativen stets die erste Alternative genommen wird, lassen sich die Vorrangregeln durch die Reihenfolge der Alternativen in der `expr`-Regel implementieren: Die Multiplikation hat Vorrang von der Addition, und diese hat wiederum Vorrang von einer einfachen `ID`.
:::

::: notes
##### Direkte vs. indirekte Links-Rekursion

ANTLR kann nur *direkte* Links-Rekursion auflösen. Regeln wie `r : r T U | V ;` stellen in ANTLR also kein Problem dar.

*Indirekte* Links-Rekursion erkennt ANTLR dagegen nicht:

``` antlr
r : s T U | V ;
s : r W X ;
```

Hier würden sich die Regeln `r` und `s` gegenseitig aufrufen und kein Token aus dem Tokenstrom entfernen, so dass der generierte LL-Parser hier in einer Endlosschleife stecken bleiben würde. Mit indirekter Links-Rekursion kann ANTLR nicht umgehen.

##### Konflikte in Regeln

Wenn mehrere Alternativen einer Regel anwendbar sind, entscheidet sich ANTLR für die erste Alternative.

Wenn sich mehrere Tokenregeln überlappen, "gewinnt" auch hier die zuerst definierte Regel.

``` antlr
def : 'func' ID '(' ')' block ;

FOR : 'for' ;
ID  : [a-z][a-zA-Z]* ;
```

Hier werden ein implizites Token `'func'` sowie die expliziten Token `FOR` und `ID` definiert. Dabei sind die Lexeme für `'func'` und `FOR` auch in `ID` enthalten. Dennoch werden `'func'` und `FOR` erkannt und nicht über `ID` gematcht, weil sie *vor* der Regel `ID` definiert sind.

Tatsächlich sortiert ANTLR die Regeln intern um, so dass alle Parser-Regeln *vor* den Lexer-Regeln definiert sind. Die impliziten Token werden dabei noch vor den expliziten Token-Regeln angeordnet. Im obigen Beispiel hat also `'func'` eine höhere Priorität als `FOR`, und `FOR` hat eine höhere Priorität als `ID`. Aus diesem Grund gibt es die Konvention, die Parser-Regeln in der Grammatik vor den Lexer-Regeln zu definieren - dies entspricht quasi der Anordnung, die ANTLR bei der Verarbeitung sowieso erzeugen würde.

Aus diesem Grund würde auch eine Umsortierung der obigen Grammatik funktionieren:

``` antlr
FOR : 'for' ;
ID  : [a-z][a-zA-Z]* ;

def : 'func' ID '(' ')' block ;
```

Intern würde ANTLR die Parser-Regel `def` wieder vor den beiden Lexer-Regeln anordnen, und zwischen den Parser-Regeln und den Lexer-Regeln die impliziten Token (hier `'func'`).
:::

#### Kontext-Objekte für Parser-Regeln

``` antlr
s    : expr         {List<EContext> x = $expr.ctx.e();}
     ;
expr : e '*' e ;
```

\bigskip
\bigskip

![](lecture/02-parsing/images/ParserRuleContext.png){width="80%"}

::: notes
Jede Regel liefert ein passend zu dieser Regel generiertes Kontext-Objekt zurück. Darüber kann man das/die Kontextobjekt(e) der Sub-Regeln abfragen.

Die Regel `s` liefert entsprechend ein `SContext`-Objekt und die Regel `expr` liefert ein `ExprContext`-Objekt zurück.

In der Aktion fragt man das Kontextobjekt über `ctx` ab, in den Listener- und Visitor-Methoden erhält man die Kontextobjekte als Parameter.

Für einfache Regel-Aufrufe liefert die parameterlose Methode nur ein einziges Kontextobjekt (statt einer Liste) zurück.

**Anmerkung**: ANTLR generiert nur dann *Felder* für die Regel-Elemente im Kontextobjekt, wenn diese in irgendeiner Form referenziert werden. Dies kann beispielsweise durch Benennung (Definition eines Labels, siehe nächste Folie) oder durch Nutzung in einer Aktion (siehe obiges Beispiel) geschehen.
:::

#### Benannte Regel-Elemente oder Alternativen

``` antlr
stat  : 'return' value=e ';'    # Return
      | 'break' ';'             # Break
      ;
```

\bigskip

``` java
public static class StatContext extends ParserRuleContext { ... }
public static class ReturnContext extends StatContext {
    public EContext value;
    public EContext e() { ... }
}
public static class BreakContext extends StatContext { ... }
```

::: notes
Mit `value=e` wird der Aufruf der Regel `e` mit dem Label `value` belegt, d.h. man kann mit `$e.text` oder `$value.text` auf das `text`-Attribut von `e` zugreifen. Falls es in einer Produktion mehrere Aufrufe einer anderen Regel gibt, **muss** man für den Zugriff auf die Attribute eindeutige Label vergeben.

Analog wird für die beiden Alternativen je ein eigener Kontext erzeugt.
:::

#### Arbeiten mit ANTLR-Listeners

::: notes
ANTLR (generiert auf Wunsch) zur Grammatik passende Listener (Interface und leere Basisimplementierung). Beim Traversieren mit dem Default-`ParseTreeWalker` wird der Parse-Tree mit Tiefensuche abgelaufen und jeweils beim Eintritt in bzw. beim Austritt aus einen/m Knoten der passende Listener mit dem passenden Kontext-Objekt aufgerufen.

Damit kann man die Grammatik "für sich" halten, d.h. unabhängig von einer konkreten Zielsprache und die Aktionen über die Listener (oder Visitors, s.u.) ausführen.
:::

``` antlr
expr : e1=expr '*' e2=expr      # MULT
     | e1=expr '+' e2=expr      # ADD
     | DIGIT                    # ZAHL
     ;
```

\bigskip

::: notes
ANTLR kann zu dieser Grammatik `calc.g4` einen passenden Listener (Interface `calcListener`) generieren (Option `-listener` beim Aufruf von `antlr`). Weiterhin generiert ANTLR eine leere Basisimplementierung (Klasse `calcBaseListener`):

![](lecture/02-parsing/images/ParseTreeListener.png){width="80%"}

(Nur "interessante" Methoden gezeigt.)

Von dieser Basisklasse leitet man einen eigenen Listener ab und implementiert die Methoden, die man benötigt.
:::

``` java
public static class MyListener extends calcBaseListener {
    public void exitMULT(calcParser.MULTContext ctx) {
        ...
    }
    public void exitADD(calcParser.ADDContext ctx) {
        ...
    }
    public void exitZAHL(calcParser.ZAHLContext ctx) {
        ...
    }
}
```

::: notes
Anschließend baut man das alles in eine Traversierung des Parse-Trees ein:

``` java
public class TestMyListener {
    public static class MyListener extends calcBaseListener {
        ...
    }

    public static void main(String[] args) throws Exception {
        calcLexer lexer = new calcLexer(CharStreams.fromStream(System.in));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        calcParser parser = new calcParser(tokens);

        ParseTree tree = parser.s();    // Start-Regel

        ParseTreeWalker walker = new ParseTreeWalker();
        MyListener eval = new MyListener();
        walker.walk(eval, tree);
    }
}
```

[Beispiel: TestMyListener.java und calc.g4]{.ex href="https://github.com/Compiler-CampusMinden/CB-Vorlesung-Bachelor/blob/master/lecture/02-parsing/src/TestMyListener.java"}
:::

#### Arbeiten mit dem Visitor-Pattern

::: notes
ANTLR (generiert ebenfalls auf Wunsch) zur Grammatik passende Visitoren (Interface und leere Basisimplementierung).

Hier muss man im Gegensatz zu den Listeners allerdings selbst für eine geeignete Traversierung des Parse-Trees sorgen. Dafür hat man mehr Freiheiten im Vergleich zum Einsatz von Listeners, insbesondere im Hinblick auf Rückgabewerte.
:::

``` antlr
expr : e1=expr '*' e2=expr      # MULT
     | e1=expr '+' e2=expr      # ADD
     | DIGIT                    # ZAHL
     ;
```

\bigskip

::: notes
ANTLR kann zu dieser Grammatik einen passenden Visitor (Interface `calcVisitor<T>`) generieren (Option `-visitor` beim Aufruf von `antlr`). Weiterhin generiert ANTLR eine leere Basisimplementierung (Klasse `calcBaseVisitor<T>`):

![](lecture/02-parsing/images/ParseTreeVisitor.png){width="80%"}

(Nur "interessante" Methoden gezeigt.)

Von dieser Basisklasse leitet man einen eigenen Visitor ab und überschreibt die Methoden, die man benötigt. Wichtig ist, dass man selbst für das "Besuchen" der Kindknoten sorgen muss (rekursiver Aufruf der geerbten Methode `visit()`).
:::

``` java
public static class MyVisitor extends calcBaseVisitor<Integer> {
    public Integer visitMULT(calcParser.MULTContext ctx) {
        return ...
    }
    public Integer visitADD(calcParser.ADDContext ctx) {
        return ...
    }
    public Integer visitZAHL(calcParser.ZAHLContext ctx) {
        return ...
    }
}
```

::: notes
Anschließend baut man das alles in eine manuelle Traversierung des Parse-Trees ein:

``` java
public class TestMyVisitor {
    public static class MyVisitor extends calcBaseVisitor<Integer> {
        ...
    }

    public static void main(String[] args) throws Exception {
        calcLexer lexer = new calcLexer(CharStreams.fromStream(System.in));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        calcParser parser = new calcParser(tokens);

        ParseTree tree = parser.s();    // Start-Regel

        MyVisitor eval = new MyVisitor();
        eval.visit(tree);
    }
}
```

[Beispiel: TestMyVisitor.java und calc.g4]{.ex href="https://github.com/Compiler-CampusMinden/CB-Vorlesung-Bachelor/blob/master/lecture/02-parsing/src/TestMyVisitor.java"}
:::

::: notes
#### Eingebettete Aktionen und Attribute

``` antlr
s   : expr                      {System.err.println($expr.v);}
    ;

expr returns [int v]
    : e1=expr '*' e2=expr       {$v = $e1.v * $e2.v;}
    ;
```

Auch die Parser-Regeln können mit eingebetteten Aktionen ergänzt werden, die in die (für die jeweilige Regel) generierte Methode eingefügt werden und bei erfolgreicher Anwendung der Parser-Regel ausgeführt werden.

Über `returns [int v]` fügt man der Regel `expr` ein Attribut `v` (Integer) hinzu, welches man im jeweiligen Kontext abfragen bzw. setzen kann (agiert als Rückgabewert der generierten Methode). Auf diesen Wert kann in den Aktionen mit `$v` zugegriffen werden.

*Anmerkung*: Durch den Einsatz von eingebetteten Aktionen und Attributen wird die Grammatik abhängig von der Zielsprache des generierten Lexers/Parsers!
:::

::: notes
#### Ausblick

Damit haben wir die sprichwörtliche "Spitze des Eisbergs" gesehen. Mit ANTLR sind noch viele weitere Dinge möglich. Bitte nutzen Sie aktiv die Dokumentation auf [github.com/antlr/antlr4](https://github.com/antlr/antlr4).
:::

#### Wrap-Up {#wrap-up}

Parser mit ANTLR generieren: Parser-Regeln werden mit **Kleinbuchstaben** geschrieben

\bigskip

- Regeln können Lexer- und Parser-Regeln "aufrufen"
- Regeln können Alternativen haben
- Bei Mehrdeutigkeit: Vorrang für erste Alternative
- ANTLR erlaubt direkte Links-Rekursion
- ANTLR erzeugt Parse-Tree
- Benannte Alternativen und Regel-Elemente
- Traversierung des Parse-Tree: Listener oder Visitoren, Zugriff auf Kontextobjekte

::: readings
- @Parr2014
:::

::: outcomes
- k2: Aufbau der Parser-Regeln
- k3: Alternativen und optionale/mehrfache Regelteile in Parser-Regeln
- k3: Vorrang von Alternativen (bei Mehrdeutigkeiten)
- k3: Benannte Alternativen und Regel-Elemente
- k2: Aufbau des Parse-Tree
- k3: Umgang mit Kontext-Objekten
- k3: Traversierung des Parse-Tree mit den generierten Listenern oder Visitors
:::

::: challenges
**Lexer und Parser mit ANTLR: Programmiersprache Lox**

Betrachten Sie folgenden Code-Schnipsel in der Sprache ["Lox"](https://www.craftinginterpreters.com/the-lox-language.html):

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

Erstellen Sie für diese fiktive Sprache einen Lexer+Parser mit ANTLR. Implementieren Sie mit Hilfe des Parse-Trees und der Listener oder Visitoren einen einfachen Pretty-Printer.

(Die genauere Sprachdefinition finden Sie bei Bedarf unter [craftinginterpreters.com/the-lox-language.html](https://www.craftinginterpreters.com/the-lox-language.html).)
:::

## Test Markdown {#1ce401405b6a7b2f25ca3e5070a1e9ac1f0afc95}

Hier werden alle relevanten Markdown-Features getestet

### Test Markdown {#5ffe05b0cc6e0ec8341b3bea1c18f41cd3de0a4e}

::: tldr
Text für TL;DR ...

In @Parr2014 wird geschrieben, blablablabla ...

Wir können hier sowohl Inline-Math ($a^ib^{2*i}$) als auch Block-Math:

$$\Phi(\mathbf{g}_i) = F(\Gamma(\mathbf{g}_i)) - w\cdot\sum_j(Z_j(\Gamma(\mathbf{g}_i)))^2$$

Code sollte auch gehen: `inline`, aber auch block:

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

Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu vulputate nisl. Ut scelerisque magna eros, at semper lectus vulputate vitae. Nullam egestas tellus lorem, eget sodales mauris lacinia ut. Etiam a viverra ex. Nam eu nisl vel nisl cursus condimentum. Aliquam accumsan augue ut consequat viverra. Curabitur sagittis est mauris, at molestie arcu condimentum ut. Quisque efficitur porta maximus. Donec non leo est. Aenean interdum condimentum libero, ac cursus dolor condimentum in. Nullam lorem ex, iaculis a orci vitae, iaculis aliquam enim.

Quisque est lacus, pellentesque vitae fringilla vitae, bibendum sit amet dolor. Proin rutrum metus sit amet hendrerit lobortis. Fusce ut ultrices enim. Morbi a urna rutrum, fringilla augue mattis, mollis lacus. Pellentesque elementum vitae magna ac feugiat. Vestibulum et metus eget augue finibus fringilla ac at velit. Cras eleifend in nisl ac commodo. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse id mi nec diam pellentesque varius. Morbi in consequat neque, at bibendum purus. Quisque a est bibendum, pellentesque quam ac, fermentum diam. Cras augue nibh, tincidunt eu mollis at, hendrerit nec ex. Integer condimentum neque velit, eget aliquam justo iaculis ac.

Nam consequat vehicula faucibus. In consequat sed lacus sed congue. Ut quis risus vel erat tincidunt molestie. Nullam nibh lorem, placerat et dignissim porttitor, mollis eget nisl. Mauris eu justo nisi. Sed viverra, enim in tincidunt blandit, dui eros mattis nulla, in elementum neque ex sed diam. Aliquam nec neque vitae sapien pulvinar tempus. Donec gravida interdum nunc sed feugiat. Curabitur finibus sed urna at rutrum. Maecenas mollis pulvinar lobortis. Mauris dignissim orci ut metus eleifend, eget porttitor purus rhoncus. Phasellus volutpat egestas odio mollis pharetra. Cras sem dolor, commodo eu lectus vel, ultrices fringilla tellus. Fusce eleifend orci sed porttitor imperdiet. Phasellus suscipit, est ut semper blandit, ligula dui scelerisque felis, varius tincidunt tellus est vitae lectus. Phasellus eu molestie urna.

Sed sed leo vestibulum, iaculis justo in, aliquet mauris. Nunc luctus, metus quis vulputate lobortis, libero lacus imperdiet turpis, sit amet hendrerit magna nisi at leo. Pellentesque vehicula, mauris nec varius tempus, odio diam hendrerit mi, id porttitor ex felis ut sem. Vivamus tellus lacus, vehicula a augue non, aliquet aliquam quam. Donec dapibus quam sed ante blandit, in imperdiet enim dapibus. Etiam imperdiet sapien nec quam lobortis aliquet. Nam est eros, luctus consequat nulla ac, dapibus efficitur augue. Morbi tempor ex sed consectetur pharetra. Morbi ullamcorper ac enim nec accumsan. Nulla vestibulum eu turpis et rutrum.

Donec laoreet lectus at laoreet condimentum. Nulla porttitor elit iaculis turpis vestibulum, eget lobortis dolor pretium. Nulla sollicitudin convallis ultrices. Integer porttitor a nunc a viverra. Vestibulum pulvinar a urna et posuere. Duis sem nibh, consequat vitae ornare id, porttitor vel odio. Duis sit amet mi non odio accumsan condimentum sit amet non leo. Duis ut ligula ligula.

Phasellus sagittis non nisi eu ultricies. Donec quis ipsum at velit finibus mollis. Praesent facilisis blandit ligula. Pellentesque nec quam id neque lobortis egestas. Etiam nec risus feugiat, pulvinar mi in, vestibulum justo. Proin ac nisi scelerisque, bibendum tellus quis, lacinia leo. Vestibulum consequat fermentum est, eget cursus est efficitur ut. Fusce quis bibendum sapien. Vivamus vel nisl nulla. Nunc vehicula, odio ac ultricies iaculis, turpis turpis mollis dolor, et lobortis tortor ligula vel nisl. Nullam eget mi rutrum, suscipit felis at, dignissim justo. Praesent dapibus, arcu at luctus hendrerit, neque odio rhoncus lectus, vel semper lectus orci et ex. Etiam gravida, ex id hendrerit elementum, dolor urna lobortis quam, id commodo est erat eu purus. Nullam vitae diam id dui luctus imperdiet et eget est. Nam tincidunt elit nisl, id varius purus condimentum ut.

Nullam pharetra metus eu felis elementum suscipit. Quisque ultricies ultrices tellus, vitae volutpat diam suscipit vitae. Phasellus vel ornare erat, ut malesuada neque. Suspendisse ac justo sit amet urna tincidunt efficitur a sit amet nisi. Vivamus varius dolor lacinia, sodales dolor id, molestie diam. Duis mi eros, vestibulum sed odio quis, maximus ultricies nunc. Cras dapibus scelerisque arcu at consequat. Maecenas mattis mauris id luctus ultrices.

In mollis, ligula ac dignissim porttitor, enim erat vulputate leo, in interdum sapien lorem vitae metus. Sed condimentum id massa quis venenatis. Nam vitae lobortis libero, sed porttitor mauris. Morbi volutpat quis metus sit amet egestas. In in tortor non justo luctus pretium. Quisque rutrum neque lacus, sit amet hendrerit erat dignissim eu. Aenean justo dui, suscipit in mauris quis, mattis fringilla ligula. Fusce ac nibh dictum, iaculis augue id, sollicitudin mi. Pellentesque commodo, orci ac commodo congue, libero nunc hendrerit est, a maximus metus sem sed arcu. Maecenas venenatis sodales purus, eu interdum nunc dignissim nec. Cras aliquam ligula a sollicitudin hendrerit.

Suspendisse fringilla pretium risus, quis pharetra lacus laoreet quis. Nulla ultrices eros odio, id tincidunt lacus lobortis sed. In suscipit lacus vel risus cursus commodo vel nec nulla. Sed a sapien fringilla, commodo mi quis, luctus erat. Nam suscipit quam et nisl dictum, ut condimentum tortor tempor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Suspendisse cursus, lacus sed sodales tincidunt, tellus ex blandit libero, quis tincidunt lectus leo eget magna. Donec sodales sodales ex vel sodales. Vestibulum pellentesque tellus vitae mauris gravida blandit. Pellentesque dignissim sem id lacus vulputate, sit amet laoreet ex tempor.

Morbi dictum dapibus diam in vulputate. Nam sed magna fringilla, congue purus in, tincidunt ante. Vestibulum quis ultricies neque. Cras nec dui id augue laoreet tempus at sit amet sem. Quisque mauris sem, ullamcorper a scelerisque sit amet, rhoncus nec risus. Donec malesuada, mauris a bibendum gravida, erat lectus ornare metus, quis iaculis erat tellus in turpis. Suspendisse nulla enim, mattis id fringilla sed, venenatis scelerisque lorem. Integer eget ex velit. Duis blandit risus mauris, eget iaculis velit eleifend a. Fusce volutpat justo sit amet tempus vulputate. Vivamus ac leo tempor, dapibus justo aliquam, mollis mi. Aenean pellentesque ipsum at quam dictum rutrum. Aliquam maximus commodo augue, ac egestas elit lobortis quis. Morbi vel ex ac sapien tincidunt aliquet. Donec pharetra ac felis non placerat. Integer fermentum vel velit sed auctor.
:::

::: youtube
- [VL Parser mit ANTLR (YouTube)](https://youtu.be/YuUHBvPUS4k)
- [Demo ANTLR Parser (YouTube)](https://youtu.be/FJOEPY-TMmw)
- <https://foo.bar.de>
- [VL Git Basics (HSBI Medienportal)](https://www.hsbi.de/medienportal/m/3a44c8a32e7699db77ae922c6b8944acf0d8c65b78d02859e707ffdf783ea45a78200312cdb8102c1052f382101b69a5092bcaf0a11ded36b98f4552a4aca345)
:::

::: attachments
- [Folien (raw link)](https://raw.githubusercontent.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/master/lecture/nn/files/NN03-Logistische_Regression.pdf)
- [Folien](https://github.com/cagix/test-pandoc-lecture/blob/_pdf/lecture_03-test_test.pdf)
:::

<p align="center">

[**GH-Preview**](https://github.com/cagix/test-pandoc-lecture/blob/_gfm/readme.md)

</p>

#### Hello World {#hello-world}

Hier ist normaler Markdown-Text, mit **fett** und auch *kursiv*.

- Stichpunkt 1
- Stichpunkt 2
- Stichpunkt 3

1.  Aufzählung 1
2.  Aufzählung 2
3.  Aufzählung 3
    1.  Unterpunkt 3.1
    2.  Unterpunkt 3.2

Hier die ==Pandoc-Markdown== mark-Erweiterung.

#### Math

##### Inline

$\mathbf{g} = (g_1, \dots, g_m)\in \{ 0,1\}^m$

- $a^ib^{2*i}$ ist nicht regulär
- $a^ib^{2*i}$ für $0 \leq i \leq 3$ ist regulär

##### Block

$$\Phi(\mathbf{g}_i) = F(\Gamma(\mathbf{g}_i)) - w\cdot\sum_j(Z_j(\Gamma(\mathbf{g}_i)))^2$$

$$p_{sel}(\mathbf{g}_k) = \frac{\Phi(\mathbf{g}_k)}{\sum_j \Phi(\mathbf{g}_j)}$$

$$g_i^{(t+1)} = \left\{
\begin{array}{ll}
    \neg g_i^{(t)} & \mbox{ falls } \chi_i \le p_{mut}\\[5pt]
    \phantom{\neg} g_i^{(t)} & \mbox{ sonst }
\end{array}
\right.$$

------------------------------------------------------------------------

##### Known Problems

- VSCode Preview: `\mbox{ tanh }` =\> $\mbox{ tanh }$ =\> `\text{ tanh }` =\> $\text{ tanh }$
- GH Preview:
  - `\phantom{xyz}` =\> $\phantom{xyz}$ =\> ?? =\> ??
  - `\operatorname{tanh}` =\> $\operatorname{tanh}$ =\> `\mathop{\text{tanh}}` =\> $\mathop{\text{tanh}}$

$$g_i^{(t+1)} = \left\{
\begin{array}{rll}
    \neg & g_i^{(t)} & \text{ falls } \chi_i \le p_{mut}\\[5pt]
    & g_i^{(t)} & \text{ sonst }
\end{array}
\right.$$

==Schwierig==: In Pandoc-Markdown muss Mathe mit `$` oder `$$` eingeschlossen werden, unabhängig vom konkreten Inhalt. In LaTeX ist aber `\begin{eqnarray}` bereits der Beginn einer Mathe-Umgebung, d.h. hier wären extra `$$` ==falsch==. Das muss per Filter korrigiert werden!

    $$\begin{eqnarray}
    S &\rightarrow& a A                      \nonumber \\
    A &\rightarrow& d B \ | \ b A \ | \ c A  \nonumber \\
    B &\rightarrow& a c \ | \ b C \ | \ c A  \nonumber \\
    C &\rightarrow& \epsilon                 \nonumber
    \end{eqnarray}$$

should become

$$\begin{eqnarray}
S &\rightarrow& a A                      \nonumber \\
A &\rightarrow& d B \ | \ b A \ | \ c A  \nonumber \\
B &\rightarrow& a c \ | \ b C \ | \ c A  \nonumber \\
C &\rightarrow& \epsilon                 \nonumber
\end{eqnarray}$$

##### Tests

###### Inline Math

`array` as inline math:

$\begin{array}{rll}
    \neg & g_i^{(t)} & \text{ falls } \chi_i \le p_{mut}\\[5pt]
    & g_i^{(t)} & \text{ sonst }
\end{array}$

\bigskip

`eqnarray` as inline math:

$\begin{eqnarray}
S &\rightarrow& a A                      \nonumber \\
A &\rightarrow& d B \ | \ b A \ | \ c A  \nonumber \\
B &\rightarrow& a c \ | \ b C \ | \ c A  \nonumber \\
C &\rightarrow& \epsilon                 \nonumber
\end{eqnarray}$

###### Block Math

`array` as block math:

$$\begin{array}{rll}
    \neg & g_i^{(t)} & \text{ falls } \chi_i \le p_{mut}\\[5pt]
    & g_i^{(t)} & \text{ sonst }
\end{array}$$

\bigskip

`eqnarray` as block math:

$$\begin{eqnarray}
S &\rightarrow& a A                      \nonumber \\
A &\rightarrow& d B \ | \ b A \ | \ c A  \nonumber \\
B &\rightarrow& a c \ | \ b C \ | \ c A  \nonumber \\
C &\rightarrow& \epsilon                 \nonumber
\end{eqnarray}$$

###### Newline after `$$`

`array` as block math w/ newline:

$$
  \begin{array}{rll}
    \neg & g_i^{(t)} & \text{ falls } \chi_i \le p_{mut}\\[5pt]
    & g_i^{(t)} & \text{ sonst }
  \end{array}
$$

\bigskip

`eqnarray` as block math w/ newline:

$$
\begin{eqnarray}
S &\rightarrow& a A                      \nonumber \\
A &\rightarrow& d B \ | \ b A \ | \ c A  \nonumber \\
B &\rightarrow& a c \ | \ b C \ | \ c A  \nonumber \\
C &\rightarrow& \epsilon                 \nonumber
\end{eqnarray}
$$

#### Links

##### Link to WWW

[craftinginterpreters.com/the-lox-language.html](https://www.craftinginterpreters.com/the-lox-language.html)

##### Internal Links

[selbe ebene: readme.md](#009a0a5753af2814b794a9fbf07d27bafe95c56b)

[unterordner: subfolder/foo.md](#21012d4cdd914d7b9c455c770e117de0d4bb6b18)

[zurück nach oben I: ../02-parsing/antlr-parsing.md](#6cf46704b72b833be34e815ad028ca9585eca248)

[zurück nach oben II: ../../homework/sheet01.md](#6f673c2e093cdfc53b1f78baef11fd06cc8aa415)

#### Code

``` antlr
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

------------------------------------------------------------------------

Java-Code kompilieren: `javac *.java`

``` {#lst:huh .java caption="The preprocessing step, cf. [@Dietz2018]"}
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

public class Main {
    public static void main(String[] args) throws Exception {
        HelloLexer lexer = new HelloLexer(CharStreams.fromStream(System.in));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        HelloParser parser = new HelloParser(tokens);

        ParseTree tree = parser.start();  // Start-Regel
        System.out.println(tree.toStringTree(parser));
    }
}
```

------------------------------------------------------------------------

Code ohne alles

    import org.antlr.v4.runtime.CharStreams;
    import org.antlr.v4.runtime.CommonTokenStream;
    import org.antlr.v4.runtime.tree.ParseTree;

    public class Main {
        public static void main(String[] args) throws Exception {
            HelloLexer lexer = new HelloLexer(CharStreams.fromStream(System.in));
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            HelloParser parser = new HelloParser(tokens);

            ParseTree tree = parser.start();  // Start-Regel
            System.out.println(tree.toStringTree(parser));
        }
    }

#### Images

Figures (w/ caption) should be centered like in LaTeX. Inline images will appear as is (also like in LaTeX).

##### Images with Caption

kleines Bild, keine Breiteangabe:

!["B" (small)](lecture/03-test/img/b.png)

------------------------------------------------------------------------

Bild in Elternordner, keine Breiteangabe:

![parsing error](lecture/02-parsing/images/bc_xml-parsing-error.png)

![modulbeschreibung](admin/images/modulbeschreibung_ba.png)

<!--
![kaputt](../../../lalune.jpg)
-->

------------------------------------------------------------------------

kleines Bild, mit Titel und Breite:

!["B", width="5%"](lecture/03-test/img/b.png "foobarwuppiefluppie"){width="5%"}

------------------------------------------------------------------------

breites Bild, keine Breiteangabe:

!["wuppie" (wide)](lecture/03-test/img/wuppie.png)

------------------------------------------------------------------------

breites Bild, mit Breiteangabe:

!["wuppie", width="20%"](lecture/03-test/img/wuppie.png){width="20%"}

------------------------------------------------------------------------

breites Bild über HTTP, keine Breiteangabe:

!["wuppie" via web (raw)](https://raw.githubusercontent.com/cagix/pandoc-thesis/refs/heads/master/figs/wuppie.png)

------------------------------------------------------------------------

breites Bild über HTTP mit `credits`-Span, keine Breiteangabe:

!["wuppie" via web (raw) (["FooFOOOO" by me on void.intern.com]{.credits})](https://raw.githubusercontent.com/cagix/pandoc-thesis/refs/heads/master/figs/wuppie.png)

["Foo" by me on void.extern.com]{.credits}

##### Images w/o Caption

ohne alles:

![](lecture/03-test/img/b.png)

------------------------------------------------------------------------

mit breitenangabe:

![](lecture/03-test/img/b.png){width="5%"}

------------------------------------------------------------------------

mit breitenangabe ("width") und titel:

![](lecture/03-test/img/b.png "title: wuppie"){width="5%"}

------------------------------------------------------------------------

mit breitenangabe ("web_width") und titel:

![](lecture/03-test/img/b.png "title: wuppie"){web_width="10%"}

------------------------------------------------------------------------

mit breitenangabe ("width" und "web_width") und titel:

![](lecture/03-test/img/b.png "title: wuppie"){width="5%" web_width="10%"}

##### Images w/ `img`-Code

using "5%":

`<img src="img/b.png" width="5%">`{=html}

<img src="img/b.png" width="5%">

using "80px":

`<img src="img/b.png" width="80px">`{=html}

<img src="img/b.png" width="80px">

mit div drumherum:

<div style="width: 5%;">

![](lecture/03-test/img/b.png)

</div>

##### Known Problems

- In VSC preview as well as in LaTeX images via web like https://github.com/cagix/pandoc-thesis/blob/master/figs/wuppie.png do not work (**need to be "raw"**)

------------------------------------------------------------------------

##### Images from Web (LaTeX backend)

When converting to LaTeX (PDF, Beamer), Pandoc will attempt to download the referred images. However, recently a lot of sites deny this. It seems we need to set an user-agent.

![](https://upload.wikimedia.org/wikipedia/commons/e/e4/Turing_Test_version_3.png){width="40%" web_width="20%"}

[[Turing Test version 3.png](https://commons.wikimedia.org/wiki/File:Turing_Test_version_3.png) by [Bilby](https://commons.wikimedia.org/wiki/User:Bilby) on Wikimedia Commons ([Public Domain](https://en.wikipedia.org/wiki/en:public_domain))]{.credits}

The conversion above will fail with

    Could not convert image /tmp/tex2pdf.-c72add2811a5b622/3d299b2a35aa76ba2acfef6d4887a64d6ea8e601.txt: Cannot load file
      Jpeg Invalid marker used
      PNG Invalid PNG file, signature broken
      Bitmap Invalid Bitmap magic identifier
      GIF Invalid Gif signature : Please
      HDR Invalid radiance file signature
      Tiff Invalid endian tag value
      TGA not enough bytes
    Error producing PDF.
    ! LaTeX Error: Unknown graphics extension: .txt.

    See the LaTeX manual or LaTeX Companion for explanation.
    Type  H <return>  for immediate help.
     ...

    l.1089 ...b2a35aa76ba2acfef6d4887a64d6ea8e601.txt}

unless there is a user-agent defined like

``` yaml
request-headers:
  - ["User-Agent", "Mozilla/5.0"]
```

**Note**: This is only needed, when Pandoc attempts to download the image locally, i.e. when converting to LaTeX based formats like PDF or Beamer. No need to set this for web based formats like GFM or Markdown since we just leave the link as it is.

(see https://github.com/cagix/pandoc-lecture-zen/issues/57) (see https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/issues/455)

#### Tabellen

mit caption:

    Rechtsbündig Linksbündig   Default    Zentriert
  -------------- ------------- --------- -----------
             foo foo           foo           foo
             123 123           123           123
             bar bar           bar           bar

  : Tabelle als Markdown-Pipe-Table, vgl. [@SICP]

------------------------------------------------------------------------

ohne caption:

    Rechtsbündig Linksbündig   Default    Zentriert
  -------------- ------------- --------- -----------
             foo foo           foo           foo
             123 123           123           123
             bar bar           bar           bar

#### Zitieren, Quellen

Normales Zitieren [@Siek2023racket] ...

Mit Seitenangabe [@Siek2023racket, Seite 111] oder Kapitel [@Siek2023racket, Kapitel 111] ...

Als Author-Zitat @Siek2023racket ...

#### GFM

##### Darkmode vs. Lightmode

Diese Abbildung liegt in drei Varianten im Repo vor: transparenter Hintergrund, light, dark. Die Einbindung ist auf "transparent". Scale ist auf 60%. Die Abbildung sollte sich automatisch umstellen.

![](lecture/03-test/img/dimensionen-ki.png){width="60%"}

![Hier könnte ihre Werbung stehen.](lecture/03-test/img/dimensionen-ki.png){width="40%"}

Nachfolgend die "light"-Variante direkt:

![](lecture/03-test/img/dimensionen-ki_light.png){width="60%"}

Nachfolgend die "dark"-Variante direkt:

![](lecture/03-test/img/dimensionen-ki_dark.png){width="60%"}

Nachfolgend eine Abbildung, die es nicht in light/dark im Repo gibt. Wie verhält sich die Preview, so lange nicht beim Übersetzen die light- und dark-Varianten mit generiert werden?

![](lecture/03-test/img/test_transparentbackground.png){width="40%"}

Und noch einmal, diesmal mit Caption.

![Hier könnte ihre Werbung stehen.](lecture/03-test/img/test_transparentbackground.png){width="40%"}

##### Details

<details>
<summary>
Zusammenfassung: NIX :)
</summary>

Lalelu ...

</details>

##### Alert Extension

GH introduced "alerts" with distinctive styling, like

> \[!NOTE\] Foo bar, wuppie fluppie!

> \[!TIP\] Foo bar, wuppie fluppie!

> \[!IMPORTANT\] Foo bar, wuppie fluppie!

> \[!WARNING\] Foo bar, wuppie fluppie!

> \[!CAUTION\] Foo bar, wuppie fluppie!

(see https://github.blog/changelog/2023-12-14-new-markdown-extension-alerts-provide-distinctive-styling-for-significant-content/)

------------------------------------------------------------------------

Let's stick with Pandocs divs in Markdown content and use filters for export:

::: note
Foo bar, wuppie fluppie! Blablabla third line of nonsense ...
:::

::: tip
Foo bar, wuppie fluppie!
:::

::: important
Foo bar, wuppie fluppie!
:::

::: warning
Foo bar, wuppie fluppie!
:::

::: caution
Foo bar, wuppie fluppie!
:::

- Export to GH Markdown using ["distinctive alerts"](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts)
- Export to Hugo using [notice shortcode](https://mcshelby.github.io/hugo-theme-relearn/shortcodes/notice/index.html)
- Export to Beamer using [beamercolorbox](https://tex.stackexchange.com/questions/411069/creating-beamer-box-environment) (also [beameruserguide.pdf](https://tug.ctan.org/macros/latex/contrib/beamer/doc/beameruserguide.pdf); or `block`, `alertblock`, `examples` - cf. https://www.overleaf.com/learn/latex/Beamer%23Creating_a_table_of_contents)

This should probably be in line with #180 ...

##### GH Shenanigans

The GitHub Markdown parser has a really weird bug: as soon as there's inline math in a bullet point, any display math after that won't render properly in the whole bullet list.

###### Example

- Bullet point 1

- Bullet point 2 with block math (w/o blank line) $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

- Bullet point 3 with block math and blank line

  $$\mathcal{L} = (\hat{y} - y)^2 = (h(\mathbf{x}) - y)^2$$

- Bullet point 4 with inline math ($x_i$) and block math and blank line

  $$\mathcal{L} = (\hat{y} - y)^2 = (h(\mathbf{x}) - y)^2$$

- Bullet point 5 with image

  ![](lecture/03-test/img/b.png)

- Bullet point 6 with figure

  ![image caption](lecture/03-test/img/b.png)

- Bullet point 7 with code block

  ``` antlr
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

  foo bar wuppie fluppie - text below code block in bullet point 6

- simple bullet point

###### Tests

Using `bulletlist_displaymath.lua` to remove display math from bullet points.

This filter is intended as a quick-and-dirty workaround. If a display math element occurs in a bullet point, it is removed from the bullet point. The bullet list obtained so far is terminated, the display math element is inserted at the same AST level as the bullet list, and a new bullet list is started for the remaining bullet points.

For reasons that are not entirely clear, empty pandoc.Para elements are sometimes inserted into the bullet points. These are immediately removed again here in the filter.

Note: If a bullet point contains text followed by display math followed by text, the resulting order after the filter is no longer correct: First, the complete bullet point is emitted, followed by the display math.

``` markdown
-   wuppie $x_i$ fluppie:
    $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$
-   foo bar

compare with

-   wuppie fluppie:
    $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$
-   foo bar

compare with

-   wuppie $x_i$ fluppie:

$$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

-   foo bar

compare with

-   wuppie $x_i$ fluppie:
    $h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$
-   foo bar

compare with

*   wuppie $x_i$ fluppie $w_0$:
    *   bla bla bla

    *   blub $x$ blub blub

        $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

    *   brabbel brabbel brabbel

    *   blafasel $y$

        $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

        blubfasel $z$

*   foobar

compare with

1.  wuppie $x_i$ fluppie $w_0$:

    $$h(\mathbf{x}^1) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

    *   bla bla bla

    *   blub $x$ blub blub

        $$h(\mathbf{x}^2) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

    *   brabbel brabbel brabbel

    *   blafasel $y$

        $$h(\mathbf{x}^3) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

        blubfasel $z$

2.  foobar
```

**will be rendered as**

- wuppie $x_i$ fluppie: $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$
- foo bar

compare with

- wuppie fluppie: $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$
- foo bar

compare with

- wuppie $x_i$ fluppie:

$$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

- foo bar

compare with

- wuppie $x_i$ fluppie: $h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$
- foo bar

compare with

- wuppie $x_i$ fluppie $w_0$:
  - bla bla bla

  - blub $x$ blub blub

    $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

  - brabbel brabbel brabbel

  - blafasel $y$

    $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

    blubfasel $z$
- foobar

compare with

1.  wuppie $x_i$ fluppie $w_0$:

    $$h(\mathbf{x}^1) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

    - bla bla bla

    - blub $x$ blub blub

      $$h(\mathbf{x}^2) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

    - brabbel brabbel brabbel

    - blafasel $y$

      $$h(\mathbf{x}^3) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

      blubfasel $z$

2.  foobar

###### Test Case nn02-linear-regression.md

[nn02-linear-regression.md](#3eeb5ef519e0106480d1e04eea752d5105192e22)

#### Filter for Slides and Handouts

::: notes
Foo bar, wuppie fluppie! (NOTES)
:::

::: slides
THIS IS SLIDE-ONLY CONTENT, STUPID!
:::

#### Footnotes

Sometimes[^1] we need some[^2] footnotes.

##### Test for Docsify

~~Docsify seems to recognize footnotes even in inline code:~~

  **Zeichenkette**   **Beschreibt**
  ------------------ ----------------------------------------------------------
  `^`                Zeilenanfang
  `[abc]`            "a" oder "b" oder "c"
  `[^abc]`           alles außer "a", "b" oder "c" (Negation)
  `^abc`             test
  `[ ^abc]`          test
  `[ ^abc]`          test
  `[^ abc]`          test
  `[a-zA-Z]`         alle Zeichen von "a" bis "z" und "A" bis "Z" (Range)
  `[a-z&&[def]]`     "d","e" oder "f" (Schnitt)
  `[a-z&&[^bc]]`     "a" bis "z", außer "b" und "c": `[ad-z]` (Subtraktion)
  `[a-z&&[^m-p]]`    "a" bis "z", außer "m" bis "p": `[a-lq-z]` (Subtraktion)

``` java
^               // Zeilenanfang
[abc]           // "a" oder "b" oder "c"
[^abc]          // alles außer "a", "b" oder "c" (Negation)
^abc            // test
[ ^abc]         // test
[ ^abc]         // test
[^ abc]         // test
[a-zA-Z]        // alle Zeichen von "a" bis "z" und "A" bis "Z" (Range)
[a-z&&[def]]    // "d","e" oder "f" (Schnitt)
[a-z&&[^bc]]    // "a" bis "z", außer "b" und "c": `[ad-z]` (Subtraktion)
[a-z&&[^m-p]]   // "a" bis "z", außer "m" bis "p": `[a-lq-z]` (Subtraktion)
```

#### Handling of TeX Shenanigans

**Zustand:**

:   (Formale) Beschreibung eines Zustandes der Welt

**Aktion:**

:   (Formale) Beschreibung einer durch Agenten ausführbaren Aktion

    - Anwendbar auf bestimmte Zustände
    - Überführt Welt in neuen Zustand ("Nachfolge-Zustand")

LaTeX-Befehle wie `\bigskip` etc. sollten automatisch entfernt werden:

\bigskip
\bigskip

Hier nach den LaTeX-Befehlen.

**Geeignete Abstraktionen wählen für Zustände und Aktionen!**

#### Pandoc Shenanigans

Pandoc sometimes transforms whitespace into UTF8 whitespace, which results in pdftex yelling at me, when this appears in lstlistings.

Example:

``` markdown
cf. https://www.overleaf.com/learn/latex/Beamer%23Creating_a_table_of_contents
```

normal white space: cf. https://www.overleaf.com/learn/latex/Beamer%23Creating_a_table_of_contents

pandoc replacement: cf. https://www.overleaf.com/learn/latex/Beamer%23Creating_a_table_of_contents

Also ... hmmm. And "wuppie"?

#### Columns

blablabla

::::: columns
::: {.column width="50%"}
Zum Parsen von Ausdrücken (*Expressions*) könnte man diese einfache Grammatik einsetzen. Ein Ausdruck ist dabei entweder ein einfacher Integer oder eine Addition oder Multiplikation zweier Ausdrücke.

``` yacc
expr : e1=expr '*' e2=expr      # MUL
     | e1=expr '+' e2=expr      # ADD
     | INT                      # NUM
     ;
```
:::

::: {.column width="40%"}
Beim Parsen von "5\*4+3" würde dabei der folgende Parsetree entstehen:

![](lecture/03-test/img/b.png){width="50%" web_width="20%"}
:::
:::::

wuppie! fluppie! foo? bar ...

#### Credits

Typische Regeln und Konventionen tauchen überall auf, beispielsweise bei Tim Pope (siehe nächstes Beispiel) oder bei ["How to Write a Git Commit Message"](https://cbea.ms/git-commit/).

``` markdown
Short (50 chars or less) summary of changes

More detailed explanatory text, if necessary.  Wrap it to about
72 characters or so.  In some contexts, the first line is treated
as the subject of an email and the rest of the text as the body.
The blank line separating the summary from the body is critical
(unless you omit the body entirely); tools like rebase can get
confused if you run the two together.

Further paragraphs come after blank lines.

 - Bullet points are okay, too
 - Typically a hyphen or asterisk is used for the bullet, preceded
   by a single space, with blank lines in between, but conventions
   vary here
```

[["A Note About Git Commit Messages"](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) by [Tim Pope](https://tpo.pe/) on tbaggery.com]{.credits}

------------------------------------------------------------------------

Use `[bla]{.credits nolist=true}` to put a nicely formatted reference to the original sources in the text without adding it to the list of exceptions to our licence (just giving credits):

[Test 1: Eigenes Material basierend auf einer Idee nach XYZ.]{.credits nolist="true"}

Note: Using the attribute "nolist" with any value would prevent this span from being included in the exceptions list since values will be read as string in the filter. So even `[bla]{.credits nolist=false}` will work:

[Test 2: Eigenes Material basierend auf einer Idee nach XYZ.]{.credits nolist="false"}

[Test 3: Eigenes Material basierend auf einer Idee nach XYZ.]{.credits nolist="false"}

[Test 4: Eigenes Material basierend auf einer Idee nach XYZ.]{.credits nolist="0"}

[Test 5: Eigenes Material basierend auf einer Idee nach XYZ.]{.credits nolist="1"}

Do not use the old `origin` span anymore - superceded by `credits`. [This should emit a warning...]{.origin}

#### Filters

##### ShowMe

Hier ein ShowMe-Test:

::: showme
this is hidden content ...
:::

(but not used anymore)

Use `details` instead:

::: details
this is hidden content ...
:::

::: {.details title="wuppie"}
this is a show-me w/ title :)
:::

------------------------------------------------------------------------

##### CBOX

::: cbox
this is content to be centered (and put into a box)...
:::

(but not used anymore)

##### Center

::: center
this content should be centered
:::

##### Alert

This [will]{.alert} be highlighted. (but not used anymore)

Use [Pandoc's mark extension](https://pandoc.org/MANUAL.html#extension-mark) instead: This ==will== be highlighted. Even ==**with bold**== text.

------------------------------------------------------------------------

##### Hinweis

[This is a hint.]{.hinweis} (but not used anymore)

##### Thema

[The topic of this task or ...]{.thema} (but not used anymore)

##### BSP

Lalalelu

[Simple Beispiel-Button X]{.bsp} (but not used anymore)

lalelu

use `ex` instead:

[Simple Beispiel-Button X]{.ex}

[Beispiel-Button w/ link]{.ex href="https://github.com/sdiehl/write-you-a-haskell/blob/master/README.md"}

------------------------------------------------------------------------

Vor `\pause`...

\pause

Nach `\pause`... ("neue" Slide)

#### Last Change

should be added automatically and in `\scriptsize` or `<sup><sub>`

::: readings
- @Tate2011 [Kapitel 2]: foo bar wuppie fluppie
- @Tate2011 [Kapitel 2]: Creating Graphical User Interfaces \> Creating a GUI With Swing
- @Nystrom2021: Abschnitt 2.5.2: Ant
- [@Nystrom2021]: Abschnitt 2.5.2: Ant
:::

::: outcomes
- k1: K1
- k2: K2
- k3: K3.1
- k3: K3.2
:::

::: quizzes
- [Quiz Git Basics (ILIAS)](https://www.hsbi.de/elearning/goto.php?target=tst_1106241&client_id=FH-Bielefeld)
:::

::: challenges
**Lexer und Parser mit ANTLR: Programmiersprache Lox**

Betrachten Sie folgenden Code-Schnipsel in der Sprache ["Lox"](https://www.craftinginterpreters.com/the-lox-language.html):

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

Erstellen Sie für diese fiktive Sprache einen Lexer+Parser mit ANTLR. Implementieren Sie mit Hilfe des Parse-Trees und der Listener oder Visitoren einen einfachen Pretty-Printer.

(Die genauere Sprachdefinition finden Sie bei Bedarf unter [craftinginterpreters.com/the-lox-language.html](https://www.craftinginterpreters.com/the-lox-language.html).)

**Test for Pandoc Filter**

This should appear only in GFM/Docsify/PDF, but NOT in Beamer (i.e. not in license statement!).

[test from yaml (challenges) - should not appear in slides]{.credits}
:::

### NN02 - Lineare Regression und Gradientenabstieg {#3eeb5ef519e0106480d1e04eea752d5105192e22}

::: youtube
- [NN2.1 - Lineare Regression - Intro](https://youtu.be/f-DTaKMnkj4)
- [NN2.2 - Vergleich Perzeptron und Bsp](https://youtu.be/UnLjjMswNRo)
- [NN2.3 - Kostenfunktiıon und Gradientenvektor](https://youtu.be/H2YvYIaUW1Q)
- [NN2.4 - Berechnung Gradientenvektor - Beispiel](https://youtu.be/URaVsZnfppQ)
- [NN2.5 - Berechnung Gradientenvektor - Allgemein](https://youtu.be/5OZF3Qopous)
- [NN2.6 - Skalierung der Merkmale](https://youtu.be/m-TnM13I-no)
:::

::: attachments
- [NN02-Lineare_Regression.pdf](https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/blob/master/lecture/nn/files/NN02-Lineare_Regression.pdf)
:::

#### Kurze Übersicht

##### Formalisierung (original)

- Ausgabe $y$ ist reelle Zahl aus einem stetigen Bereich (zum Beispiel Hauspreis)
- Die **Hypothesenfunktion** ist eine gewichtete Summe der Merkmale $x_i$ plus eine Konstante $w_0$: $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$
- Der **Verlust** (engl. loss) für einen Datenpunkt $\mathbf{x}$ ist das **Fehlerquadrat**: $$\mathcal{L} = (\hat{y} - y)^2 = (h(\mathbf{x}) - y)^2$$
- Die Kosten (engl. cost) sind der durchschnittliche Verlust über alle Datenpunkte: $$J = \frac{1}{2m} \sum_{i=1}^{m} (\hat{y} - y)^2 = \frac{1}{2m} \sum_{i=1}^{m} (h(\mathbf{x}) - y)^2$$

##### Formalisierung (ohne inline math)

- Ausgabe y ist reelle Zahl aus einem stetigen Bereich (zum Beispiel Hauspreis)
- Die **Hypothesenfunktion** ist eine gewichtete Summe der Merkmale x_i plus eine Konstante w_0: $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$
- Der **Verlust** (engl. loss) für einen Datenpunkt x ist das **Fehlerquadrat**: $$\mathcal{L} = (\hat{y} - y)^2 = (h(\mathbf{x}) - y)^2$$
- Die Kosten (engl. cost) sind der durchschnittliche Verlust über alle Datenpunkte: $$J = \frac{1}{2m} \sum_{i=1}^{m} (\hat{y} - y)^2 = \frac{1}{2m} \sum_{i=1}^{m} (h(\mathbf{x}) - y)^2$$

##### Formalisierung (mit inline math, block math ausgerückt)

- Ausgabe y ist reelle Zahl aus einem stetigen Bereich (zum Beispiel Hauspreis)

- Die **Hypothesenfunktion** ist eine gewichtete Summe der Merkmale x_i plus eine Konstante w_0:

$$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

- Der **Verlust** (engl. loss) für einen Datenpunkt x ist das **Fehlerquadrat**:

$$\mathcal{L} = (\hat{y} - y)^2 = (h(\mathbf{x}) - y)^2$$

- Die Kosten (engl. cost) sind der durchschnittliche Verlust über alle Datenpunkte:

$$J = \frac{1}{2m} \sum_{i=1}^{m} (\hat{y} - y)^2 = \frac{1}{2m} \sum_{i=1}^{m} (h(\mathbf{x}) - y)^2$$

##### Der Gradient

- Der **Gradientenvektor** $\nabla J(\mathbf{w})$ setzt sich zusammen aus den partiellen Ableitungen der Kostenfunktion $J$ nach den Gewichten $w_i$ und zeigt in jedem Punkt $\mathbf{w}$ in die **Richtung des steilsten Aufstiegs**: $$\nabla J = [ \partial J / \partial w_0
  \quad \partial J / \partial w_1 \quad \ldots
  \quad \partial J / \partial w_n]^T$$
- **Schlussfolgerung**: In die entgegengesetzte Richtung, i.e. in Richtung $-\nabla J(\mathbf{w})$ geht es am *steilsten bergab!*
- **IDEE**: Bewege $\mathbf{w}$ in Richtung $-\nabla J(\mathbf{w})$, um die Kosten $J$ möglichst schnell zu senken.

##### Der Gradientenabstieg (engl. Gradient Descent)

1.  Starte mit zufälligen Gewichten $\mathbf{w}$
2.  Berechne den Gradientenvektor im aktuellen Punkt $\mathbf{w}$
3.  **Gewichtsaktualisierung**: Gehe einen *kleinen* Schritt in Richtung $-\nabla J(\mathbf{w})$ $$\mathbf{w} _{neu} := \mathbf{w} _{alt} - \alpha \cdot \nabla J(\mathbf{w} _{alt})$$ ($\alpha$: Lernrate/Schrittweite).
4.  Wiederhole Schritte 2-3, bis das globale Minimum von $J$ erreicht ist.

::: outcomes
- k2: Lineare Regression aus Sicht neuronaler Netze: Graphische Darstellung, Vergleich mit Perzeptron
- k2: Formalisierung
- k2: Verlust- und Kostenfunktion
- k2: Gradientenvektor
- k2: Lernrate
- k3: Gradientenabstieg
:::

::: quizzes
- [Selbsttest Lineare Regression (ILIAS)](https://www.hsbi.de/elearning/goto.php?target=tst_1106590&client_id=FH-Bielefeld)
:::

::: challenges
**Skalierung der Merkmale**

Abbildung 1 und Abbildung 2 zeigen die [Höhenlinien](https://de.wikipedia.org/wiki/H%C3%B6henlinie) ([Contour Lines](https://en.wikipedia.org/wiki/Contour_line)) von zwei Kostenfunktionen.

![Abbildung 1](https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/blob/master/lecture/nn/images/contour_plot_a.png?raw=true){width="40%"} ![Abbildung 2](https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/blob/master/lecture/nn/images/contour_plot_b.png?raw=true){width="40%"}

- Erklären Sie, welcher der beiden Fälle nachteilhaft für den Gradientenabstieg Algorithmus ist. Wo liegt der Nachteil? Wie kann die Merkmalskalierung dem genannten Nachteil entgegenwirken?
- Zeigen Sie unter Verwendung Ihrer eigenen, zufällig generierten Datenpunkte aus dem Bereich $[100, 300] \times [0, 2]$, wie sich Standardisierung, Min-Max Skalierung und Normalisierung auf die Daten auswirken. Vergleichen Sie dazu die jeweiligen Streudiagramme (scatterplots). Sie können hierzu das folgende [**Jupyter Notebook**](https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/blob/master/lecture/nn/files/Feature_Scaling_Starter.ipynb) als Startpunkt benutzen.
:::

### subfolder {#1b69551948844ea83b35c3b22e545c5a7e410e29}

#### Single page 'Foo' in a leaf bundle {#21012d4cdd914d7b9c455c770e117de0d4bb6b18}

::: attachments
- [NN1-Das_Perzeptron.pdf](#56f23cadaf8472e7e33ca0bd1f0fc9c8fe74a298)
- [Annotierte Folien: LR-Parser1](https://github.com/Compiler-CampusMinden/AnnotatedSlides/blob/master/lr-parser1.ann.ma.pdf)
- [Annotierte Folien: LR-Parser1 (RAW)](https://raw.githubusercontent.com/Compiler-CampusMinden/AnnotatedSlides/master/lr-parser1.ann.ma.pdf)
:::

##### Lecture/03-Test/Subfolder/Foo.md

This is a "single page" in a "leaf bundle" and should **not** be available.

# Praktikum {#a264d337dcfeece8936f208b6f89bb1efe99ea0f}

Hier finden Sie die Übungsblätter.

## Blatt 04: Semantische Analyse {#6dc682255c67debc1eebb45a3920a1731f87be41}

<!--  pandoc -s -f markdown -t markdown+smart-grid_tables-multiline_tables-simple_tables --columns=94 --reference-links=true  sheet04.md  -o xxx.md  -->

### Zusammenfassung

Ziel dieses Aufgabenblattes ist die Erstellung einer Symboltabelle und eines einfachen Type-Checkers für eine fiktive statisch typisierte Sprache mit Expressions, Kontrollstrukturen und Funktionen.

### Methodik

Sie finden im [Sample Project](https://github.com/Compiler-CampusMinden/CB-Vorlesung-Bachelor/tree/master/homework/src/sample_project) eine [Grammatik](https://github.com/Compiler-CampusMinden/CB-Vorlesung-Bachelor/blob/master/homework/src/sample_project/src/main/antlr/MiniC.g4), die (teilweise) zu der Zielsprache auf diesem Blatt passt. Analysieren Sie diese Grammatik und vervollständigen Sie diese bzw. passen Sie diese an.

Erstellen Sie mit dieser Grammatik und ANTLR wieder einen Lexer und Parser. Definieren Sie einen AST und konvertieren Sie Ihren Parse-Tree in einen AST.

Es ist empfehlenswert, den Type-Checker dreiphasig zu realisieren:

1.  Aufbauen der Symboltabelle und Prüfen von z.B. Deklaration/Definition vs. Benutzung (Variablen) usw.
2.  Prüfen bei Funktionsaufrufen auf vorhandene/sichtbare Funktionsdefinitionen
3.  Prüfen der verwendeten Typen

### Sprachdefinition

Ein Programm besteht aus einer oder mehreren Anweisungen (*Statements*).

#### Anweisungen (*Statements*)

Eine Anweisung ist eine Befehlsfolge, beispielsweise eine Deklaration (Funktionen), Definition (Variablen, Funktionen), Zuweisung, ein Funktionsaufruf oder eine Operation. Sie muss immer mit einem Semikolon abgeschlossen werden. Eine Anweisung hat keinen Wert.

``` python
int a;           # Definition der Integer-Variablen a
int b = 10 - 5;  # Definition der Integer-Variablen b und Zuweisung des Ausdruckes 10-5 (Integer-Wert 5)
c = "foo";       # Zuweisung des Ausdrucks "foo" (String) an die Variable c (diese muss dazu vorher definiert und sichtbar sein)
func1(a, c);     # Funktionsaufruf mit Variablen a und c
```

Kontrollstrukturen und Code-Blöcke sowie `return`-Statements zählen ebenfalls als Anweisung.

#### Code-Blöcke und Scopes

Code-Blöcke werden in geschweifte Klammern eingeschlossen und enthalten eine beliebige Anzahl von Anweisungen.

Jeder Code-Block bildet einen eigenen Scope - alle Deklarationen/Definition in diesem Scope sind im äußeren Scope nicht sichtbar. Im Scope kann auf die Symbole des/der umgebenden Scopes zugegriffen werden. Symbole in einem Scope können gleichnamige Symbole im äußeren Scope verdecken.

``` python
# globaler Scope
int a = 7;
int d;
{   # erster innerer Scope
    int b = 7;      # b ist nur in diesem und im zweiten inneren Scope sichtbar
    foo(a);         # Funktionsaufruf mit der Variable a aus dem äußeren Scope (Wert 7)
    int a = 42;     # Variable verdeckt das a aus dem äußeren Scope
    foo(a);         # Funktionsaufruf mit der Variable a aus dem aktuellen Scope (Wert 42)
    {   # zweiter innerer Scope
        int c = 9;  # dieses c ist nur hier sichtbar
        foo(d);     # d wird im äußeren Scope gesucht, dort nicht gefunden und im nächsthöheren Scope gesucht (rekursiv)
    }
}
{   # dritter innerer Scope
    int b;          # dieses b hat mit dem b aus dem ersten inneren Scope nichts zu tun
    foo(a);         # Funktionsaufruf mit der Variable a aus dem äußeren Scope (Wert 7)
}
```

#### Ausdrücke (*Expressions*)

Die einfachsten Ausdrücke sind Integer- oder String-Literale. Variablen und Funktionsaufrufe sind ebenfalls Ausdrücke. Komplexere Ausdrücke werden mit Hilfe von Operationen gebildet, dabei sind die Operanden jeweils auch wieder Ausdrücke.

Ein Ausdruck hat immer einen Wert und einen Typ.

Die Operatoren besitzen eine Rangfolge, um verschachtelte Operationen aufzulösen. Sie dürfen daher nicht einfach von links nach rechts aufgelöst werden. Die Rangfolge der Operatoren entspricht der üblichen Semantik (vgl. Java, C, Python).

Es gibt in unserer Sprache folgende Operationen mit der üblichen Semantik:

##### Vergleichsoperatoren

  Operation       Operator
  -------------- ----------
  Gleichheit        `==`
  Ungleichheit      `!=`
  Größer            `>`
  Kleiner           `<`

Die Operanden müssen jeweils beide den selben Typ haben. Dabei sind `string` und `int` zulässig. Das Ergebnis ist immer vom Typ `bool`.

##### Arithmetische Operatoren

  Operation                               Operator
  -------------------------------------- ----------
  Addition / String-Literal-Verkettung      `+`
  Subtraktion                               `-`
  Multiplikation                            `*`
  Division                                  `/`

Die Operanden müssen jeweils beide den selben Typ haben. Für `+` sind `string` und `int` zulässig, für die anderen Operatoren (`-`, `*`, `/`) nur `int`. Das Ergebnis ist vom Typ der Operanden.

##### Beispiele für Ausdrücke

``` python
10 - 5       # Der Integer-Wert 5
"foo"        # Der String "foo"
a            # Wert der Variablen a (Zugriff auf a)
a + b        # Ergebnis der Addition der Variablen a und b
func1(a, b)  # Ergebnis des Funktionsaufrufs
```

Ausdrücke werden nicht mit einem Semikolon abgeschlossen. Sie sind also Teil einer Anweisung.

#### Bezeichner

Werden zur Bezeichnung von Variablen und Funktionsnamen verwendet. Sie bestehen aus einer Zeichenkette der Zeichen `a-z`,`A-Z`, `0-9`. Bezeichner dürfen nicht mit einer Ziffer `0-9` beginnen.

#### Variablen

Variablen bestehen aus einem eindeutigen Bezeichner (Variablennamen). Den Variablen können Werte zugewiesen werden und Variablen können als Werte verwendet werden. Die Zuweisung erfolgt mithilfe des `=`-Operators. Auf der rechten Seite der Zuweisung können auch Ausdrücke stehen.

``` python
int a;         # Definition der Variablen a (Typ: Integer)
int a = 7;     # Definition und Initialisierung einer Variablen
a = 5;         # Zuweisung des Wertes 5 an die Variable a
a = 2 + 3;     # Zuweisung des Wertes 5 an die Variable a
```

Variablen müssen vor ihrer Benutzung (Zugriff, Zuweisung) definiert und im aktuellen Scope sichtbar sein. Die Initialisierung kann zusammen mit der Definition erfolgen.

Variablen können in einem Scope nicht mehrfach definiert werden.

``` python
int a = 42;

{
    a = 7;  # zulässig - a ist hier sichtbar, Zugriff auf globalen Scope
    b = 9;  # unzulässig - b ist nicht definiert

    int a;  # zulässig - erste Definition in diesem Scope
    int a;  # unzulässig - a ist in diesem Scope bereits definiert
}
```

#### Kommentare

Kommentare werden durch das Zeichen `#` eingeleitet und umfassen sämtliche Zeichen bis zum nächsten Newline.

#### Kontrollstrukturen

##### While-Schleife

While-Schleifen werden mit dem Schlüsselwort `while` eingeleitet. Sie bestehen im Weiteren aus einer Bedingung in runden Klammern und einem in geschweiften Klammern formulierten Code-Block.

Die Bedingung besteht aus einem Vergleichsausdruck.

``` c
while (<Bedingung>) {
    <Anweisung_1>
    <Anweisung_2>
}
```

``` c
int a = 10;

while (a > 0) {
    a = a - 1;
}
```

##### Bedingte Anweisung (If-Else)

Eine bedingte Anweisung besteht immer aus genau einer `if`-Anweisung, und einer oder keiner `else`-Anweisung.

Eine `if`-Anweisung wird mit dem Schlüsselwort `if` eingeleitet und besteht aus einer Bedingung in runden Klammern und einem in geschweiften Klammern formulierten Code-Block.

Die Bedingung besteht aus einem Vergleichsausdruck.

Eine `else`-Anweisung wird mit dem Schlüsselwort `else` eingeleitet. Auf das Schlüsselwort folgt in geschweiften Klammern formulierter Code-Block.

``` c
if (<Bedingung>) {
    <Anweisung_1>
    <Anweisung_2>
}
```

``` c
if (<Bedingung>) {
    <Anweisung>
} else {
    <Anweisung>
}
```

``` c
int a = 42;

if (a > 0) {
    a = a - 1;
    if (a > 0) {
        a = a - 1;
    }
} else {
    a = a + 1;
}
```

#### Funktionen

##### Funktionsdefinition

Eine Funktionsdefinition macht dem Compiler die Implementierung einer Funktion bekannt.

Sie gibt zunächst die Signatur der Funktion (den "Funktionskopf") bekannt: Rückgabetyp, Funktionsname, Parameterliste.

Die Parameterliste ist eine Komma-separierte Liste mit der Deklaration der Parameter (jeweils Typ und Variablenname). Die Parameterliste kann auch leer sein.

Nach dem Funktionskopf folgt der Körper der Funktion als Code-Block.

Funktionen können in einem Scope nicht mehrfach definiert werden.

``` c
type bezeichner(type param1, type param2) {
    <Anweisung_1>
    <Anweisung_2>
    return <Bezeichner, Wert oder Operation>;
}
```

``` c
bool func1(int a, string b) {
    int c = a + f2(b);
    return c == 42;
}
```

##### Funktionsaufrufe

Funktionsaufrufe bestehen aus einem Bezeichner (Funktionsname) gefolgt von einer in Klammern angegebenen Liste der Argumente, die auch leer sein kann. Als Argumente können alle passend typisierten Ausdrücke dienen.

``` python
func1(5, var1)
func1(func2(), 1 + 1)
```

Die aufgerufene Funktion muss im aktuellen Scope sichtbar sein, der Funktionsaufruf muss zur Definition passen.

Die aufgerufene Funktion muss (im Gegensatz zum Zugriff auf Variablen) nicht vor dem ersten Aufruf definiert sein. Folgender Code ist also zulässig:

``` python
int a = 42;
if (a == 42) {
    foo(5);    # zulässig: foo ist erst nach diesem Aufruf definiert, aber in diesem Scope sichtbar
}

int foo(int a) {
    return a + 37;
}
```

#### Datentypen

Unsere Sprache hat drei eingebaute Datentypen:

  Datentyp   Definition der Literale
  ---------- ---------------------------------------------------------------
  `int`      eine beliebige Folge der Ziffern `0-9`
  `string`   eine beliebige Folge von ASCII-Zeichen, eingeschlossen in `"`
  `bool`     eines der beiden Schlüsselwörter `T` oder `F`

#### Beispiele

``` c
string a = "wuppie fluppie";
```

``` c
int a = 0;
if (10 < 1) {
    a = 42;
} else {
    foo();
}
```

``` c
int f95(int n) {
    if (n == 0) {
        return 1;
    } else {
        if (n == 1) {
            return 1;
        } else {
            return f95(n - 1) + f95(n - 2) + f95(n - 3) + f95(n - 4) + f95(n - 5);
        }
    }
}

int n = 10;
f95(n);
```

### Aufgaben

#### Grammatik und AST (2P)

Erstellen Sie eine ANTLR-Grammatik für die Zielsprache. Sie können dabei die [Grammatik](https://github.com/Compiler-CampusMinden/CB-Vorlesung-Bachelor/blob/master/homework/src/sample_project/src/main/antlr/MiniC.g4) im [Sample Project](https://github.com/Compiler-CampusMinden/CB-Vorlesung-Bachelor/tree/master/homework/src/sample_project) als Ausgangspunkt nutzen und diese anpassen und vervollständigen.

Definieren Sie einen AST für die Zielsprache. Welche Informationen aus dem Eingabeprogramm müssen repräsentiert werden?

Programmieren Sie eine Traversierung des Parse-Trees, die den AST erzeugt. Testen Sie dies mit den obigen Beispielprogrammen und definieren Sie sich selbst weitere Programme unterschiedlicher Komplexität für diesen Zweck.

#### Aufbau der Symboltabelle (2P)

Bauen Sie für den AST eine Symboltabelle auf. Führen Sie dabei die im ersten Lauf möglichen Prüfungen durch, beispielsweise ob referenzierte Variablen tatsächlich bereits definiert und sichtbar sind oder ob eine Variable oder Funktion in einem Scope mehrfach definiert wird oder ob Variablen als Funktion genutzt werden. Geben Sie erkannte Fehler auf der Konsole aus.

#### Symboltabelle: Funktionsaufrufe (1P)

Implementieren Sie einen zweiten Lauf. Dabei soll für Funktionsaufrufe geprüft werden, ob diese Funktionen bereits definiert sind und im Scope sichtbar sind. Geben Sie erkannte Fehler auf der Konsole aus.

#### Symboltabelle: Typprüfungen (5P)

Implementieren Sie einen dritten Lauf. Führen Sie die Typprüfung durch: Haben die Operanden in Ausdrücken die richtigen Typen, passen die Typen der Funktionsargumente, passen die Typen bei einer Zuweisung, ... Geben Sie erkannte Fehler auf der Konsole aus. *Hinweis*: Sie brauchen hier nur die Typprüfung durchführen. Eine Typinferenz oder Typerweiterung o.ä. ist nicht notwendig.

## Blatt 01: Reguläre Sprachen {#6f673c2e093cdfc53b1f78baef11fd06cc8aa415}

<!--  pandoc -s -f markdown -t markdown+smart-grid_tables-multiline_tables-simple_tables --columns=94 --reference-links=true  sheet01.md  -o xxx.md  -->

### Sprachen von regulären Ausdrücken (1P)

Welche Sprache wird von dem folgenden regulären Ausdruck beschrieben?

$a\ +\ a\ (a\ +\ b)^*\ a$

### Bezeichner in Programmiersprachen (3P)

Betrachten Sie eine Programmiersprache, in der die Bezeichner (= Namen für Variablen, Funktionen, Klassen, Methoden, ...) folgenden Aufbau haben:

- Alle Variablennamen beginnen mit **V** oder **v**
- Handelt es sich um globale Variablen, beginnen Sie mit **V**, lokale beginnen mit **v**
- Funktions- und Methodenparameter beginnen mit **p**, KLassenparameter (bei der Definition von Vererbung) beginnen mit **P**
- Weitere Bezeichner müssen mit einem Buchstaben (a-z, A-Z) beginnen
- Die folgenden Zeichen dürfen Buchstaben, Ziffern und ein Untersreich sein
- Bezeichner dürfen nicht mit einem Unterstrich enden
- Alle Bezeichner müssen aus mindestens zwei Zeichen bestehen

Entwickeln Sie einen regulären Ausdruck, der den Aufbau der Bezeichner beschreibt. Beachten Sie, dass Ihr regex alle zulässigen Bezeichner beschreiben muss, aber keinen einzigen unzulässigen beschreiben darf. Wählen Sie zwei Bezeichner aus der Sprache und zeigen Sie, wie sie vom regex gematcht werden.

Entwickeln Sie einen DFA, der diese Bezeichner akzeptiert. Beachten Sie, dass Ihr DFA alle zulässigen Bezeichner akzeptieren muss, aber keinen einzigen unzulässigen akzeptieren darf. Wählen Sie zwei Bezeichner aus der Sprache und zeigen Sie, wie sie vom Automaten zeichenweise gelesen und akzeptiert werden.

Entwickeln Sie eine reguläre Grammatik, die diese Bezeichner generiert. Beachten Sie, dass Ihre Grammatik alle zulässigen Bezeichner generieren können muss, aber keinen einzigen unzulässigen generieren darf. Wählen Sie zwei Bezeichner aus der Sprache und zeigen Sie die Ableitungsbäume dazu.

### Gleitkommazahlen in Programmiersprachen (2P)

Recherchieren Sie zunächst den Aufbau von Gleitkommazahlen in Python und Java.

Erstellen Sie für jede der beiden Programmiersprachen reguläre Ausdrücke, DFAs und reguläre Grammatiken wie in Aufgabe 1. Verifizieren Sie Ihre Lösungen wie in Aufgabe

1.

### Mailadressen? (1P)

Warum ist der folgende regex ungeeignet für die Verarbeitung von Mailadressen?

$(a-z)^+@(a-z).(a-z)$

Bitte beachten Sie, dass die Schreibweise a-z nicht unserer Definition genügt. Eigentlich müsste jedes Zeichen aufgeführt werden:

$a + b + c + c + \ldots + z$ ist besser, aber immer noch nicht richtig. Warum?

Anmerkung: Diese Darstellung wird ab jetzt akzeptiert.

Verbessern Sie den gegebenen regulären Ausdruck.

### Der zweitletzte Buchstabe (1P)

Entwickeln Sie einen DFA, der nur Wörter über $\Sigma = \lbrace 1,2,3 \rbrace$ akzeptiert, deren zweitletztes Zeichen dasselbe ist wie das zweite.

### Sprache einer regulären Grammatik (2P)

Welche Sprache generiert die folgende Grammatik?

$$\begin{eqnarray}
S &\rightarrow& a A                      \nonumber \\
A &\rightarrow& d B \ | \ b A \ | \ c A  \nonumber \\
B &\rightarrow& a c \ | \ b C \ | \ c A  \nonumber \\
C &\rightarrow& \epsilon                 \nonumber
\end{eqnarray}$$

## Blatt 02: CFG {#0db349230022c35e045dc3b052a4faea50fe5f40}

<!--  pandoc -s -f markdown -t markdown+smart-grid_tables-multiline_tables-simple_tables --columns=94 --reference-links=true  sheet02.md  -o xxx.md  -->

### PDA (2P)

Erstellen Sie einen deterministischen PDA, der die Sprache

$$L = \lbrace w \in \lbrace a, b, c \rbrace^* \; | \; w \; \text{hat doppelt so viele a's wie c's} \rbrace$$

akzeptiert.

Beschreiben Sie Schritt für Schritt, wie der PDA die Eingaben *bcaba* und *bccac* abarbeitet.

### Akzeptierte Sprache (1P)

Ist der folgenden PDA deterministisch? Warum (nicht)?

$q_4$ sei der akzeptierende Zustand.

$$\begin{eqnarray}
\delta(q_0,a, \perp) &=& (q_0, A\perp)           \nonumber \\
\delta(q_0,a, A) &=& (q_0, AA)                   \nonumber \\
\delta(q_0,b, A) &=& (q_1, BA)                   \nonumber \\
\delta(q_1,b, B) &=& (q_1, BB)                   \nonumber \\
\delta(q_1,c, B) &=& (q_2, \epsilon)             \nonumber \\
\delta(q_2,c, B) &=& (q_2, \epsilon)             \nonumber \\
\delta(q_2,d, A) &=& (q_3, \epsilon)             \nonumber \\
\delta(q_3,d, A) &=& (q_3, \epsilon)             \nonumber \\
\delta(q_3,d, A) &=& (q_3, AA)                   \nonumber \\
\delta(q_3,\epsilon, \perp) &=& (q_4, \epsilon)  \nonumber
\end{eqnarray}$$

Zeichnen Sie den Automaten. Geben Sie das 7-Tupel des PDa an. Welche Sprache akzeptiert er?

### Kontextfreie Sprache (1P)

Welche Sprache generiert die folgende kontextfreie (Teil-) Grammatik?

$$G = (\lbrace \text{Statement}, \text{Condition}, \ldots \rbrace, \lbrace \text{"if"}, \text{"else"}, \ldots \rbrace, P, \text{Statement})$$

mit

$$\begin{eqnarray}
P = \lbrace &&                                                                                                           \nonumber \\
&\text{Statement}& \rightarrow \text{"if" Condition Statement} \; | \; \text{"if" Condition Statement "else" Statement}  \nonumber \\
&\text{Condition}& \rightarrow \ldots                                                                                    \nonumber \\
\rbrace                                                                                                                  \nonumber
\end{eqnarray}$$

Ist die Grammatik mehrdeutig? Warum (nicht)?

### Kontextfreie Grammatik (2P)

Entwickeln Sie eine kontextfreie Grammatik für die Sprache

$$L = \lbrace a^ib^jc^k \; | \; i = j \lor j = k \rbrace$$

Zeigen Sie, dass die Grammatik mehrdeutig ist. Entwickeln Sie einen PDA für diese Sprache.

### Kontextfreie Grammatik (4P)

Betrachten sie die folgende Grammatik:

$$G = (\lbrace S, A \rbrace, \lbrace 1, 2, 3 \rbrace, P, S)$$

mit

$$\begin{eqnarray}
P = \lbrace &&                        \nonumber \\
&S& \rightarrow 1AS \; | \; 3         \nonumber \\
&A& \rightarrow 2AS \; | \; \epsilon  \nonumber \\
\rbrace                               \nonumber
\end{eqnarray}$$

Berechnen die die *First-* und *Follow-Mengen* der Grammatik.

Zeigen Sie, dass die Grammatik LL(1) ist.

Konstruieren Sie die LL-Parsertabelle für die Grammatik und simulieren Sie das Parsen des Wortes *1233*.

## Blatt 03: ANTLR {#0caafae8610423845a8dd05fc7941ec5d42fbae3}

<!--  pandoc -s -f markdown -t markdown+smart-grid_tables-multiline_tables-simple_tables --columns=94 --reference-links=true  sheet03.md  -o xxx.md  -->

### Zusammenfassung {#zusammenfassung}

Ziel dieses Aufgabenblattes ist die Erstellung eines einfachen *Pretty Printers* für eine einfache fiktive Sprache mit Expressions und Kontrollstrukturen.

Dazu werden Sie eine passende kontextfreie Grammatik definieren mit Lexer- und Parser-Regeln und dabei auch übliche Vorrangregeln beachten.

Für diese Grammatik erstellen Sie mit Hilfe von ANTLR einen Lexer und einen Parser, die zu einem Eingabeprogramm einen Parse-Tree erzeugen.

Den im Parse-Tree repräsentierten Code des Eingabeprogramms können Sie mit Hilfe einer Traversierung konsistent eingerückt wieder auf der Standardausgabe ausgeben - das ist der *Pretty Printer*.

Sie werden merken, dass viele Strukturen im Parse-Tree für diese Aufgabe nicht relevant sind und den Baum mit einer weiteren Traversierung in einen vereinfachten Baum, den sogenannten Abstract-Syntex-Tree (*AST*), transformieren und diesen erneut als formatierten Code auf der Konsole ausgeben.

### Methodik {#methodik}

Nutzen Sie das [Starter-Projekt](https://github.com/Compiler-CampusMinden/CB-Vorlesung-Bachelor/tree/master/homework/src/sample_project) in der Vorgabe.

Laden Sie sich das Projekt herunter, binden Sie es in Ihre IDE ein und vergewissern Sie sich, dass alles funktioniert: Führen Sie das enthaltene Programm aus, ändern Sie die mitgelieferten Beispielgrammatik.

Bauen Sie dann Ihre Grammatik für die Aufgabe schrittweise auf. Testen Sie diese mit Hilfe der Beispielprogramme der Zielsprache (s.u.) und überlegen Sie sich selbst weitere Code-Schnipsel, die Sie mit Ihrem Parser einlesen bzw. die Ihr Parser zurückweisen sollte.[^3] Es empfiehlt sich, in dieser Phase mit dem [ANTLR-Plugin für IntelliJ](https://plugins.jetbrains.com/plugin/7358-antlr-v4) zu arbeiten.

Erkunden Sie dann die Strukturen Ihres Parse-Trees. Diese sind an die Regeln Ihrer Grammatik gekoppelt und sind deshalb so individuell wie Ihre Grammatik. Mit einer Traversierung des Baumes können Sie die gewünschte Ausgabe programmieren und auch die Erstellung des vereinfachten Baumes (AST).

### Sprachdefinition {#sprachdefinition}

Ein Programm besteht aus einer oder mehreren Anweisungen (*Statements*).

#### Anweisungen (*Statements*) {#anweisungen-statements}

Eine Anweisung ist eine einzeilige Befehlsfolge, beispielsweise eine Zuweisung oder eine Operation. Sie muss immer mit einem Newline abgeschlossen werden. Eine Anweisung hat keinen Wert.

``` python
a := 10 - 5  # Zuweisung des Ausdruckes 10-5 (Integer-Wert 5) an die Variable a
b := "foo"   # Zuweisung des Ausdrucks "foo" (String) an die Variable b
```

Kontrollstrukturen (s.u.) zählen ebenfalls als Anweisungen.

#### Ausdrücke (*Expressions*) {#ausdrücke-expressions}

Die einfachsten Ausdrücke sind Integer- oder String-Literale. Variablen sind ebenfalls Ausdrücke. Komplexere Ausdrücke werden mit Hilfe von Operationen gebildet, dabei sind die Operanden jeweils auch wieder Ausdrücke. Ein Ausdruck hat/ergibt immer einen Wert.

Die Operatoren besitzen eine Rangfolge, um verschachtelte Operationen aufzulösen. Sie dürfen daher nicht einfach von links nach rechts aufgelöst werden. Die Rangfolge der Operatoren entspricht der üblichen Semantik (vgl. Java, C, Python).

Es gibt in unserer Sprache folgende Operationen mit der üblichen Semantik:

##### Vergleichsoperatoren {#vergleichsoperatoren}

  Operation       Operator
  -------------- ----------
  Gleichheit        `==`
  Ungleichheit      `!=`
  Größer            `>`
  Kleiner           `<`

##### Arithmetische Operatoren {#arithmetische-operatoren}

  Operation                               Operator
  -------------------------------------- ----------
  Addition / String-Literal-Verkettung      `+`
  Subtraktion                               `-`
  Multiplikation                            `*`
  Division                                  `/`

##### Beispiele für Ausdrücke {#beispiele-für-ausdrücke}

``` python
10 - 5  # Der Integer-Wert 5
"foo"   # Der String "foo"
a       # Wert der Variablen a
a + b   # Ergebnis der Addition der Variablen a und b
```

#### Bezeichner {#bezeichner}

Werden zur Bezeichnung von Variablen verwendet. Sie bestehen aus einer Zeichenkette der Zeichen `a-z`,`A-Z`, `0-9`, `_`. Bezeichner dürfen nicht mit einer Ziffer `0-9` beginnen.

#### Variablen {#variablen}

Variablen bestehen aus einem eindeutigen Bezeichner (Variablennamen). Den Variablen können Werte zugewiesen werden und Variablen können als Werte verwendet werden. Die Zuweisung erfolgt mithilfe des `:=`-Operators. Auf der rechten Seite der Zuweisung können auch Ausdrücke stehen.

``` python
a := 5      # Zuweisung des Wertes 5 an die Variable a
a := 2 + 3  # Zuweisung des Wertes 5 an die Variable a
```

#### Kommentare {#kommentare}

Kommentare werden durch das Zeichen `#` eingeleitet und umfassen sämtliche Zeichen bis zum nächsten Newline.

#### Kontrollstrukturen {#kontrollstrukturen}

##### While-Schleife {#while-schleife}

While-Schleifen werden mit dem Schlüsselwort `while` eingeleitet. Sie bestehen im Weiteren aus einer Bedingung, die durch ein `do` abgeschlossen wird, einer Folge von Anweisungen und werden mit dem Schlüsselwort `end` abgeschlossen.

Die Bedingung kann aus einem Vergleichsausdruck bestehen.

``` python
while <Bedingung> do
    <Anweisung_1>
    <Anweisung_2>
end
```

``` python
a := 10
b := 0
while a >= 0 do
    a := a - 1
    b := b + 9
end
```

##### Bedingte Anweisung (If-Else) {#bedingte-anweisung-if-else}

Eine bedingte Anweisung besteht immer aus genau einer `if`-Anweisung, gefolgt von einer Bedingung, die mit einem `do` abgeschlossen wird und einer Folge von Anweisungen.

Danach wird die bedingte Anweisung entweder mit dem Schlüsselwort `end` abgeschlossen oder es folgt genau ein `else`-Teil.

Ein `else`-Teil wird mit dem Schlüsselwort `else` eingeleitet. Darauf folgt ein `do` und eine Folge von Anweisungen. Der `else`-Teil wird mit dem Schlüsselwort `end` abgeschlossen.

``` python
if <Bedingung> do
    <Anweisung_1>
    <Anweisung_2>
end
```

``` python
if <Bedingung> do
    <Anweisung>
else do
    <Anweisung>
end
```

``` python
a := "abc"
if a < "abc" do
    a := "wuppie"
else do
    a := "nope"
end
```

#### Datentypen {#datentypen}

Unsere Sprache hat zwei eingebaute Datentypen, für die entsprechende Literale erkannt werden müssen:

  Datentyp   Definition der Literale
  ---------- ---------------------------------------------------------------
  `int`      eine beliebige Folge der Ziffern `0-9`
  `string`   eine beliebige Folge von ASCII-Zeichen, eingeschlossen in `"`

Die Sprache ist dynamisch typisiert, d.h. beim Parsen werden Ihnen keine Typ-Angaben im Code begegnen. Aber Sie müssen die entsprechenden Werte (Literale) parsen können.

#### Beispiele {#beispiele}

``` python
a := "wuppie fluppie"
```

``` python
a := 0
if 10 < 1 do
    a := 42
else do
    a := 7
end
```

### Aufgaben {#aufgaben}

#### Grammatik (4P)

Definieren Sie für die obige Sprache eine geeignete ANTLR-Grammatik.

Sie werden sowohl Lexer- als auch (rekursive) Parser-Regeln benötigen. Beachten Sie die üblichen Vorrangregeln für die Operatoren, orientieren Sie sich hier an Sprachen wie Java oder Python oder C.

#### Pretty Printer (3P)

Erzeugen Sie mithilfe der Grammatik und ANTLR einen Lexer und Parser. Damit können Sie syntaktisch korrekte Eingabe-Programme in einen Parse-Tree überführen.

Programmieren Sie eine Traversierung Ihres Parse-Trees, in der Sie syntaktisch korrekte Programme konsistent eingerückt ausgeben können.

Jede Anweisung soll auf einer eigenen Zeile stehen. Die Einrückung soll mit Leerzeichen erfolgen und konsistent sein. Sie brauchen keine Begrenzung der Zeilenlänge implementieren.

Demonstrieren Sie die Fähigkeiten an mehreren Beispielen mit unterschiedlicher Komplexität.

Beispiel:

Aus

``` python
a     := 0
    if    10 < 1
       do
a    :=     42      # Zuweisung des Wertes 42 an die Variable a
else do
        a :=      7
  end
```

soll

``` python
a := 0
if 10 < 1 do
    a := 42
else do
    a := 7
end
```

werden.

**Hinweis**: Es geht nur um die Ausgabe syntaktisch korrekter Programme. Sie brauchen sich um die Semantik (z.B. passende Typen wie etwa keine Multiplikation von Strings mit Integern o.ä.) noch keine Gedanken machen! Achten Sie auf die korrekten Einrücktiefen. Die Zeilenlänge spielt hier keine Rolle, es wird einfach direkt nach jedem Statement umgebrochen (bzw. wie bei den Kontrollstrukturen gezeigt).

**Hinweis**: Das Thema Pretty Printing ist interessant und kann recht schnell ziemlich aufwändig werden. Sie finden im Paper ["A prettier printer"](https://homepages.inf.ed.ac.uk/wadler/papers/prettier/prettier.pdf) von Philip Wadler [@wadler2003prettier] und im Blog ["The Hardest Program I've Ever Written"](https://journal.stuffwithstuff.com/2015/09/08/the-hardest-program-ive-ever-written/) von Bob Nystrom [@Nystrom2015] gut geschriebene Beiträge, um tiefer in die Materie einzusteigen.

#### AST (3P)

Beim Parsen bekommen Sie von ANTLR einen Parse-Tree zurück, der direkt die Struktur Ihrer Grammatik widerspiegelt. Die einzelnen Zweige sind damit in der Regel aber auch viel zu tief verschachtelt.

Überlegen Sie sich, welche Informationen/Knoten Sie für die formatierte Ausgabe wirklich benötigen - das ist Ihr Abstract-Syntex-Tree (*AST*).

Programmieren Sie eine Transformation des Parse-Tree in die von Ihnen hier formulierten AST-Strukturen. Dies können Sie beispielsweise mit einer passenden Traversierung (Visitor-Pattern) erreichen.

Passen Sie den Pretty-Printer so an, dass er auch den AST ausgeben kann. (Alternativ können auch einen zweiten Pretty-Printer für den AST implementieren.)

[^1]: sometime even more often

[^2]: lalalala

[^3]: Um den Text lesbar zu halten, wird hier oft nur von "Parser" gesprochen - gemeint ist aber die gesamte auf diesem Blatt zu erstellende Toolchain: Lexer - Parser - AST - Ausgabe.
