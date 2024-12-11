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
1. Entwickeln Sie ein System für einen Online-Shop in Julia. Erstellen Sie Klassen für Produkte, wie Electronics, Clothing und Books. Implementieren Sie eine Funktion `calculate_total_price`, die den Gesamtpreis basierend auf dem Warenkorbinhalt berechnet. Verwenden Sie Multiple Dispatch, um spezifische Berechnungsregeln für unterschiedliche Produkttypen und Sonderangebote anzuwenden.
2. Modellieren Sie ein Personalmanagementsystem für ein Unternehmen. Erstellen Sie Klassen für verschiedene Mitarbeiterrollen wie _Manager_, _Developer_ und _HumanResources_. Implementieren Sie eine Funktion `calculate_total_cost`, die die Summer der Gehälter aller Mitarbeiter basierend auf ihren Rollen berechnet. Verwenden Sie Multiple Dispatch, um unterschiedliche Gehaltsberechnungsmethoden für verschiedene Mitarbeiterrollen anzuwenden.
"""

# ╔═╡ bbfd3750-2509-479b-a0fc-a6eae4fe4ddf
md"Lösung 1: (gemeinsam mit KursteilnehmerInnen entwickelt)"

# ╔═╡ 9bae5c57-16fe-4db1-bf31-f2a826615039
abstract type Product end

# ╔═╡ 87d75f97-5884-4ea6-8d3d-38820ed21841
struct ElectronicDevice <: Product
	price::Float64
	name::String
	lager_bestand::Int64
end

# ╔═╡ 59c2f4f7-c0e3-4c0a-88d9-7c6fc11c434b
struct Book <: Product
	price::Float64
	name::String
	lager_bestand::Int64
	author::String
end

# ╔═╡ 36b7187a-947c-4e92-8278-7685649f48ba
struct Clothing <: Product
	price::Float64
	name::String
	lager_bestand::Int64
	size::Int64
end

# ╔═╡ 5950c637-fc4b-4068-bc82-cd871ff216c2
struct Warenkorb 
	inhalt::Array{Product}
end

# ╔═╡ eb20e818-56c7-4afc-951d-24d1cb7ad6bb
function ermittle_preis_nachlass(p::Product)
	println("behandlent Standardprodukt $(p.name)")
	if p.lager_bestand == 1
		return 50
	end
	return 0
end

# ╔═╡ 8e9ccddc-0029-4f3f-8db8-a16d489ce0ca
function ermittle_preis_nachlass(eg::ElectronicDevice)
	println("behandlen elektronisches Gerät $(eg.name)")
	if eg.name == "Fernseher"
		println("Fernseher ist billiger")
		return 10
	end
	return 0
end

# ╔═╡ 8da9d712-12d3-4e07-9561-3fdfbe40555b
book = Book(10,"Harry Potter Buch", 200, "J.K. Rowling")

# ╔═╡ add7cf41-29c1-46e8-9511-8ee7ff63dc79
skirt = Clothing(25, "Jeans Skirt", 1, 40)

# ╔═╡ 3446e0ec-300f-4572-a170-bbec89a87392
tv = ElectronicDevice(2000,"Fernseher",20)

# ╔═╡ f3c37b15-76b0-48d4-b38a-11165c4a6044
function preis_ermitteln(p::Product)
	nachlass = ermittle_preis_nachlass(p)
	return p.price - p.price*nachlass/100
end

# ╔═╡ 57884ed0-265a-4466-a976-118a6d0fb1db
preis_ermitteln(skirt)

# ╔═╡ 1dbaa405-d613-479a-9d72-4da867e2b74e
calculate_total_price(w::Warenkorb) = sum(preis_ermitteln.(w.inhalt))

# ╔═╡ 4692577a-a407-4a1a-adeb-522270514285
function calculate_total_price_old(w::Warenkorb)
	preis = zero(Float64)
	for p in w.inhalt
		preis += preis_ermitteln(p)
	end
	preis
end

# ╔═╡ a0b9fd82-697a-4906-a890-4831daf5c3bf
w = Warenkorb([book, skirt, tv])

# ╔═╡ 881c7ecf-bebf-46cd-85f6-6fdd64c996a3
calculate_total_price(w)

# ╔═╡ e0e83386-ce03-4573-9b94-b74b1d1cb5c1
calculate_total_price_old(w)

# ╔═╡ 9b9d0839-edf0-4b18-8d2b-1fa88ec7599e
md"Lösung 2:"

# ╔═╡ 4c084de1-2b34-4d8b-bcc9-6987abfc1e97
abstract type Employee end

# ╔═╡ c4b171ae-e3e6-4454-a000-1ead50cfd039
begin
	struct Manager <: Employee
		first_name:: String
		last_name:: String
		income:: Float64
		bonus:: Float64
	end
	struct Developer <: Employee
		first_name:: String
		last_name:: String
		income:: Float64
	end
	
	struct HumanResources <: Employee
		first_name:: String
		last_name:: String
		income:: Float64
		bonus:: Float64
		hired_people::Int64
	end
end

# ╔═╡ ec84a8fe-6ce8-46ca-96fe-d6930c1faee4
income(person::Manager) = person.income + person.bonus

# ╔═╡ e4a806e9-61bc-4eed-94fe-778c5f6df8b8
income(person::Developer) = person.income

# ╔═╡ 6eec9e98-47fa-40ab-a5ec-5f995af80368
function income(person::HumanResources) 
	inc = person.income
	if person.hired_people > 0
		inc += person.hired_people*person.bonus
	end
	inc
end

# ╔═╡ 2b8744ca-79cb-4eb7-986d-6c3f8b4eaed1
manager = Manager("Elon", "Musk",1.2,1111111)

# ╔═╡ cc73ed9f-7bae-481a-896b-3350b8b5ed5e
developer = Developer("Bill","Gates",3500.0)

# ╔═╡ ffb37545-52eb-42c8-ba35-81ef2ab935be
human_resources = HumanResources("Nadin","Mustermann",1500.0, 500.0,3)

# ╔═╡ 16316825-0338-4846-bdba-cca1343592d1
employees = [manager, developer, human_resources]

# ╔═╡ 444cd15f-00ed-4534-8fc5-918fed116ad2
map(f->income(f),employees)

# ╔═╡ e1bebe99-2e9c-4224-bc86-84413b3afe37
calculate_total_cost(employees::AbstractArray{Employee}) = 
sum(map(income, employees)) # hier habe ich `income` als Funktion-Zeiger genutzt
# äquivalent könnte man schreiben: sum(map(e -> income(e), employees))
	

# ╔═╡ 24e005e1-9af5-498d-aea9-f8fb8a05c53f
calculate_total_cost(employees)

# ╔═╡ 8977b7da-cf53-4aa9-bd9f-a198129971fc
md"""

