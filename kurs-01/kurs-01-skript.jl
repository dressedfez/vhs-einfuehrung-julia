# Dies ist ein Skript für Julia. Mittels dieses Skripts 
# sollen verschiedene Konzepte der VSCode-Erweiterung
# für Julia erleutert werden.

# so kann man eine Variable definieren
α = 1/137

println("α ist die Fein-Struktur-Konstante: $α")

#=
Der folgende Code erstellt eine quadratische Funktion
und stellt diese grafisch dar.
=#
using Plots
f(x)=α*x^2+x
p = plot(f, -100, 100, label="f(x)")
savefig(p,"Quadratische_Function")