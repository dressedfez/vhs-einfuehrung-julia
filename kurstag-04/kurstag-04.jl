### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ a4ffae18-60a0-4fc8-bef2-3446b01da674
begin
	using PlutoUI, Plots, LaTeXStrings
	TableOfContents()
end

# ╔═╡ 499bbc21-0699-420e-abcd-ae8bd6c1f2c9
md"""
# Einführung in Julia - Kurstag 4

__Funktionen, Multiple Dispatch und eigenen Datentypen__

## Funktionen
"""

# ╔═╡ 83070547-600c-4fd8-ba5d-7682548e56a9
md"### Funktionsdefinition"

# ╔═╡ 9ef4d66d-7ad4-4d18-a178-8803374e94d5
md"""
Funktionen sind kleine Anteile des Codes, die dazu gedacht sind:
- Wiederholungen zu vermeiden (DRY = __D__on't __R__epeat __Y__ourself)
- Logik zu Kapseln (Single Responsiblity) und damit Änderungen auf einen übersichtlichen Bereich einzuschränken (Open-Close-Principle).

Julia kennt zwei verschiedene Wege Funktionen zu definieren. Die Standard-Methode, die mit dem Keyword `function` gekenntzeichnet wird und die Kurzschreibweise.

Die Kurzschreibeweise von Funktionen soll genutzt werden, wenn sich die Logik einer Funktion in einer Code-Zeile schreiben lässt. Für alle anderen Fälle ist die Standard-Methode, die richtige Wahl.

"""

# ╔═╡ 60d093b0-2ef5-43af-903f-20e0c5a7ec19
md"""

!!! tip "Standard Funktionen Definition"

	Die übliche Definition einer Funktion wird durch den folgenden Ausdruck beschrieben.

	```julia
	function name_der_funktion(paramter, parameter,... default_parameter=default_wert,...;keyword_parameter=keyword_wert,...)
		# Funktionskörper mit Logik
    end
	```

	Hierbei bedeuten die obigen Begriffe:

	- parameter: ist ein belieges Argument einer Funktion. In der Definition der Funktion kann der Parameter auch mit einer Typisierung der Form `parameter::Parametertyp`  (z.B.: row_column::UInt) beschränkt werden.
	- default_parameter: Argumente der Funktion für die ein default-Wert festgelegt ist. Wenn des Arguments nicht übergeben wird, so wird der default-Wert genommen. Werte mit default-Wert sind optional. Möchte man einen default-Wert durch ein Funktionsargument ersetzen, so müssen alle Parameter bis zum betreffende Argument angegeben werden.
    - keyword_parameter: Keyword-Parameter sind Parameter mit sprechenden Namen. Sie       müssen bei der Funktionsdefinition nach einem Semikolon aufgeführt werden. Bei        Aufruf der Funktion ist dies nicht notwendig. Die Argumente bei beim Aufruf           werden durch ihren Parameter-Keyword gekennzeichnet.

"""

# ╔═╡ fba2a471-b966-42ee-94eb-d443bf6215e2
md"""
#### Beispiel: Funktion mit Default-Wert"""

# ╔═╡ 30b8295b-1d90-4a2b-9cb9-9acf327c4218
function create_funny_matrizes(row_number,column_number,col = ["😕","🤣"])
	rand(col,row_number,column_number)
end

# ╔═╡ 39a8855e-b6c0-11ee-1f9a-9d3e956e7db1
create_funny_matrizes(2,6)

# ╔═╡ c82dbc2f-5c82-4959-8004-9cdc32cee1f9
md"Überschreibung des Default-Wertes durch Angabe eines Argumentes"

# ╔═╡ 3d5f8c93-74bc-4c39-a820-73a9663df546
begin
	scary_matrix = create_funny_matrizes(5,5,["👻","🤡","👽"])
	scary_matrix
end

# ╔═╡ 791b845b-8b74-400c-9903-2fce205c84be
md"Warum hat die Funktion zwei Methoden?"

# ╔═╡ de34b9f5-42ac-4056-84f9-4a69c9111995
methods(create_funny_matrizes)

# ╔═╡ ea278e05-bf70-4a51-a62a-1df26ce75e26
md"""

!!! tip "Kurzschreibweise bei Funktionen"

	Die Kurzschreibweise bei Funktionen hat den die foglende Form:

	```julia
	name_der_funktion(paramter, parameter,...) = <Funktionskörper mit Logik>
	```

	Die Definition der Begriffe und die Nutzung von Default- und Keyword-Parametern ist wie bei der Standard-Methode.
"""

# ╔═╡ f258a47b-8569-4c38-ad3b-bfca60227430
md"#### Beispiel: Funktion mit Keyword-Argumenten"

# ╔═╡ ea02c48a-024d-430d-8a61-d4fda91e0c73
md"Definition einer Parabel"

# ╔═╡ 305e9ec4-4dcb-4537-b951-06bdba23c993
p(x;a=1,b=0,c=0) = a*x^2+b*x+c

# ╔═╡ ae506cf2-a277-44aa-bc88-ba646d9be677
md"Auswertung der Funktion"

# ╔═╡ c154d88a-259c-4737-b75d-788b84dd0373
p(0)

# ╔═╡ 4115d87f-df1b-4fdf-acdb-a0c9ee2d1492
md"Definitionsbereich der Funktion festlegen über `range`-Operator: "

