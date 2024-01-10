# Skript, dass die Nutzung von boolscher Logik und if-Anweisungen illustiert.

gueltige_eingabe = false
alter = 0
while !gueltige_eingabe
    println("Geben Sie Ihr Alter ein: \n")
    gueltige_eingabe = true

    # liest Eingabe von Kommandozeile
    eingabe = readline()
    # um eine globale Variable modifizieren zu können müssen
    # wir hier `global` nutzen
    global alter = parse(Int32, eingabe)

    # Nutzung von Short-Circuit Expression
    alter < 0 && begin
                    println("Bitte geben Sie ein Alter ein, dass größer als Null ist.")
                    run(`clear`)
                    global gueltige_eingabe = false
                end
end

# if-Anweisung kann auch als Ausdruck verwendet werden.
text = if  (0 < alter < 16)
        "Sie dürfen noch kein Mofa fahren"
elseif (16 < alter < 18)
        "Sie dürfen noch kein Auto fahren"
else
        "Sie sind alt genug, um Auto und Mofa fahren zu dürfen, wenn Sie einen Führenschein haben."
end

println(text)