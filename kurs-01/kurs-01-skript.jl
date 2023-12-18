# Dies ist ein Skript für Julia. Mittels dieses Skripts 
# sollen verschiedene Konzepte der VSCode-Erweiterung
# für Julia erleutert werden.

# α ist die Fein-Struktur-Konstante 
α = 1/137

println("The fine structure constant is $α")

#=
Der folgende Code erstellt eine quadratische Funktion
und stellt diese grafisch dar.
=#
using Plots
f(x)=x^2+2x
p = plot(f, 0, 10, label="f(x)")
savefig(p,"Quadratische_Function")