# ╔═╡ 622ec6a8-9c4e-4de3-8a68-e5f9bef1d53d
x=-5:0.1:5

# ╔═╡ 43457cf7-3eae-4746-9344-bf63922932f9
md"Anwenden der Funktion auf viele Werte: __Broadcasting__"

# ╔═╡ cef9a963-8962-42ba-ac2a-e0109f877ac9
broadcast(p,x)

# ╔═╡ 0bd87716-3d9e-4202-90b8-0a43aeedd15f
md"verkürze Notation für `broadcast`-Operator:"

# ╔═╡ 145256a7-6808-4f0b-b3a8-64c8f58a1ba5
p.(x)

# ╔═╡ 18d7054b-9ff9-485e-8747-b402f3d88836
begin
	a=1;b=0
	plot(x,p.(x,c=5),label="")
	xlabel!("x")
	ylabel!("p(x)")
	title!(L"Parabel $p(x)=a x^2+b x+ c$ mit $a=$"*"$(a)"*L", $b=$"*"$b")
	ylims!(0,20)
end

# ╔═╡ fee934b2-731c-4008-b9d7-95ef939cebac
md"""

!!! tip  
	Bei Standard Funktionsdefinition ist die Angaben eines `return`-Keyword optional. Die Angabe wird notwendig, wenn man z.B. vor dem Ende des Funktionskörpers innerhalb einer if-Anweisung aus der Funktion herausspringen möchte.

#### Beispiel: Funktion mit `return`-Keyword
"""

# ╔═╡ ab594ec8-d3dd-47fe-9fda-83880e2eeed0
function divide(a, b)
    if b == 0
        println("Division durch Null ist nicht erlaubt.")
        return  # Hier wird die Funktion ohne Rückgabewert verlassen
    end
    
    result = a / b
    println("Das Ergebnis der Division ist $result.")
    return result  # Hier wird der Wert von result zurückgegeben
end

# ╔═╡ 96cf72f3-e7e4-42fa-9bae-ed509c6b9f84
divide(1,0)

# ╔═╡ 1f4dfce3-a00d-4891-b1d5-7b9f6f73fed3
md"""### Funktionen als Werte

Funktionen können wie Typen Variablen zugeordnet werden. Im Allgemeinen sagt man, dass Funktionen __1. Class Citizen__ sind.

Dieses Eigenschaft ist vorrangig aus Funktionalen Programmiersprachen bekannt.
"""

# ╔═╡ 741f53a5-0dd3-426d-928e-a3f48ef0ab92
isEven(n::Int) = n % 2 == 0 

# ╔═╡ f5dd1bae-0286-4353-bb70-5ad1a9698dcb
function gefilterteZahlen(wahl, zahlen)
	filter_kriterium = !isEven  # hier wird eine Funktion einer Variable zugeordnet
	if(wahl=="gerade")
		filter_kriterium = isEven # hier wird eine Funktion einer Variable zugeordnet
	end
	filter(filter_kriterium, zahlen)	
end

# ╔═╡ 466552e9-d77d-4782-b6c0-5590ef422c01
gefilterteZahlen("gerade",1:20)

# ╔═╡ b816409b-bddf-4326-99b3-57e475be7c96
gefilterteZahlen("ungerade",1:30)

# ╔═╡ 6149491c-a510-4c4b-abef-f0c03415f6d1
md"""### Funktionnen multiple Rückgabewerten

Funktionen in Julia können auch mehrere Rückgabewerte haben. Im Allgemeinen werden Sie als Tuple zurückgegeben. Die Rückgabewerten können direkt ausgepackt werden.

"""

# ╔═╡ cac266fc-74ec-443c-9dc4-d1b1ceb67b39
md"#### Beispiel"

# ╔═╡ c05cc5a7-e639-4b32-8a8b-3e0ff86693cd
function berechne_statistik(data::Vector{Float64})
    n = length(data)
    mittelwert = sum(data) / n
    varianz = sum((x - mittelwert)^2 for x in data) / (n-1)
    return n, mittelwert, varianz
end

# ╔═╡ 3858d61c-819e-45bd-9255-7285da3f92cc
begin
	daten = [1.0, 2.0, 3.0, 4.0, 5.0]
	anzahl_datenpunkte, mittelwert, varianz = berechne_statistik(daten)
	
	println("Anzahl der Datenpunkte: $anzahl_datenpunkte")
	println("Durchschnitt: $mittelwert")
	println("Varianz: $varianz")
end

# ╔═╡ ee59219c-52c0-4dce-9b7d-a5773feb4363
md"""
#### Übung 1:
1. Schreibe eine Funktion, die das Maximum und Minimum aus einer Liste von Zahlen berechnet und als Tupel zurückgibt.
2. Erstelle eine Funktion, die überprüft, ob ein gegebener String ein Palindrom ist.
3. Implementiere eine Funktion, die die Lösungen einer quadratischen Gleichung für gegebene Werte von a, b, c zurückgibt.
4. Schreibe eine Funktion, die die Anzahl der Vokale in einem gegebenen String zählt.
5. Implementiere eine Funktion, die die ersten n Zahlen der Fibonacci-Folge generiert und zurückgibt. Die Fibonacci-Folge ist wie folgt definiert 

```math
  F_n = F_{n-1}+F_{n-2}
```

mit

```math
F_1 = F_2 = 1
```
"""

# ╔═╡ 1f9b4b44-ddc7-4406-9e2d-0bb0b0d1074a
md"Lösung 1:"

