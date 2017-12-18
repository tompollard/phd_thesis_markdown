# Markdown (Pandoc) Template für Abschlussarbeiten

Das Template basiert auf auf dem Repository [![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.58490.svg)](http://dx.doi.org/10.5281/zenodo.58490) von Tom Pollard et al:

> This repository provides a framework for writing a PhD thesis in Markdown. I used the template for my PhD submission to University College London (UCL), but it should be straightforward to adapt suit other universities too.

Bisher habe ich vor allem mit LaTex gearbeitet. Markdown hat aber eindeutig die schönere und einfachere Syntax. Mit [Pandoc](https://pandoc.org/) lassen sich die Vorteile beider Systeme nutzen. Ich habe die Vorlage für meine Bedürfnissen (Bachelorarbeit an der Hochschule München) angepasst. Ich habe aus der Original-README die folgenden Abschnitte übernommen und sinngemäß übersetzt:

## Warum sollte ich meine Abschlussarbeit mit Markdown schreiben?

Markdown ist ein benutzerfreundliches Klartextformat, das einfach in eine Reihe anderer Formate wie PDF, Word und LaTex umgewandelt werden kann. Du wirst die Arbeit mit Markdown lieben, weil:

- Es handelt sich um ein übersichtliches Klartextformat.
- Du kannst LaTeX verwenden, wenn du es brauchst (z.B. für Matheformeln).
- Auch bei großen und bildlastigen Dokumenten lässt es dich nicht im Stich.
- automatische Verzeichnisse (Inhalt, Abbildungen, Tabellen, Literatur, ...) sind Dank Pandoc kein Problem.
- Kommentare, Textentwürfe etc. können innerhalb des Dokuments gespeichert werden, indem du sie mit `<!-- Kommentare ... -->` umgibst.
- Es arbeitet gut mit Git zusammen. Das erleichtert dir Backups. Checke einfach deine Änderungen ein und lade sie in dein Repository.
- Wenn Markdown doch nichts für dich sein sollte, kannst du einfach die bisherige Arbeit umwandeln und woanders weiterarbeiten.

## Gibt es irgendwelche Gründe nicht mit Markdown zu arbeiten?

Es gibt ein paar kleine Probleme:

- Derzeit ist es nicht möglich Kurzbeschriftungen bei Tabellen ~~und Abbildungsverzeichnissen~~ ([bei Abbildungen ist es mittlerweile möglich](https://github.com/tompollard/phd_thesis_markdown/pull/47), Dank an @martisak) zu verwenden. `/listoftables` nutzt lange Beschriftungen. Wenn du das nicht willst, musst du das Tabellenverzeichnis am Ende manuell schreiben.
- Das Design einiger Ausgabeformate könnte verbessert werden. Die Ausgabe als PDF und HTML (Danke an [@ArcoMul](https://github.com/ArcoMul)) ist ok. Wenn du Worddokumente als Ausgabeformat benötigst, wirst du noch etwas Arbeit haben.
- Wenn dir weitere Punkte auffallen, kannst du sie hier einfügen.

## Wie ist die Vorlage strukturiert?

- README.md => diese Hinweise.
- License.md => Regeln für die Verwendung (MIT license).
- Makefile => enthält Befehle mit denen das Dokument erzeugt wird.
- output/ => Ordner, der das erzeugte Dokument enthält.
- source/ => Ordner, der den Inhalt der Abschlussarbeit enthält. Auch die Datei references.bib, die die Literaturhinweise enthält.
- source/figures/ => Ordner für Abbildungen.
- style/ => Ordner mit den Styledolumenten.

## Wie fange ich an?

1. Installiere folgende Software:
    - Einen Texteditor wie [Atom](https://atom.io/), [Sublime](https://www.sublimetext.com/), emacs, ...
    - Eine LaTeX Distribution (z.B., [TeX Live](https://www.tug.org/texlive/) für Linux- und Windowsnutzer).
    - [Pandoc](http://johnmacfarlane.net/pandoc) für die Konvertierung von Markdown in das gewünschte Format. Möglicherweise musst du auch [Pandoc cite-proc](http://pandoc.org/demo/example19/Extension-citations.html) installieren, um das Literaturverzeichnis erstellen zu können.
    - Installiere @martisak's "shortcaption" Modul für Pandoc mit `pip install pandoc-shortcaption`
    - Git, für Versionskontrolle
2. [Forke das Repository](https://github.com/089/phd_thesis_markdown) oder [das Original Repository](https://github.com/tompollard/phd_thesis_markdown/fork) on Github  
3. Klone das Repository auf deinen PC (oder [downloade die ZIP-Datei](https://github.com/089/phd_thesis_markdown/archive/master.zip)).  
4. Wechsel in das Verzeichnis mit der Makefile und führe in der Konsole "make pdf" (oder "make html") aus. Die erzeugte Datei findest du dann im Output-Ordner.
**Im Falle eines Fehlers** (e.g. `make: *** [pdf] Error 43`) führe ggf. folgende Befehle aus:  
    ```
    sudo tlmgr install truncate
    sudo tlmgr install tocloft
    sudo tlmgr install wallpaper
    sudo tlmgr install morefloats
    sudo tlmgr install sectsty
    sudo tlmgr install siunitx
    sudo tlmgr install threeparttable
    sudo tlmgr update l3packages
    sudo tlmgr update l3kernel
    sudo tlmgr update l3experimental
    ```

5. Bearbeite die Dateien im Ordner 'source' und gehe dann wieder zu Schritt 4.

## Was sollte ich sonst noch wissen?

Einige hilfreiche Punkte in zufälliger Reihenfolge:

- Jedes Kapitel muss mit mindestens einer Leerzeile enden, sonst wird die Überschrift des folgenden Kapitels eventuell nicht erfasst.
- Einen Zeilenumbruch kannst du mit zwei Leerzeichen am Ende der Zeile erzwingen.
- die Vorlage verwendet Markdown [(Pandoc)](http://pandoc.org/MANUAL.html)
- PDFs werden mithilfe von LaTeX-Vorlagen aus dem 'style'-Ordner erzeugt. Änderungen nimmst du am besten dort vor.
- Um den Zitierstil zu ändern, überschreibe einfach `ref_format.csl` mit dem neuen Style. Styledateien bekommst du unter [citationstyles.org/](http://citationstyles.org/)
- Für Webentwickler gibt es einen Grunt Task (Gruntfile.js), der die Markdowndateien überwachen kann. Mit `$ npm install` und anschließendem `$ npm run watch` wird die PDF immer dann erzeugt, wenn du eine Markdowndatei speicherst.

# Beitragen

Beiträge zum Template sind herzlich willkommen! Es gibt vieles, was verbessert werden kann, z.B.:

- Finde einen Weg, wie die Kurzbeschriftungen von Tabellen im Tabellenverzeichnis landen.
- Aufräumarbeiten in den LaTeX-Vorlagen, die derzeit etwas chaotisch sind.
- Styleverbesserungen für die Ausgabe im Word- bzw. TeX-Format.

Bitte forke und bearbeite das Projekt und schicke anschließend einen Pullrequest. 
