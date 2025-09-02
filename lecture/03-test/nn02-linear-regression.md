# NN02 - Lineare Regression und Gradientenabstieg

> [!TIP]
> <details>
> <summary><strong>🎦 Videos</strong></summary>
>
> - [NN2.1 - Lineare Regression - Intro](https://youtu.be/f-DTaKMnkj4)
> - [NN2.2 - Vergleich Perzeptron und Bsp](https://youtu.be/UnLjjMswNRo)
> - [NN2.3 - Kostenfunktiıon und
>   Gradientenvektor](https://youtu.be/H2YvYIaUW1Q)
> - [NN2.4 - Berechnung Gradientenvektor -
>   Beispiel](https://youtu.be/URaVsZnfppQ)
> - [NN2.5 - Berechnung Gradientenvektor -
>   Allgemein](https://youtu.be/5OZF3Qopous)
> - [NN2.6 - Skalierung der Merkmale](https://youtu.be/m-TnM13I-no)
>
> </details>

> [!NOTE]
> <details>
> <summary><strong>🖇 Weitere Unterlagen</strong></summary>
>
> - [NN02-Lineare_Regression.pdf](https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/blob/master/lecture/nn/files/NN02-Lineare_Regression.pdf)
>
> </details>

## Kurze Übersicht

### Formalisierung (original)

- Ausgabe $y$ ist reelle Zahl aus einem stetigen Bereich (zum Beispiel
  Hauspreis)
- Die **Hypothesenfunktion** ist eine gewichtete Summe der Merkmale
  $x_i$ plus eine Konstante $w_0$:
  $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$
- Der **Verlust** (engl. loss) für einen Datenpunkt $\mathbf{x}$ ist das
  **Fehlerquadrat**:
  $$\mathcal{L} = (\hat{y} - y)^2 = (h(\mathbf{x}) - y)^2$$
- Die Kosten (engl. cost) sind der durchschnittliche Verlust über alle
  Datenpunkte:
  $$J = \frac{1}{2m} \sum_{i=1}^{m} (\hat{y} - y)^2 = \frac{1}{2m} \sum_{i=1}^{m} (h(\mathbf{x}) - y)^2$$

### Formalisierung (ohne inline math)

- Ausgabe y ist reelle Zahl aus einem stetigen Bereich (zum Beispiel
  Hauspreis)
- Die **Hypothesenfunktion** ist eine gewichtete Summe der Merkmale x_i
  plus eine Konstante w_0:
  $$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$
- Der **Verlust** (engl. loss) für einen Datenpunkt x ist das
  **Fehlerquadrat**:
  $$\mathcal{L} = (\hat{y} - y)^2 = (h(\mathbf{x}) - y)^2$$
- Die Kosten (engl. cost) sind der durchschnittliche Verlust über alle
  Datenpunkte:
  $$J = \frac{1}{2m} \sum_{i=1}^{m} (\hat{y} - y)^2 = \frac{1}{2m} \sum_{i=1}^{m} (h(\mathbf{x}) - y)^2$$

### Formalisierung (mit inline math, block math ausgerückt)

- Ausgabe y ist reelle Zahl aus einem stetigen Bereich (zum Beispiel
  Hauspreis)

- Die **Hypothesenfunktion** ist eine gewichtete Summe der Merkmale x_i
  plus eine Konstante w_0:

$$h(\mathbf{x}) = \mathbf{w}^T\mathbf{x} = w_0 + w_1x_1 + w_2x_2 + \ldots + w_nx_n$$

- Der **Verlust** (engl. loss) für einen Datenpunkt x ist das
  **Fehlerquadrat**:

$$\mathcal{L} = (\hat{y} - y)^2 = (h(\mathbf{x}) - y)^2$$

- Die Kosten (engl. cost) sind der durchschnittliche Verlust über alle
  Datenpunkte:

$$J = \frac{1}{2m} \sum_{i=1}^{m} (\hat{y} - y)^2 = \frac{1}{2m} \sum_{i=1}^{m} (h(\mathbf{x}) - y)^2$$

### Der Gradient

- Der **Gradientenvektor** $\nabla J(\mathbf{w})$ setzt sich zusammen
  aus den partiellen Ableitungen der Kostenfunktion $J$ nach den
  Gewichten $w_i$ und zeigt in jedem Punkt $\mathbf{w}$ in die
  **Richtung des steilsten Aufstiegs**:
  $$\nabla J = [ \partial J / \partial w_0
  \quad \partial J / \partial w_1 \quad \ldots
  \quad \partial J / \partial w_n]^T$$
- **Schlussfolgerung**: In die entgegengesetzte Richtung, i.e. in
  Richtung $-\nabla J(\mathbf{w})$ geht es am *steilsten bergab!*
- **IDEE**: Bewege $\mathbf{w}$ in Richtung $-\nabla J(\mathbf{w})$, um
  die Kosten $J$ möglichst schnell zu senken.

### Der Gradientenabstieg (engl. Gradient Descent)

1.  Starte mit zufälligen Gewichten $\mathbf{w}$
2.  Berechne den Gradientenvektor im aktuellen Punkt $\mathbf{w}$
3.  **Gewichtsaktualisierung**: Gehe einen *kleinen* Schritt in Richtung
    $-\nabla J(\mathbf{w})$
    $$\mathbf{w} _{neu} := \mathbf{w} _{alt} - \alpha \cdot \nabla J(\mathbf{w} _{alt})$$
    ($\alpha$: Lernrate/Schrittweite).
4.  Wiederhole Schritte 2-3, bis das globale Minimum von $J$ erreicht
    ist.

> [!NOTE]
> <details>
> <summary><strong>✅ Lernziele</strong></summary>
>
> - k2: Lineare Regression aus Sicht neuronaler Netze: Graphische
>   Darstellung, Vergleich mit Perzeptron
> - k2: Formalisierung
> - k2: Verlust- und Kostenfunktion
> - k2: Gradientenvektor
> - k2: Lernrate
> - k3: Gradientenabstieg
>
> </details>

> [!TIP]
> <details>
> <summary><strong>🧩 Quizzes</strong></summary>
>
> - [Selbsttest Lineare Regression
>   (ILIAS)](https://www.hsbi.de/elearning/goto.php?target=tst_1106590&client_id=FH-Bielefeld)
>
> </details>

> [!TIP]
> <details>
> <summary><strong>🏅 Challenges</strong></summary>
>
> **Skalierung der Merkmale**
>
> Abbildung 1 und Abbildung 2 zeigen die
> [Höhenlinien](https://de.wikipedia.org/wiki/H%C3%B6henlinie) ([Contour
> Lines](https://en.wikipedia.org/wiki/Contour_line)) von zwei
> Kostenfunktionen.
>
> <div style="text-align: center;"><div style="width:40%; margin: 0 auto;">
>
> ![](https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/blob/master/lecture/nn/images/contour_plot_a.png?raw=true)
>
> </div><p>Abbildung 1</p></div>
> <div style="text-align: center;"><div style="width:40%; margin: 0 auto;">
>
> ![](https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/blob/master/lecture/nn/images/contour_plot_b.png?raw=true)
>
> </div><p>Abbildung 2</p></div>
>
> - Erklären Sie, welcher der beiden Fälle nachteilhaft für den
>   Gradientenabstieg Algorithmus ist. Wo liegt der Nachteil? Wie kann
>   die Merkmalskalierung dem genannten Nachteil entgegenwirken?
> - Zeigen Sie unter Verwendung Ihrer eigenen, zufällig generierten
>   Datenpunkte aus dem Bereich $[100, 300] \times [0, 2]$, wie sich
>   Standardisierung, Min-Max Skalierung und Normalisierung auf die
>   Daten auswirken. Vergleichen Sie dazu die jeweiligen Streudiagramme
>   (scatterplots). Sie können hierzu das folgende [**Jupyter
>   Notebook**](https://github.com/Artificial-Intelligence-HSBI-TDU/KI-Vorlesung/blob/master/lecture/nn/files/Feature_Scaling_Starter.ipynb)
>   als Startpunkt benutzen.
>
> </details>

------------------------------------------------------------------------

<div>

![](https://licensebuttons.net/l/by-sa/4.0/88x31.png)

</div>

Unless otherwise noted, this work is licensed under CC BY-SA 4.0.

<blockquote><p><sup><sub><strong>Last modified:</strong> f7ac9d2 (reformat using shorter lines, 2025-08-09)<br></sub></sup></p></blockquote>