# ╔═╡ 215aae07-b9ad-4e66-9429-d1aae1157c6b
minMax(data)= minimum(data), maximum(data)	

# ╔═╡ d4a20c15-35dd-4520-9f7c-a57d9a520044
minMax([1,9,2,4,5])

# ╔═╡ b213bdb0-cb10-449c-8a5b-32f76fc2cb99
md"Lösung 2:"

# ╔═╡ 6caf40c3-fb6f-43e7-b838-8b80b63be12d
function isPalindrom(word::String)
	word = uppercase(word)
	word==reverse(word)
end

# ╔═╡ 7871f124-c4c3-4b52-8f03-ce4b27e021de
isPalindrom("Anna")

# ╔═╡ 17ae6ea3-91ff-4b0b-a91e-07277eeeb043
begriff = "Anna"

# ╔═╡ e274597a-2bd2-4457-b121-81a7b91aa08e
if isPalindrom(begriff)
	println(" $begriff ist ein Palidrom")		
else 
	println("$begriff is kein Palidrom")
end

# ╔═╡ 81ce68fb-3ddb-48d2-b512-8b25177eb10c
md"Lösung 3:"

# ╔═╡ 2c01ed73-85b1-41f3-9160-36992c95025a
function solution_quadratic_equation(a,b,c)
   @assert a !=0
	p = b/a
	q = c/a
	s = sqrt(complex(p^2/4 - q))
    (-p/2 + s, -p/2 - s)
end

# ╔═╡ a7be5c03-ffc6-4423-82a4-5fc0c8aa3797
solution_quadratic_equation(-1,1,1)

# ╔═╡ e5082f2c-14f1-4424-ab2a-e8dd35defcf9
md"Lösung 4:"

# ╔═╡ 81f115dc-40ce-4ba3-981f-5672fa6d005e
"""
Zählt alle Vokale in einem gegeben String

Argument:
- s::String betrachteter String

Returns:
 - Gibt die Anzahl der Vokale im übergebenen String zurück
"""
function count_vowels(s::String)
	counter=0
	for c in s
		if c ∈ ['a','e','i','o','u']
			counter+=1
		end
	end
	counter
end

# ╔═╡ aeae585c-d0a3-4a85-bb15-48ecf0fefa9e
count_vowels("Hallo Volkshochschulkurs")

# ╔═╡ d4a06545-8344-4f44-b311-4074d092035d
md"Lösung 5:"

# ╔═╡ cdbc00c8-5876-4d5f-abd7-8a71c4b1c17f
function f(n)
	if n==0
		return 0
	elseif n==1
		return 1
	else
		return f(n-1)+f(n-2)
	end
end

# ╔═╡ c4cd1fc5-41de-43c4-bdd4-7d1ca3efff59
n_liste=0:10;

# ╔═╡ eeb0a930-6cd4-4e71-a737-1c2cde7a4395
f.(n_liste)

# ╔═╡ c62b7a98-4697-432c-9ee5-f742b0b49c3f
md"""## Individuelle Datentypen"""

# ╔═╡ 2c10bace-2e14-4889-84b4-757350904ac7
md"""### Konkrete Datentypen"""

# ╔═╡ acd031ea-7c64-48fd-b29b-96d3bce1972d
md"""Julia erlaubt wie anderen Sprachen (Java, Go, Python) eigene Datentypen zu definieren. Im Gegensatz zu diesen Sprachen ist Julia __nicht__ wirklich eine objektorientierte Sprache, wie wir gleich sehen werden.


Allgemein kann man Datenstrukturen mit dem Keyword `struct` wie folgt definieren:

!!! tip 
	Eigene Datentypen kann man mittels des `struct`-Keywords definieren:
	```julia
	struct DatenTypeName
		datenfeld1::Typ1
		datenfeld2::Typ2
	 .
     .
     .

    end
	```
    Per Konvention werden die Name der Datentypen groß geschrieben.

#### Beispiel

"""

# ╔═╡ 39fe7968-8f5d-4c48-a36b-3dba5dce6f69
struct Dog
	name::String
	alter::Int
end

# ╔═╡ e932e742-9d91-476b-b9e0-689ef0b13347
md"Instanzen der Datentypen erzeugt man, wie in folgemden Beispiel gezeigt:"

# ╔═╡ c92328f5-d38f-4695-9635-83b972dafd86
instance = Dog("Benno",5)

# ╔═╡ 6cccde01-c01e-483f-8e74-3f046267f375
instance.name

# ╔═╡ 15958b1c-4d67-464a-8c71-6efd1399d080
md"Datentypen, die mit `struct` definiert wurden, kann man nicht ändern"

# ╔═╡ 31d28348-d45d-414f-bd51-570622710564
instance.name = "Frank"

# ╔═╡ f8cf4522-aead-4759-9c12-fd2f777f0cc9
md"veränderbare Datentypen kann man wie folgt definieren:"

# ╔═╡ 06abd980-1014-41c7-8756-095815da5840
mutable struct  City
	 name::String
end

# ╔═╡ 325c3efe-d2fa-4a53-a3dd-b69a7853c65e
city = City("Dresden")

# ╔═╡ 624200e6-3768-437d-8db6-7a7ae47bcfc2
city.name = "Frankfurt"

# ╔═╡ 4f94e816-f7b2-4fa1-a4aa-0a54a9e0e602
city

