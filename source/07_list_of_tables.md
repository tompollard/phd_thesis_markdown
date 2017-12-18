# Tabellenverzeichnis {.unnumbered}
<!--
Für mich war das der einzige Nachteil beim Schreiben in Markdown: Es ist nicht möglich, Figuren und Tabellen eine kurze Überschrift hinzuzufügen. Dies bedeutet, dass die Befehle \listoftables und \listoffigures Listen unter Verwendung der vollständigen Titel generieren, was wahrscheinlich nicht das ist, was du willst. Für den Moment ist die Lösung, die Listen manuell zu erstellen, wenn alles andere fertig ist.

Tabelle 5.1  Dies ist eine Beispieltabelle . . .               \hfill{pp}  
Tabelle x.x  Kurztitel der Tabelle . . .              \hfill{pp}  
-->

<!--
TexHack: Überschrift und richtige Seitenzahl werden durch die obige Überschrift gesetzt. Deswegen muss die automatische Überschrift entfernt werden.
-->
\renewcommand{\listtablename}{}

\listoftables

\newpage
