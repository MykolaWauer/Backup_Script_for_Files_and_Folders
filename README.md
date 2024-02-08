Für die Sicherungen wird Datei namens Sicherung5.cmd erstellt. Diese Datei führt automatische Sicherungen in einem speziell für den Sicherungsprozess erstellten Ordner durch und vergibt entsprechende Sicherungskopienamen. 
Um diese Option in das Kontextmenü der rechten Maustaste zu integrieren, befolgen Sie bitte die folgenden Schritte:

  1. Öffnen Sie das "Ausführen"-Fenster von Windows mit der Tastenkombination [Windows] + [R].
  2. Hier geben Sie den Befehl shell:sendto (ohne Anführungszeichen) ein.
  3. Es öffnet sich automatisch ein Ordner, in dem alle bisher angelegten Verknüpfungen im "Senden an"-Menü enthalten sind.
  4. Kopieren Sie die Sicherung5.cmd in den geöffneten Ordner

![image](https://github.com/MykolaWauer/Backup_Script_for_Files_and_Folders/assets/51316424/583b3781-c51e-46e9-9563-0aaee14d7ad2)

Nun können die Sicherungen durch einen Rechtsklick auf die gewünschte Datei oder den Ordner erstellen werden indem Senden an und  anschließend Sicherung5.cmd ausgewählt werden. 
Dabei wird ein Ordner kreiert, welcher die entsprechende Sicherung beinhaltet.

![image](https://github.com/MykolaWauer/Backup_Script_for_Files_and_Folders/assets/51316424/88ccb501-90fe-489b-ba28-28b312309baa)