# ╔═╡ 152938a5-0b34-4065-b57f-c7c3aca20733
md"""

!!! warning "Achtung" 
	Im Gegensatz zu objektorientierten Sprachen, wie Java oder Python, sind nur Daten mit Datentypen assoziert. Datentypen haben keine Methoden wie in diesen Sprachen.
"""

# ╔═╡ 1258a5f5-d68c-432a-84a5-b1c8f3a974ca
md"### Abstrakte Datentypen"

# ╔═╡ 8f371ce4-d19b-4d14-be63-a2fb0abf0490
md"""Analog zu Java, Go, Python besitzt auch Julia abstrakte Datentypen. Wie in diesen Sprachen kann man auch in Julia __keine Instanzen__ dieser abstrakten Datentypen erstellen. Diese abstrakten Datentypen sind dazu da Verhalten zu organisieren, wie wir später sehen werden.


Allgemein kann man abstrakte Datentypen mit den Keywords `abstract type` wie folgt definieren:

!!! tip 
	Eigene Datentypen kann man mittels des `struct`-Keywords definieren:
	```julia
	abstract type NameAbstrakterDatenTyp end
	```

    Per Konvention werden die Name der abstrakteb Datentypen ebenfalls groß geschrieben.

#### Beispiel
"""

# ╔═╡ 6490cec7-132b-41c7-8a18-bebef37ed8e2
abstract type Animal end

# ╔═╡ 05f03db9-7857-4ec2-b52f-12d867b1701c
md"""

!!! warning "Achtung" 
	Im Gegensatz zu anderen objektorientierten Sprachen, wie Java oder Python, haben haben abstrakte Datentypen in Julia __keine__ assozierten Daten. Sie werden logischen und Verhaltensstrukturierung genutzt.
"""

# ╔═╡ 22fbb745-d780-4bb3-a760-d62372f7cbf5
md"""### Vererbung bei Datentypen

Die Strukturierung von Datentypen kann über die __Vererbung__ von abstrakten Datentypen erreicht werden. 


!!! tip 
	Die Vererbung von einem abstrakten Datentype erreicht man durch folgende Notation
	```julia
	abstract type ErbenderTyp <: VererbenderTyp  end
	```
    im Fall von abstrakten Datentypen und
	```julia
	struct ErbenderTyp <: VererbenderTyp 
		...
	end
	```
	im Fall von konkreten Datentypen.
	
#### Beispiel

"""

# ╔═╡ 192cb4fd-e9e2-409c-b491-9f4742de0e8b
abstract type Lebewesen end ## definieren abstrakten Typ, um davon zu erben

# ╔═╡ 84bda381-1b74-4aa4-a338-eeb3090c9736
abstract type Tier <: Lebewesen end # ein Tier **ist** ein Lebenwesen 

# ╔═╡ 2856d8bf-077a-49b5-b879-1c1a7584d969
struct Hund <: Tier # ein Hund **ist** ein Tier (Hund war schon oben definiert)
	name::String
	alter::Int
end

# ╔═╡ ed912043-2c57-4a2f-956b-53da4f74d450
md"Die Beziehung zwischen den Typen kann man mit den verschiedenen Befehlen untersuchen:"

# ╔═╡ a38c72a9-b6f7-4a3b-b50b-2dd3df6a8ccb
supertypes(Hund)

# ╔═╡ 0164400e-3e91-4536-8ad4-ef89ae9091ff
supertype(Hund)

# ╔═╡ c79db17c-f4e1-486c-85bb-f26605b749da
subtypes(Hund)

# ╔═╡ 25ed0976-0540-4a5f-8814-3c6b6a3e70b1
subtypes(Tier)

# ╔═╡ 2beda6e2-b087-4af0-beb1-ed40c552b10e
md"Folgendermaßen kann man direkt prüfen, ob ein gegebener Typ von einem anderen Typ  erbt:"

# ╔═╡ 39b4e8de-3288-471c-93f0-0c72c7c27cf4
 Hund <: Lebewesen

# ╔═╡ c6457e91-5237-42a6-bfe8-433ab67a74f3
Int <: Lebewesen

# ╔═╡ db1d8af7-1fcc-447d-9d2b-229309b30d11
md"Folgendermaßen kann man direkt prüfen, ob eine __Instanz__ eines gegebenen Typs mit einem anderen Typ in einer Vererbungsbeziehung steht:"

# ╔═╡ ea93e66b-d399-4f51-bd2d-dea7412006b9
axi = Hund("Axi",2)

# ╔═╡ 38cd5cd9-2c09-4535-91ea-5a0eec757960
axi isa Lebewesen

# ╔═╡ 008c0b76-0a20-441f-ac36-23df3d507b3b
axi isa Int

# ╔═╡ 7e894af8-e380-4ba6-9ce1-b14adec11ccf
md"""
#### Übung 2:
1. Definiere eine Struktur Auto, die die Eigenschaften marke, modell und baujahr hat. Schreibe Funktionen, um ein Auto zu erstellen und Informationen darüber anzuzeigen. Überschreibe dazu die Funktion `show` aus dem Base-Modul (siehe [hier](https://docs.julialang.org/en/v1/base/io-network/#Base.show-Tuple{IO,%20Any,%20Any}))
1. Erstelle eine Klasse Bankkonto, die die Eigenschaften kontonummer, inhaber und kontostand hat. Implementiere Methoden, um Geld einzuzahlen, abzuheben und den Kontostand anzuzeigen.
1. Definiere einen abstrakten Typ GeometrischeForm mit Untertypen Kreis und Rechteck. Implementiere Methoden, um den Flächeninhalt und den Umfang jeder geometrischen Form zu berechnen. Implemetiere eine Methode `beschreibe`, die eine Geometrische Form annimmt und den Flächeninhalt sowie den Namen der geometrischen Figur ausgibt.
"""