!!! warning "Hinweis"
	__Julia__ führt Multiple Dispatch nur basierend auf den __Nicht-Keyword__-Parametern durch.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
LaTeXStrings = "~1.4.0"
Plots = "~1.40.9"
PlutoUI = "~0.7.60"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.7"
manifest_format = "2.0"
project_hash = "c3136400e4f0b80db08a38a6dc140c30df9da185"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "8873e196c2eb87962a2048b3b8e08946535864a1"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+2"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "009060c9a6168704143100f36ab08f06c2af4642"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.2+1"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "c785dfb1b3bfddd1da557e861b919819b82bbe5b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.27.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "64e15186f0aa277e174aa81798f7eb8598e0157e"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "ea32b83ca4fefa1768dc84e504cc0a94fb1ab8d1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.2"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fc173b380865f70627d7dd1190dc2fce6cc105af"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.14.10+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cc5231d52eb1771251fbd37171dbc408bcc8a1b6"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.4+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "53ebe7511fa11d33bec688a9178fac4e49eeee00"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.2"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "db16beca600632c95fc8aca29890d83788dd8b23"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.96+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "fa8e19f44de37e225aa0f1695bc223b05ed51fb4"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.3+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1ed150b39aebcc805c26b93a8d0122c940f64ce2"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.14+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "532f9126ad901533af1d4f5c198867227a7bb077"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+1"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "ee28ddcd5517d54e417182fec3886e7412d3926f"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.8"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f31929b9e67066bee48eec8b03c0df47d31a74b3"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.8+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "b36c7e110080ae48fdef61b0c31e6b17ada23b33"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.82.2+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "01979f9b37367603e2848ea225918a3b3861b606"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+1"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ae350b8225575cc3ea385d4131c81594f86dfe4f"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.12"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "401e4f3f30f43af2c8478fc008da50096ea5240f"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.3.1+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "71b48d857e86bf7a1838c4736545699974ce79a2"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.9"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "be3dc50a92e5a386872a493a10050136d4703f9b"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "25ee0be4d43d0269027024d75a24c24d6c6e590c"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.4+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "36bdbc52f13a7d1dcb0f3cd694e01677a515655b"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.0+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "854a9c268c43b77b0a27f22d7fab8d33cdb3a731"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+1"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "8be878062e0ffa2c3f67bb58a595375eda5de80b"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.0+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c6ce1e19f3aec9b59186bdf06cdf3c4fc5f5f3e6"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.50.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "61dfdba58e585066d8bce214c5a51eaa0539f269"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "84eef7acd508ee5b3e956a2ae51b05024181dee0"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.2+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "b404131d06f7886402758c9ce2214b636eb4d54a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "edbf5309f9ddf1cab25afc344b1e8150b7c832f9"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.2+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7493f61f55a6cce7325f197443aa80d32554ba10"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.15+1"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e127b609fb9ecba6f201ba7ab753d5a605d53801"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.54.1+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "dae01f8c2e069a683d3a6e17bbae5070ab94786f"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.9"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "492601870742dcd38f233b23c3ec629628c1d724"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.7.1+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "e5dd466bf2569fe08c91a2cc29c1003f4797ac3b"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.7.1+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "1a180aeced866700d4bebc3120ea1451201f16bc"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.7.1+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "729927532d48cf79f49070341e1d918a65aba6b0"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.7.1+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "83e6cce8324d49dfaf9ef059227f91ed4441a8e5"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5cf7606d6cef84b543b483848d4ae08ad9832b21"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.3"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "d95fe458f26209c66a187b1114df96fd70839efd"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.21.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "a2fccc6559132927d4c5dc183e3e01048c6dcbd6"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.5+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "a54ee957f4c86b526460a720dbc882fa5edcbefc"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.41+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "15e637a697345f6743674f1322beefbc5dcd5cfc"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.6.3+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "326b4fea307b0b39892b3e85fa451692eda8d46c"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.1+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "3796722887072218eabafb494a13c963209754ce"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2b0e27d52ec9d8d483e2ca0b72b3cb1a8df5c27a"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+1"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "02054ee01980c90297412e4c809c8694d7323af3"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+1"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d2d1a5c49fae4ba39983f63de6afcbea47194e85"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "47e45cd78224c53109495b3e324df0c37bb61fbe"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+0"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee57a273563e273f0f53275101cd41a8153517a"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+1"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "bcd466676fef0878338c61e655629fa7bbc69d8e"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b9ead2d2bdb27330545eb14234a2e300da61232e"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+1"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "555d1076590a6cc2fdee2ef1469451f872d8b41b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6e50f145003024df4f5cb96c7fce79466741d601"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.56.3+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "b70c870239dc3d7bc094eb2d6be9b73d27bef280"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.44+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
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
# ╟─bbfd3750-2509-479b-a0fc-a6eae4fe4ddf
# ╠═9bae5c57-16fe-4db1-bf31-f2a826615039
# ╠═87d75f97-5884-4ea6-8d3d-38820ed21841
# ╠═59c2f4f7-c0e3-4c0a-88d9-7c6fc11c434b
# ╠═36b7187a-947c-4e92-8278-7685649f48ba
# ╠═5950c637-fc4b-4068-bc82-cd871ff216c2
# ╠═eb20e818-56c7-4afc-951d-24d1cb7ad6bb
# ╠═8e9ccddc-0029-4f3f-8db8-a16d489ce0ca
# ╠═8da9d712-12d3-4e07-9561-3fdfbe40555b
# ╠═add7cf41-29c1-46e8-9511-8ee7ff63dc79
# ╠═3446e0ec-300f-4572-a170-bbec89a87392
# ╠═f3c37b15-76b0-48d4-b38a-11165c4a6044
# ╠═57884ed0-265a-4466-a976-118a6d0fb1db
# ╠═1dbaa405-d613-479a-9d72-4da867e2b74e
# ╠═4692577a-a407-4a1a-adeb-522270514285
# ╠═a0b9fd82-697a-4906-a890-4831daf5c3bf
# ╠═881c7ecf-bebf-46cd-85f6-6fdd64c996a3
# ╠═e0e83386-ce03-4573-9b94-b74b1d1cb5c1
# ╟─9b9d0839-edf0-4b18-8d2b-1fa88ec7599e
# ╠═4c084de1-2b34-4d8b-bcc9-6987abfc1e97
# ╠═c4b171ae-e3e6-4454-a000-1ead50cfd039
# ╠═ec84a8fe-6ce8-46ca-96fe-d6930c1faee4
# ╠═e4a806e9-61bc-4eed-94fe-778c5f6df8b8
# ╠═6eec9e98-47fa-40ab-a5ec-5f995af80368
# ╠═2b8744ca-79cb-4eb7-986d-6c3f8b4eaed1
# ╠═cc73ed9f-7bae-481a-896b-3350b8b5ed5e
# ╠═ffb37545-52eb-42c8-ba35-81ef2ab935be
# ╟─16316825-0338-4846-bdba-cca1343592d1
# ╠═444cd15f-00ed-4534-8fc5-918fed116ad2
# ╠═e1bebe99-2e9c-4224-bc86-84413b3afe37
# ╠═24e005e1-9af5-498d-aea9-f8fb8a05c53f
# ╟─8977b7da-cf53-4aa9-bd9f-a198129971fc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