# ╔═╡ db880dd1-04d0-46d8-8f9a-a9e0f3b8a5bc
md"Lösung 1:"

# ╔═╡ af201f75-ae49-4cc8-bc3f-cdf32db1f3d0
struct Auto
	marke::String
	modell::String
	baujahr::Int
end

# ╔═╡ 3d7172f2-e09a-440c-8320-1e0e2a9f39b2
Base.show(io::IO, obj::Auto) = print(io, "Auto(marke=$(obj.marke), modell=$(obj.modell)) aus dem Jahr $(obj.baujahr)")

# ╔═╡ ba42f768-fe68-41c6-85f4-ab9cfd2d4699
bmw3 = Auto("BMW","3",2015)

# ╔═╡ 4a90ea54-990c-4e21-8408-2511d51bfd1b
md"""## Multiple Dispatch
__The secret power of Julia__
"""

# ╔═╡ 8661b042-9c11-44bf-8f81-8a4a9a0617a7
md"""Was bedeutet "Dispatch"? Welche Arten von Dispatch werden unterschieden?


!!! tip "Definition"
	Dispatch bedeutet Daten an Empfänger (können auch Funktionen) zu verteilen, damit diese vom Empfänger verarbeitet werden können.
	
Man unterscheidet mehrere Arten von Dispatch, die nicht unbedingt auschließend seien müssen:

1. Statisches Dispatch:

   Die Dispatch-Regeln werden während des Kompelierens des Source-Codes festgelegt und sind danach nicht mehr veränderbar. Die Zielfunktionen sind damit schon zu diesem Zeitpunkt fest und können sich nicht durch das Laufzeitverhalten ändern.


2. Dynamisches Dispatch:

   Die Dispatch-Regeln werden während der Laufzeit des Programmes festgelegt. Der Kompiler erstellt eine Lookup-Tabelle für alle Funktion. In der Laufzeit wird  dynamisch entschieden welche Methode aufgerufen wird.


3. Multiple Dispatch

   Die Dispatch-Regeln werden nicht nur durch den Namen der Funktion vorgegeben sondern auch durch die Ordnung und die Typen der Funktions-Parameter. Die Auswahl hängt von der, während der Laufzeit auftreten, Parametertypen ab.


!!! warning "Achtung"
	__Julia__ ist eine Sprache, die dynamisches und multiples Dispatch unterstützt. Die meisten Sprachen unterstützen nur statisches Dispatch, oder ein eingeschränktes (weitestgehend nicht multiples) dynamisches Dispatch. 
"""

# ╔═╡ ae5e8f3c-a557-4ad5-9496-a4ccc248b214
md"""#### Beispiel
für dynamisches Dispatchen
"""

# ╔═╡ c39a8e82-3685-4a1e-84fa-d9f38da220aa
function beschreibe(lebewesen::Lebewesen) 
	println("Ich bin ein Lebenwesen und brauche Nahrung.")
end

# ╔═╡ ef72707b-1404-48ce-8c46-486fc4b050ef
function beschreibe(tier::Tier)
	println("Ich bin ein Tier und kann mich bewegen, aber nicht sprechen.")
end

# ╔═╡ a1261c62-b5f7-43be-8e2d-f428679fc9c5
function beschreibe(hund::Hund)
	println("Ich bin ein Hund, kann laufen und bällen.")
end

# ╔═╡ 620c788e-f181-4d54-bc90-7b63521cb39f
begin
	struct Katze <: Tier
		name::String
	end
	molly = Katze("Molly")
end

# ╔═╡ bbd2707e-01e7-4d5e-969e-1bbfe606c826
begin
	struct Mensch <: Lebewesen
		name::String
	end
	egon = Mensch("Egon")
end

# ╔═╡ 2e46e2b6-e50e-4e1f-91d5-b312d1cbd2a9
beschreibe(mensch::Mensch) = println("Ich, $(mensch.name) bin ein Mensch und laufe auf zwei Beinen.")

# ╔═╡ 5440ce80-7aee-46e7-a684-d60d6177d4f0
beschreibe(axi)

# ╔═╡ 468348f0-b76c-4c88-936e-f11611871973
beschreibe(molly)

# ╔═╡ 1747e51f-b41c-4e58-ae35-4c36731c59fb
beschreibe(egon)

# ╔═╡ 8fd3673c-2c51-49ca-bd6a-52b7a5fe7287
methods(beschreibe) # bitte auskommentieren

# ╔═╡ 7bf7428f-74fd-45fd-a82f-82392f7426ad
md"""#### Beispiel
für multiples Dispatchen

__Vorbereitung:__
"""

# ╔═╡ b0056396-ccce-4231-880b-da66679f0bad
abstract type Thing end

# ╔═╡ 960ef5bb-61d0-4be8-a692-0b3ea210c97f
struct Moon <: Thing
	name::String
end

# ╔═╡ f0537dd1-43f7-45b7-916a-4e6667872eda
struct Astroid <: Thing
	name::String
end

# ╔═╡ 0413c29a-f343-44e7-9bb7-e406acc9b6b4
abstract type Spaceship <: Thing end

# ╔═╡ 95e3a054-a68f-42fc-86db-c8775e459eb1
begin
	struct TransportShip <: Spaceship
		name::String
	end
	struct Stardestroyer <: Spaceship
		name::String
	end
	struct XWing <: Spaceship
		name::String
	end
end

# ╔═╡ f19268af-b274-4cb4-9f03-98f2fc89cde9
md"Definition der Methoden:"

# ╔═╡ a8d30f0f-c1a8-4f11-acca-7f44652f4e12
meets(a::Thing,b::Thing) = println("Thing $(a.name) meets $(b.name)")

# ╔═╡ 3a75a418-01b4-49f8-aad0-27ec95583a78
meets(astroid::Astroid, moon::Moon) = println("Astroid $(astroid.name) crashes into moon $(moon.name)")

# ╔═╡ 8206e6ca-1052-4c40-989c-598b4cca0da3
meets(a::Astroid,b::Astroid) = println("Astroid $(a.name) merges with astroid $(b.name)")

# ╔═╡ 55815409-3d79-413e-9daf-cdaff41d68da
meets(astroid::Astroid,space_ship::Spaceship) = println("Astroid $(a.name) destroys spaceship $(space_ship.name)")

# ╔═╡ 63cf0c21-e7df-4004-b567-bcb68c0d3a61
meets(astroid::Astroid, star_destroyer::Stardestroyer) = println("Stardestroyer $(star_destroyer.name) destroys astroid $(astroid.name).")

# ╔═╡ d2ee6938-bc50-446c-8164-be27d4caa202
begin
	xwing = XWing("Cooler Xing")
	moon = Moon("Mond")
	meets(xwing,moon)
end

# ╔═╡ be4bdd0f-d74b-44b5-b459-a1a39a2cb579
md"""

!!! warning "Hinweis"
	__Julia__ sucht immer die Funktion aus, die den übergeben Parametern inklusive ihrer Typen am Nächsten kommen.
"""

# ╔═╡ 98e20c3e-0c67-458a-8a51-9996ea8e01e9
begin
	astroid_XCP1 = Astroid("XCP1")
	astroid_XCP2 = Astroid("XCP2")
	meets(astroid_XCP1,astroid_XCP2)
end

# ╔═╡ bc1769f4-f588-4188-9fd2-0cde5db0e3d7
md"""#### Beispiel
Problem: Mehrdeutigkeit
"""

# ╔═╡ 5dd78c1e-cd73-4ef7-a173-6e5cbd5f048f
calculate(x::Float64, y) = x+y

# ╔═╡ a521c5ed-3c87-40cb-b623-b5c59a34cb6b
calculate(x, y::Float64)= x*y

# ╔═╡ 4a6c28a9-063d-4779-b603-33c3c16678df
#calculate(x::Float64, y::Float64) = x/y # Mehrdeutigkeit von oben wir durch diese Funktion aufgehoben

# ╔═╡ 0d147bfb-6c9e-4123-a08e-fdb29e1e4675
md"Warum funktioneren die beiden Aufrufe, aber der dritte nicht?"

# ╔═╡ 235b50cc-5edc-43e4-b4ea-71c2efc0a226
calculate(1.0,1)

# ╔═╡ 8003ce5d-9203-4192-a315-ce2070a0e98a
calculate(1,1.0)

# ╔═╡ e7d661bf-7734-42e4-83a5-7b577b2fdd3a
#calculate(1.0,2.0) # auskommentieren führt zu Problemen, warum?

# ╔═╡ 28daea99-6b9e-45ac-b71f-7f877ba5852e
md"""

!!! warning "Hinweis"
	Mehrdeutigkeit kann man vermeiden durch:

    - Einführung von Beschränkungen via Typisierung und
    - eine klare und eindeutige Typen-Hierachie
"""

# ╔═╡ 8d74ef58-d9f1-46d7-92c9-c45b5635f764
md"""
#### Übung 3:
1. Entwickeln Sie ein System für einen Online-Shop in Julia. Erstellen Sie Klassen für Produkte, wie Electronics, Clothing und Books. Implementieren Sie eine Funktion calculate_total_price, die den Gesamtpreis basierend auf dem Warenkorbinhalt berechnet. Verwenden Sie Multiple Dispatch, um spezifische Berechnungsregeln für unterschiedliche Produkttypen und Sonderangebote anzuwenden.
2. Modellieren Sie ein Personalmanagementsystem für ein Unternehmen. Erstellen Sie Klassen für verschiedene Mitarbeiterrollen wie _Manager_, _Developer_ und _HumanResources_. Implementieren Sie eine Funktion `calculate_total_cost`, die die Summer der Gehälter aller Mitarbeiter basierend auf ihren Rollen berechnet. Verwenden Sie Multiple Dispatch, um unterschiedliche Gehaltsberechnungsmethoden für verschiedene Mitarbeiterrollen anzuwenden.
"""

# ╔═╡ 8977b7da-cf53-4aa9-bd9f-a198129971fc
md"""

!!! warning "Hinweis"
	__Julia__ führt Multiple Dispatch nur basierend auf den __Nicht-Keyword__-Parametern durch.
"""

# ╔═╡ Cell order:
# ╟─a4ffae18-60a0-4fc8-bef2-3446b01da674
# ╟─499bbc21-0699-420e-abcd-ae8bd6c1f2c9
# ╟─83070547-600c-4fd8-ba5d-7682548e56a9
# ╟─9ef4d66d-7ad4-4d18-a178-8803374e94d5
# ╟─60d093b0-2ef5-43af-903f-20e0c5a7ec19
# ╟─fba2a471-b966-42ee-94eb-d443bf6215e2
# ╠═30b8295b-1d90-4a2b-9cb9-9acf327c4218
# ╠═39a8855e-b6c0-11ee-1f9a-9d3e956e7db1
# ╟─c82dbc2f-5c82-4959-8004-9cdc32cee1f9
# ╠═3d5f8c93-74bc-4c39-a820-73a9663df546
# ╟─791b845b-8b74-400c-9903-2fce205c84be
# ╠═de34b9f5-42ac-4056-84f9-4a69c9111995
# ╟─ea278e05-bf70-4a51-a62a-1df26ce75e26
# ╟─f258a47b-8569-4c38-ad3b-bfca60227430
# ╟─ea02c48a-024d-430d-8a61-d4fda91e0c73
# ╠═305e9ec4-4dcb-4537-b951-06bdba23c993
# ╟─ae506cf2-a277-44aa-bc88-ba646d9be677
# ╠═c154d88a-259c-4737-b75d-788b84dd0373
# ╟─4115d87f-df1b-4fdf-acdb-a0c9ee2d1492
# ╠═622ec6a8-9c4e-4de3-8a68-e5f9bef1d53d
# ╟─43457cf7-3eae-4746-9344-bf63922932f9
# ╠═cef9a963-8962-42ba-ac2a-e0109f877ac9
# ╟─0bd87716-3d9e-4202-90b8-0a43aeedd15f
# ╠═145256a7-6808-4f0b-b3a8-64c8f58a1ba5
# ╠═18d7054b-9ff9-485e-8747-b402f3d88836
# ╟─fee934b2-731c-4008-b9d7-95ef939cebac
# ╠═ab594ec8-d3dd-47fe-9fda-83880e2eeed0
# ╠═96cf72f3-e7e4-42fa-9bae-ed509c6b9f84
# ╟─1f4dfce3-a00d-4891-b1d5-7b9f6f73fed3
# ╠═741f53a5-0dd3-426d-928e-a3f48ef0ab92
# ╠═f5dd1bae-0286-4353-bb70-5ad1a9698dcb
# ╠═466552e9-d77d-4782-b6c0-5590ef422c01
# ╠═b816409b-bddf-4326-99b3-57e475be7c96
# ╟─6149491c-a510-4c4b-abef-f0c03415f6d1
# ╟─cac266fc-74ec-443c-9dc4-d1b1ceb67b39
# ╠═c05cc5a7-e639-4b32-8a8b-3e0ff86693cd
# ╠═3858d61c-819e-45bd-9255-7285da3f92cc
# ╟─ee59219c-52c0-4dce-9b7d-a5773feb4363
# ╟─1f9b4b44-ddc7-4406-9e2d-0bb0b0d1074a
# ╠═215aae07-b9ad-4e66-9429-d1aae1157c6b
# ╠═d4a20c15-35dd-4520-9f7c-a57d9a520044
# ╟─b213bdb0-cb10-449c-8a5b-32f76fc2cb99
# ╠═6caf40c3-fb6f-43e7-b838-8b80b63be12d
# ╠═7871f124-c4c3-4b52-8f03-ce4b27e021de
# ╠═17ae6ea3-91ff-4b0b-a91e-07277eeeb043
# ╠═e274597a-2bd2-4457-b121-81a7b91aa08e
# ╟─81ce68fb-3ddb-48d2-b512-8b25177eb10c
# ╠═2c01ed73-85b1-41f3-9160-36992c95025a
# ╟─a7be5c03-ffc6-4423-82a4-5fc0c8aa3797
# ╟─e5082f2c-14f1-4424-ab2a-e8dd35defcf9
# ╠═81f115dc-40ce-4ba3-981f-5672fa6d005e
# ╠═aeae585c-d0a3-4a85-bb15-48ecf0fefa9e
# ╟─d4a06545-8344-4f44-b311-4074d092035d
# ╠═cdbc00c8-5876-4d5f-abd7-8a71c4b1c17f
# ╠═c4cd1fc5-41de-43c4-bdd4-7d1ca3efff59
# ╠═eeb0a930-6cd4-4e71-a737-1c2cde7a4395
# ╟─c62b7a98-4697-432c-9ee5-f742b0b49c3f
# ╟─2c10bace-2e14-4889-84b4-757350904ac7
# ╟─acd031ea-7c64-48fd-b29b-96d3bce1972d
# ╠═39fe7968-8f5d-4c48-a36b-3dba5dce6f69
# ╟─e932e742-9d91-476b-b9e0-689ef0b13347
# ╠═c92328f5-d38f-4695-9635-83b972dafd86
# ╠═6cccde01-c01e-483f-8e74-3f046267f375
# ╟─15958b1c-4d67-464a-8c71-6efd1399d080
# ╠═31d28348-d45d-414f-bd51-570622710564
# ╟─f8cf4522-aead-4759-9c12-fd2f777f0cc9
# ╠═06abd980-1014-41c7-8756-095815da5840
# ╠═325c3efe-d2fa-4a53-a3dd-b69a7853c65e
# ╠═624200e6-3768-437d-8db6-7a7ae47bcfc2
# ╠═4f94e816-f7b2-4fa1-a4aa-0a54a9e0e602
# ╟─152938a5-0b34-4065-b57f-c7c3aca20733
# ╟─1258a5f5-d68c-432a-84a5-b1c8f3a974ca
# ╟─8f371ce4-d19b-4d14-be63-a2fb0abf0490
# ╠═6490cec7-132b-41c7-8a18-bebef37ed8e2
# ╟─05f03db9-7857-4ec2-b52f-12d867b1701c
# ╟─22fbb745-d780-4bb3-a760-d62372f7cbf5
# ╠═192cb4fd-e9e2-409c-b491-9f4742de0e8b
# ╠═84bda381-1b74-4aa4-a338-eeb3090c9736
# ╠═2856d8bf-077a-49b5-b879-1c1a7584d969
# ╟─ed912043-2c57-4a2f-956b-53da4f74d450
# ╠═a38c72a9-b6f7-4a3b-b50b-2dd3df6a8ccb
# ╠═0164400e-3e91-4536-8ad4-ef89ae9091ff
# ╠═c79db17c-f4e1-486c-85bb-f26605b749da
# ╠═25ed0976-0540-4a5f-8814-3c6b6a3e70b1
# ╟─2beda6e2-b087-4af0-beb1-ed40c552b10e
# ╠═39b4e8de-3288-471c-93f0-0c72c7c27cf4
# ╠═c6457e91-5237-42a6-bfe8-433ab67a74f3
# ╟─db1d8af7-1fcc-447d-9d2b-229309b30d11
# ╠═ea93e66b-d399-4f51-bd2d-dea7412006b9
# ╠═38cd5cd9-2c09-4535-91ea-5a0eec757960
# ╠═008c0b76-0a20-441f-ac36-23df3d507b3b
# ╟─7e894af8-e380-4ba6-9ce1-b14adec11ccf
# ╟─db880dd1-04d0-46d8-8f9a-a9e0f3b8a5bc
# ╠═af201f75-ae49-4cc8-bc3f-cdf32db1f3d0
# ╠═3d7172f2-e09a-440c-8320-1e0e2a9f39b2
# ╠═ba42f768-fe68-41c6-85f4-ab9cfd2d4699
# ╟─4a90ea54-990c-4e21-8408-2511d51bfd1b
# ╟─8661b042-9c11-44bf-8f81-8a4a9a0617a7
# ╟─ae5e8f3c-a557-4ad5-9496-a4ccc248b214
# ╠═c39a8e82-3685-4a1e-84fa-d9f38da220aa
# ╠═ef72707b-1404-48ce-8c46-486fc4b050ef
# ╠═a1261c62-b5f7-43be-8e2d-f428679fc9c5
# ╠═620c788e-f181-4d54-bc90-7b63521cb39f
# ╠═5440ce80-7aee-46e7-a684-d60d6177d4f0
# ╠═468348f0-b76c-4c88-936e-f11611871973
# ╠═bbd2707e-01e7-4d5e-969e-1bbfe606c826
# ╠═1747e51f-b41c-4e58-ae35-4c36731c59fb
# ╠═2e46e2b6-e50e-4e1f-91d5-b312d1cbd2a9
# ╠═8fd3673c-2c51-49ca-bd6a-52b7a5fe7287
# ╟─7bf7428f-74fd-45fd-a82f-82392f7426ad
# ╠═b0056396-ccce-4231-880b-da66679f0bad
# ╠═960ef5bb-61d0-4be8-a692-0b3ea210c97f
# ╠═f0537dd1-43f7-45b7-916a-4e6667872eda
# ╠═0413c29a-f343-44e7-9bb7-e406acc9b6b4
# ╠═95e3a054-a68f-42fc-86db-c8775e459eb1
# ╟─f19268af-b274-4cb4-9f03-98f2fc89cde9
# ╠═a8d30f0f-c1a8-4f11-acca-7f44652f4e12
# ╠═3a75a418-01b4-49f8-aad0-27ec95583a78
# ╠═8206e6ca-1052-4c40-989c-598b4cca0da3
# ╠═55815409-3d79-413e-9daf-cdaff41d68da
# ╠═63cf0c21-e7df-4004-b567-bcb68c0d3a61
# ╠═d2ee6938-bc50-446c-8164-be27d4caa202
# ╟─be4bdd0f-d74b-44b5-b459-a1a39a2cb579
# ╠═98e20c3e-0c67-458a-8a51-9996ea8e01e9
# ╟─bc1769f4-f588-4188-9fd2-0cde5db0e3d7
# ╠═5dd78c1e-cd73-4ef7-a173-6e5cbd5f048f
# ╠═a521c5ed-3c87-40cb-b623-b5c59a34cb6b
# ╠═4a6c28a9-063d-4779-b603-33c3c16678df
# ╟─0d147bfb-6c9e-4123-a08e-fdb29e1e4675
# ╠═235b50cc-5edc-43e4-b4ea-71c2efc0a226
# ╠═8003ce5d-9203-4192-a315-ce2070a0e98a
# ╠═e7d661bf-7734-42e4-83a5-7b577b2fdd3a
# ╟─28daea99-6b9e-45ac-b71f-7f877ba5852e
# ╟─8d74ef58-d9f1-46d7-92c9-c45b5635f764
# ╟─8977b7da-cf53-4aa9-bd9f-a198129971fc
