### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 608469ba-9f6c-11ee-3740-fff2920aac1c
begin
	using PlutoUI, Images, FileIO
	TableOfContents()
end

# ╔═╡ 211891dd-5811-454d-9530-49ed28d6adfe
md"""
# Einführung in Julia - Kurstag 2
__Datentypen und Operatoren__
"""

# ╔═╡ 127de8a6-c092-438f-9cb0-83532a5343c7
md"""
## Numerische Datentypen
"""

# ╔═╡ 12606683-a23d-4b5e-acc2-94634ff6fe89
load("./assets/Numerische_Typen_Julia.png")

# ╔═╡ 36ec497f-191b-4b06-ac39-52aa4ac05f92
md"""
### Datentypen 
"""

# ╔═╡ 8fdce7cf-06f8-4d5d-924e-242a06af3679
md"""
Man unterscheidet im obigen Diagramm zwischen __konkreten__ und __abstrakten__ Typen. 
Die __abstrakten__ Typen lassen sich __nicht__ erzeugen, sondern stellen nur __gemeinsames__ Verhalten dar.

Die __konkreten__ Typen sind:
- Int128, Int64, Int32, Int16, Int8: vorzeichenbehaftete ganze Zahlen
- UInt128, UInt64, UInt32, UInt16, UInt8: __nicht__ vorzeichenbehaftete ganze Zahlen
- BigInt: vorzeichenbehaftete ganze Zahlen mit beliebiger Präzission
- Bool: die Wahrheitswerte: wahr (true) und falsch (flase)
- Rational: Brüche von ganzen Zahlen 
- Float64, Float32, Float16: Gleitkommazahlen
- BigFloat: Gleitkommazahlen mit beliebiger Präzission
- Complex: komplexe Zahlen, wobei Real- und Imaginärteil reelle Zahlen sind
"""

# ╔═╡ 29353080-35bb-4867-b63c-3521f56a9927
md"""
!!! tip
	Mit dem Kommando `typeof` kann man sich den konkreten Datentyp einer Variable oder einer Wertes anzeigen lassen.
"""

# ╔═╡ 0c6a2a3f-1f08-4e45-94dc-427702713c75
typeof(2)

# ╔═╡ 2a012a0e-ca83-49cb-aaed-c5146ec78a13
md"""
!!! tip
	Mit dem Kommando `bitstring` kann man sich die Binärdarstellung einer beliebigen Zahl anzeigen lassen.
"""

# ╔═╡ f473b5a4-eccf-4020-8c8d-33caddd85826
bitstring(2)

# ╔═╡ ffd5929c-51b8-4cdb-8285-4e15026d9875
length(bitstring(2))

# ╔═╡ 4f133e9d-b916-41da-9251-3514fcf9f5a9
md"""
!!! warning "Achtung"
	Die Binary-Darstellung hängt vom Datentype ab, d.h. `Int64` hat eine 64-bit-Darstellung.
"""

# ╔═╡ ef37041d-0b4d-4204-9c22-9ce7d7952af7
md"""
Möchte man mit kleineren Datentypen arbeiten, so geht dies auch. Das obige `Int64` ist der Standard für `Integer` auf meinem Computer.

Hier Beispiele für kleinere Darstellungen:
"""

# ╔═╡ 34cf8b22-9da3-4ab1-ba1c-0a3a1e83ee29
Int8(1)

# ╔═╡ 0cca4b3e-3cd2-4af9-b7e4-d1b8f137301f
typeof(Int8(1))

# ╔═╡ 51ecbb07-d338-404e-b9ae-9701e75e4d73
bitstring(Int8(1))

# ╔═╡ aabb2fb0-06d7-43d7-8805-edb8beb8fd5c
length(bitstring(Int8(1)))

# ╔═╡ 0c8425d7-71fd-4553-a835-4bb38561309b
md"""
!!! note "Bemerkung"
	Die Zahl hinter dem Typ steht für die Anzahl der zur Darstellung im Binärformat genutzten Bits.
"""

# ╔═╡ f6a7952a-c5c4-4e32-904c-e85dacf1713e
md"""
Wir schauen uns jetzt an, wie das Vorzeichen für ganze Zahlen (Integer) behandelt wird.
"""

# ╔═╡ 02d72773-37ea-4ebd-9c6f-ccd51d96f4b7
Int8(-1)

# ╔═╡ f07a1e5a-c465-499b-a92e-d9b91a1c776d
bitstring(Int8(-1))

# ╔═╡ 817860ac-b284-4b02-865a-207cec9fc8ff
md"""Dies Darstellung erscheint zunächst komisch, aber wir können sie verstehen.
Dazu stellen wir allen Integer-Zahlen von ihrem maximalen bis zu ihrem minimalen Wert da.
"""

# ╔═╡ 42af2d00-1dbe-40bd-9031-3da3cbd2d0b4
md"""
!!! tip
	Mit den Kommandos `typemin` und `typemax` erhält man die minimale und maximale Zahl des betrachteten Zahlentyps.
"""

# ╔═╡ ec3a9cfd-dec4-47bb-8dd2-9df5a08a918b
typemax(Int8)

# ╔═╡ f9bb8c82-6cce-462b-a936-4ab823d683ae
typemin(Int8)

# ╔═╡ 67f8ef07-4093-471b-883d-9551042aace9
begin
	println("8 Bit Integer-Zahlen mit Vorzeichen (achte auf das Vorzeichen-Bit)\n")
	println("Number \t Binary")
	int8_min = typemin(Int8)
	int8_max = typemax(Int8)
	for n in int8_max:-1:int8_min
	    if n ∈ -int8_min:-120 || n ∈ -5:5 || n ∈ 125:int8_max
	        println(n, ":\t", bitstring(Int8(n)))
	    elseif n ∈ union(-119:-117,6:8)
	        println("\t   .")
	    end
	end
end

# ╔═╡ 5f22ef4b-5cc9-4c04-814a-de81a49450ca
md"""
!!! note "Bemerkung"
	Die Binärdarstellung der ganzen Zahlen (Integer) mit Vorzeichen ist aufsteigenden von der kleinsten Zahl bis zur -1 und ab der Null wieder aufsteigende bis zur größten Zahl. Das vorderste Bit ist das Vorzeichen-Bit.
"""

# ╔═╡ f603f393-34b6-4c09-b842-13ca35f2ccf8
md"""
#### Übung 1: Standard-Datentyp UInt8 
(ganze Zahlen ohne Vorzeichen)
1. Bestimme den maximalen und minimalen Wert des Typs `UInt8`.
2. Passe obige Ausgabe für `Int8` so an, dass Du das Ergebnis für `UInt8` erhälst. 
3. Wie sieht die obige Ausgabe aus?
"""

# ╔═╡ cef22301-06ee-4897-ae53-497cd9946c8a
md"Lösung 1:"

# ╔═╡ 7021d829-bde7-4121-9eab-6c3ef14a7960
Int(typemax(UInt8))

# ╔═╡ 59821bea-21ea-4528-bcb6-ee8a773f5947
md"Lösung 2:"

# ╔═╡ 5376a7f5-6e88-4b73-8a41-dd4280ac2caa
md"Im obigen Programm Int8 durch UInt8 ersetzen."

# ╔═╡ 693e21ee-d95e-49b5-b144-213b4b2983b9
md"Lösung 3:"

# ╔═╡ a775cd14-0cdd-4118-b3f0-aef2ff9e7f0a
md"Es werden die Zahl von 0 bis 255 in als ganze Zahlen und in Binärdarstellung ausgegeben."

# ╔═╡ 9204fd20-c3c6-48cf-acdb-2a3f1fab054e
md"""
### Operationen 
#### Unäre (einseitige) Operatoren
"""

# ╔═╡ 47e68e27-144c-46df-b180-6b491e9d9bde
md"Unärer Plus-Operator (oder einfach Identität):"

# ╔═╡ d9f6b662-c8ca-4a1a-ac09-4798ca45b841
+1

# ╔═╡ cef7c017-4595-4b92-8962-d9832f10e00c
md"Unärer Minus-Operator (Abbildung auf das additive Inverse):"

# ╔═╡ b96bde8f-4cbc-4ce8-b43b-70c58ed5fb64
-1

# ╔═╡ 2ea1bc14-9e91-41d3-afd4-428f4503df0e
md"#### Binäre Operatoren"

# ╔═╡ 187c092e-ad8c-4402-aa05-e0733b336550
md"Addition:"

# ╔═╡ f6f4c530-23d1-4293-9cd3-a83251f67f11
1+1

# ╔═╡ 77e17d76-7b5b-4b89-89a1-7e889530490b
md"Subtraktion:"

# ╔═╡ ef89de7f-6843-40e2-beef-61a09bb914eb
1-2

# ╔═╡ 14dd583e-bb89-4ad4-887e-513423a637a9
md"Multiplikation:"

# ╔═╡ 3288a869-9891-4177-8cbf-e6ed3e3c80bf
5*2

# ╔═╡ e2906acf-65d5-4b2e-ab58-15521392a02d
md"Division: nur Ganzzahlquotient"

# ╔═╡ 59c7602c-14be-4faa-81ff-387d730581e7
7 ÷ 2

# ╔═╡ c6e7aa1e-b67c-4fca-94c4-afad62e2fd17
7 % 2

# ╔═╡ 5a34c57e-5885-4df4-8305-5cb0391ef229
md"Dies ist das Gleiche wie: div(2,2) = $(div(2,2))"

# ╔═╡ 911930fd-54ce-4f89-b2de-a6b85c1ac378
md"Division mit Rest: "

# ╔═╡ ef92e922-3637-4f97-9012-17ddfe8823a0
typeof(3/2), 3/2

# ╔═╡ b4d55262-321d-4870-a06f-fb3dfe3c897f
typeof(2/2), 2/2

# ╔═╡ b447d086-52d2-4f05-be0b-6f3deabfd9f1
md"(hier geben wir zwei Werte bei der Zelle zurück)"

# ╔═╡ 6ff1fbaf-8551-4bf7-8bed-648fc7b07d7c
md"""
!!! warning "Achtung"
	Durch verschiedene Operationen (/) verlässt man die ursprüngliche Zahlendomäne. Dies ist natürlich analog der Mathematik, aber im Gegensatz zur Mathematik unterscheiden sich die Typen von 2 (Int) und 2.0 (Float).
"""

# ╔═╡ 52d76ceb-257d-4664-973c-9dc073a2f9f9
md"Exponenzieren:"

# ╔═╡ e0144d69-0bca-4e2e-938b-3e34ca8680c8
2^3

# ╔═╡ 18181c18-f307-4ecc-99ca-0ec263d062c7
md"Teilungsrest:"

# ╔═╡ 83c1be17-dda5-472b-9208-e75a13118601
3 % 2

# ╔═╡ 0757fc13-1ac5-44f7-b8d8-52a4a77bbed8
md"""
oder in anderer Notation:

mod(3,2)=$(mod(3,2))
"""

# ╔═╡ f6890cae-3312-4fcd-9efa-99336f533b24
md"#### Einfaches Beispiel für Nutzung von Operatoren"

# ╔═╡ 8a3b198e-b799-4871-94a9-d75686986857
m = 95

# ╔═╡ aaaafde9-cd2d-43c7-bab6-7ef2450391a4
c = 299_792_458 # _ wird hier als genutzt, damit wir die Zahl einfacher lesen und schreiben können

# ╔═╡ bf787872-d71a-4a3a-a506-b3cc9e618797
E = m*c^2

# ╔═╡ 99c28994-c077-47af-9764-799ab6c849f1
md"""
#### Übung 2: Übertragung auf andere numerische Datentypen
1. Übertrage die obigen Operationen auf andere numerische Datentypen?
2. Welche Operationen führen aus der Domäne der ursprünglichen Zahlen hinaus?
3. Untersuche den Datentyp: Rational. 
4. Was passiert, wenn man √-1 ausrechnet? 
"""

# ╔═╡ 29f8237b-68e9-4f4c-b877-0e7c12e1c70f
md"Lösung 2:"

# ╔═╡ 7eab6123-7c04-47be-8e65-721f63861e46
md"Die Domänengrenzen werden wie in der Mathematik überschritten. Ein Beispiel:"

# ╔═╡ bd4af97c-e67b-459b-9fb8-37705b2ef870
2/3 # Int durch Int --> Float

# ╔═╡ 09a473ba-1fa8-4b38-af9a-d68669d83f34
md"Lösung 3:"

# ╔═╡ 660f4a6f-d32f-4a94-aad2-20e022a6d860
md"Verschiedene Beispiel sind [hier](https://docs.julialang.org/en/v1/manual/complex-and-rational-numbers/#Rational-Numbers) zu finden."

# ╔═╡ 400df166-de80-466a-981d-16d8acfdd7e5
md"Lösung 4:"

# ╔═╡ 52e96842-4c23-47e4-80c7-1a0e1cf9b55d
#sqrt(-1) # führt zu Fehler (für Lösung siehe entsprechenden Kommentar)

# ╔═╡ 2ee60d80-de03-42b6-9343-7f0779e79452
md"""### Operatorrangfolge"""

# ╔═╡ 1e0f1b46-cff6-4b3c-829f-637e9c6e9533
md"""
!!! tip
	Die Operatorrangfolge ist wie in der Mathematik und lässt sich z.B.: durch die Merkregel:

	__KlaPoPuS (Klammer vor Potenz vor Punkt vor Strich)__

	erinnern.
"""


# ╔═╡ eadf6143-781e-411c-ab2f-e04d26797803
1+(3+4)^2*5

# ╔═╡ 76feca8f-39ed-4cc5-9be2-98f366da2cc8
1+7^2*5

# ╔═╡ ae984997-3119-486f-b3ec-5fc5a171f5eb
1+49*5

# ╔═╡ 9362ef16-a700-4bcf-a475-c0633e5df42a
1+245

# ╔═╡ aace03b3-2285-4739-b17e-7e87613bf4dc
md"""
Eine Übersicht über alle unterstützten numerischen Operatoren kann man hier finden:

[https://docs.julialang.org/en/v1/manual/mathematical-operations/](https://docs.julialang.org/en/v1/manual/mathematical-operations/)
"""

# ╔═╡ ea358f14-f3b8-4b98-8354-9b22c830f88c
md"""
#### Übung 3: 
1. Welchen `Julia`-Ausdruck muss man eingeben, damit man folgenden Bruch ausrechnet:

$\frac{3-2}{4-1}$

2. Welches ist der korrekte `Julia`-Ausdruck für:

$2^{4-2}$ 

3. Welcher der Ausdrücke liefert ein anderes Ergebnis:

   a. $(2-3)-4$

   b. $2-3-4$

   c. $2-(3-4)$

   Warum? Was ist links-assoziativ?
4. Wie sieht es mit dem `Julia`-Ausdruck 2^3^4 aus? Wie werden die Klammern hier automatisch gesetzt?
"""

# ╔═╡ 1555e3b8-bc05-4c99-8b9f-3fc1291e7626
md"Lösung 1:"

# ╔═╡ e073468c-7a71-4f79-8250-3ef40c269366
(3-2)/(4-1)

# ╔═╡ 8c6817e7-67dd-46ce-9040-42a0eda29664
md"oder:"

# ╔═╡ 6fa5cd27-4d3b-468d-8ef6-fe3c698585e2
(3-2)//(4-1)

# ╔═╡ 6d35b180-b78c-4f2f-afb9-023d00db462c
isapprox((3-2)//(4-1),(3-2)/(4-1))

# ╔═╡ 62007b66-8b7c-4469-8525-c120bd2a7fbb
md"Lösung 2:"

# ╔═╡ 7a66d7fc-30b4-49b8-a051-b250464f7be7
2^(4-2)

# ╔═╡ d9969360-3f88-41c5-bbde-07bb20e62299
md"Lösung 3:"

# ╔═╡ 8cbb96df-5cdc-4d3f-9437-159b05445b9a
(2-3)-4, 2-3-4, 2-(3-4)

# ╔═╡ 7f4e79af-797e-42cb-9fde-ef6d4801f7da
md"Da die Standardauswertung links assoziativ  ist, ist die Auswertung von 2-3-4 und (2-3)-4 gleich."

# ╔═╡ f82751f5-bdf6-4adf-82c6-2d07bf3c1ffb
md"Lösung 4:"

# ╔═╡ 9a226454-4dc0-4e94-829b-35cd0042891e
2^3^4, (2^3)^4, 2^(3^4)

# ╔═╡ 430b5b21-714f-4bf1-b650-ed10a31aed80
md"Das ist komisch. Hier wird das Maximum der betrachteten Typen $(typemax(Int64)) relevant, der kleiner ist als $(BigInt(2)^BigInt(3)^BigInt(4)), wie man durch der Vergleich erreicht: $(typemax(Int64)<BigInt(2)^BigInt(3)^BigInt(4))"

# ╔═╡ 571a7d02-2955-4e8b-8dbd-c538d4b819f0
2^3.0^4, (2^3.0)^4, 2^(3.0^4)

# ╔═╡ 3b1f09df-875c-4e05-bf56-b2ac1e84de95
md"""
## Zeichen und Zeichenketten
### Zeichen
"""

# ╔═╡ d4260739-a6c8-4f02-96b9-279abb0e11b0
md"""
!!! tip
    Zeichen (Char) lassen sich in Julia durch einfach Hochkommata erzeugen.
"""

# ╔═╡ b416d9c8-803b-4e3e-b66b-7e20c89f96bb
'a'

# ╔═╡ 65fcd88e-09ca-4079-9d7d-e395f1382b2d
typeof('a')

# ╔═╡ 0b84a9df-149b-4690-bfa1-078943b2e4b3
Int(codepoint('a'))

# ╔═╡ 59f6cb34-24e8-48a9-882e-310f1a78a1d4
Char(codepoint('a'))

# ╔═╡ 8713df22-2846-41d4-abcd-006795a6b758
md"Alle Zeichen bis $(Int(typemax(UInt8)))"

# ╔═╡ 6f0af6be-69fd-42c1-98da-c868eb5f3948
for i in 1:typemax(UInt8)
	println(i,":\t", Char(UInt8(i)))
end

# ╔═╡ 8894c690-9a0c-40d7-ac74-708a1218ada4
md"""
### Zeichenketten (String)
"""

# ╔═╡ fa56dc37-eeb8-4b40-a54c-6b586c85ee9a
md"""
!!! tip
    Zeichenketten (String) lassen sich in Julia durch Anführungszeiche erzeugen.
"""

# ╔═╡ 71024eb6-380e-4a48-ac67-e3d0ece3e0b7
"Dies ist ein String"

# ╔═╡ 63fd5865-df42-4883-a8b0-75645a6ebbb2
typeof("Dies ist ein String")

# ╔═╡ eeabf882-a967-4137-9ea3-09487055d9ec
md"""
Man kann auch Strings erzeugen, die über mehrere Zeilen gehen:
"""

# ╔═╡ 0e575a99-ea33-4902-920f-11938594fe5b
"""    ein
          mehrzeiliger
				String
"""

# ╔═╡ f93c55c6-cb45-422d-8e07-359105252446
md"""
### Zeichenketten-Verkettung (Concatination)
"""

# ╔═╡ 543bf419-6dfd-44c0-b7af-220e99d7346c
md"""
Im Gegensatz zu anderen Programmiersprachen wird in Julia die Verkettung (Concatination) von Zeichenketten mit dem `*`-Operator durchgeführt.
"""

# ╔═╡ b1c68c08-2f35-4a2f-82cc-ade0af44cdef
begin
	s1 = "Hallo"
	s2 = "Welt!"

	s1*" "*s2
end

# ╔═╡ e4fc9ce0-b7c2-4686-9e47-832145654e18
md"""
Da der `*`-Operator ebenfalls für Multiplikation genutzt wird, wird eine analoge Behandlung bei der Exponential-Schreibweise von Zeichenketten genutzt. Hier ein Beispiel:
"""

# ╔═╡ 1fef8d2e-17bc-4de0-8fc3-3e48ab8ef732
(s1*" ")^3*s2

# ╔═╡ eb74a0a2-fdd9-4fd1-a810-9fbf8663f435
md"""
Außerdem kann man folgendes Konstrukt verwenden:
"""

# ╔═╡ 89a42b4c-e44b-46eb-b904-01530bc075ee
string(s1," ",s2)

# ╔═╡ 709f786b-e2e9-4f6f-a334-a6fda3c28abe
md"""
### Zeichenketten-Interpolation
"""

# ╔═╡ 6b49e12d-426b-431e-9422-4646bcbc8294
begin
	s3 = "KursteilnehmerInnen"
	s4 = "Hallo $s3"
end

# ╔═╡ 6927ab20-a886-4657-89da-8a6b53c769b5
md"""
Möchte man eine auch Berechnungen innerhalb einer Zeichenkette durchführen, so geht dies mit der Interpolation.
"""

# ╔═╡ bc7bc37e-22a9-4aa9-bd8a-cd2b8ede3016
#Radius
r=3

# ╔═╡ 679e9257-4c43-4544-bd9f-6cbf629738be
"Der Umfang des Kreises mit Radius R ist U=$(2*π*r) und die Fläche A=$(π*r^2)"

# ╔═╡ 5519a33e-d60d-4b7a-942f-f74939746d43
md"""
#### Übung 4: 
1. Bestimme die Länge eines Strings (Zeichenkette).
2. Wiederhole eine Zeichenekette durch Modifikation eines [Sliders](https://featured.plutojl.org/basic/plutoui.jl) in einem Bereich zwischen 0 und 1000 Mal. Gebe die Länge der resultierenden Zeichenkette aus. Die Verwendung von Pluto ist dafür notwendig.
3. Verwende Funktionen wie occursin, um das Vorhandensein eines Unterstrings zu überprüfen, und replace, um einen Teil des Strings zu ersetzen.
4. Erforsche weitere String-Funktionen in Julia, wie zum Beispiel strip, split, join und repeat.
"""

# ╔═╡ 334695dc-9c14-449e-bd70-b83cf94430cb
md"Lösung 1:"

# ╔═╡ 1c9a33f8-3156-4253-8caa-d72d66d25797
test_string="Hallo Frank, "

# ╔═╡ 7b5b381a-6c9d-40f9-8da4-28a9ca4f1b26
length(test_string)

# ╔═╡ 299d68e2-8e16-455e-a926-329e48900a12
md"Lösung 2:"

# ╔═╡ 7f1f0b4d-5887-40aa-80e8-829bc0064395
@bind faktor Slider(0:1000, show_value=true, default=5  )

# ╔═╡ e9bbff3b-b584-4b15-9409-00dc04ce1e16
test_string^faktor

# ╔═╡ 346b0816-0714-465b-bfa3-ae32fe170d87
length(test_string^faktor)

# ╔═╡ f0948abe-4447-4789-b7d8-2446b9a0a983
length(test_string)*faktor

# ╔═╡ efc57d33-aa5d-4f8c-87c2-b36a388daa3a
md"""
## Boolsche Logik und bedingte Ausdrücke

Um die logischen Ablauf (Control flow) von Programm zu kontrollieren benutzen Programmiersprachen Boolsche Logik und bedingte Ausdrücke.

### Boolsche Logik

In der Boolschenn Logik kennt man verschiedene Operatoren und Gesetze. Siehe hierzu [https://de.wikipedia.org/wiki/Boolesche_Algebra](https://de.wikipedia.org/wiki/Boolesche_Algebra).

Julia nutzt dazu den Datentyp: [__Bool__](https://docs.julialang.org/en/v1/base/numbers/#Core.Bool), der nur zwei Werte annehmen kann.

- true (== 1)
- false (==0)
"""

# ╔═╡ c532c3a0-8c57-4b8c-846b-7f482fde61e7
true == 1

# ╔═╡ 73646c2b-79f8-44d4-a366-76bac145cb2b
true == 0

# ╔═╡ 750f16f6-47e7-4698-a683-0a54b9e31772
false == 1

# ╔═╡ 56bde8fb-c208-4de6-a361-ea15e6b8197a
false == 0

# ╔═╡ 6ede7c13-08b7-466f-a754-c6a84307d573
md"""
#### Und-Verknüpfung

Die Und (AND)-Verknüfpung && erfüllt die folgende Wahrheitstabelle:
```math
\begin{array}{|c|c|c|}
 x & y & x \mbox{ \&\& } y \\
\hline
false & false & false \\
true & false & false \\
false & true & false \\
true & true & true
\end{array}
```
"""

# ╔═╡ 4a64eabf-ecf9-414e-b07a-419f74f4c5b1
false && false

# ╔═╡ 1843deeb-12f5-4951-8dea-737bc4170662
true && false

# ╔═╡ 11f4fe9e-9e8e-42b5-a40a-4f7fc57b5f2d
false && true

# ╔═╡ 105cf711-666f-4579-b51a-a125d7f031c5
true && true

# ╔═╡ b48c2a2f-0894-4b30-ab8d-7f0958a684c2
md"""
#### Oder-Verknüpfung

Die Oder (OR)-Verknüfpung || erfüllt die folgende Wahrheitstabelle:
```math
\begin{array}{|c|c|c|}
 x & y & x \mbox{ || } y \\
\hline
false & false & false \\
true & false & true \\
false & true & true \\
true & true & true
\end{array}
```
"""

# ╔═╡ 69e311ea-56c3-4768-9a72-e5e681c9dbf8
false || false, true || false, false || true, true || true

# ╔═╡ baf58134-1cd6-4470-8167-073970517c6d
md"""
!!! tip
    Umgangsprachlich entspricht das `oder` mehr dem exklusiven ODER (XOR) in der Programmierung. Man spricht hier auch vom entweder oder.
"""

# ╔═╡ 3d9dd161-663f-40e8-b524-4193c29196ba
md"""
#### Exklusives Oder (XOR)-Verknüpfung

Die Exklusive Oder (XOR)-Verknüfpung $$\vee$$ erfüllt die folgende Wahrheitstabelle:
```math
\begin{array}{|c|c|c|}
 x & y & x  \vee  y \\
\hline
false & false & false \\
true & false & true \\
false & true & true \\
true & true & false
\end{array}
```
"""

# ╔═╡ a15391d8-0c57-4a55-9562-90877043ede6
false ⊻ false, true ⊻ false, false ⊻ true, true ⊻ true

# ╔═╡ 329c9d46-99b9-40e0-96c3-69af17e03388
md"""
### Bedingte Ausdrücke

Hier gibt es zwei Ausprägungen, auf die wir im Folgenden eingehen.

#### Short-Circuit Evaluation
"""

# ╔═╡ 62d6605a-50be-4fd4-b379-30734406e55a
md"""
!!! warning "Achtung"
	1. In der UND-Verknüpfung `a && b` wird der zweite Term `b` erst ausgewertet, wenn der erste Term `a` den Wahrheitswert `true` hat.
	1. In der ODER-Verknüpfung `a || b` wird der zweite Term `b` erst ausgewertet, wenn der erste Term `a` den Wahrheitswert `false` hat.

Dies wird oft in Julia genutzt. Ein Anwendungsbeispiel ist die Prüfung von Eingabewerten. Hier ein Beispiel für die UND-Verknüpfung:
"""



# ╔═╡ fbf70088-32db-4cb9-b4c7-185149550ea6
begin
	eingabewert1 = -1
	eingabewert1 < 0 && error("Eingabewert ist zu klein!") 
end

# ╔═╡ 2a62c447-c029-4a83-83ad-e53d974e3139
begin
	eingabewert2 = 1
	eingabewert2 < 0 && error("Eingabewert ist zu klein!") 
end

# ╔═╡ b56bdaca-be24-4379-b245-feb7b1f15a92
md"""der obige Block hat keine Ausgabe, des Satzes: "Eingabewert ist zu klein!", da der erste Term nicht wahr (true) ist. Dies erkennt man auch an dem false oberhalb des Feldes. Im vorletzen Block gab es solch eine Ausgabe nicht, da das `print` -Kommando keinen Rückgabewert hat."""

# ╔═╡ b187a837-1321-40cc-91bd-06d9c4ce30ca
md"""
#### if-elseif-else bedingte Ausdrücke
"""

# ╔═╡ 2c9f1562-5adf-4773-9482-b3ad8fa67f7a
md"""
!!! tip 

	__if ( bedingung1 )__

		Anweisungen 1

	__elseif( bedingung2 )__

		Anweisungen 2
		.

		.

		.

	else

		Anweisungen sonst

	end
"""

# ╔═╡ 50584aaa-fa9e-46d9-858b-d11b7d2692a4
md"__Beispiel:__"

# ╔═╡ 853a7ad7-7cfe-4c85-8ca7-5811629d05b2
begin
	bedingung1 = true
	bedingung2 = true
	
	if(bedingung1)
		println("Bedinung 1 erfüllt")
	elseif(bedingung2)
		println("Bedingung 2 erfüllt")
	else
		println("Fall: keine Bedinung erfüllt -> Sonstige Anweisung")
	end
end

# ╔═╡ edad0a12-5631-42d4-94d9-496c57b06f82
md"Nur die Anweisung nach der ersten erfüllten Bedingung wird durchlaufen."

# ╔═╡ 8e2d2fbd-faad-4a8c-af80-a657bc8dd7cc
begin
	bedingung3 = false
	rueckgabewert = 
	if bedingung3
		"Hallo Frank" 
	else 
		"Hallo Tobias"
	end
end

# ╔═╡ 5035efd7-0190-4fb5-a246-f4d95cba5f79
md"""
!!! note "Bemerkung"
	`if` ist ein Ausdruck (Expression) und gibt damit einen Wert zurück. Dies ist im Gegensatz zu anderen Programmiersprachen, wie z.B. Java, in denen `if` ein Statment ist.
"""

# ╔═╡ f785397e-e40d-417f-b39e-884a7589625a
md"""
!!! warning "Achtung"
	`elseif` und `else` sind optionale Anteile der if-Bedingung
"""

# ╔═╡ 0d6ba76d-b790-4a45-b5c4-de33d468e23c
md"""
#### Ternärer Operator

Wie andere Programmiersprachen besitzt Julia auch einen ternären Operator (ternary operator). Der Ternäre Operator ist eine kurze Form einer if-Anweisung, die wie eine Zuweisung nutze kann.
"""

# ╔═╡ c1d50d98-06b0-4a67-b5be-cb056ffb2704
md"""
!!! tip 
	Der Ternäre Operator hat die Struktur:

    `bedingung ? <Rückgabewert wenn wahr > : <Rückgabewert wenn falsch`
"""

# ╔═╡ 92ea05a4-37b8-4f86-a812-ebdd05e2c937
md"__Beispiele__"

# ╔═╡ e79da772-748c-44f7-a224-4bad928fe635

begin
	bedingung4 = false
	bedingung4 ? "Hallo Frank" : "Hallo Tobias"
end

# ╔═╡ 514bf743-dbe1-4886-9071-c7a282d6edcf
@bind is_box_checked CheckBox()

# ╔═╡ dfe6eecd-4864-4316-821e-86e465f55456
is_box_checked ? "Häkchen gesetzt" : "Häkchen nicht gesetzt"

# ╔═╡ f372431f-08c0-4206-88a0-4ec10f012e9a
md"""
#### Übung 5: 
1. Schreibe eine if-Anweisung, die eine bereitgestellte Zahl prüft. Es soll
   - fizz ausgegeben werden, wenn die Zahl ohne Rest durch 3 teilbar ist,
   - buzz ausgegeben werden, wenn die Zahl ohne Rest durch 5 teilbar ist und
   - fizz buzz, wenn Sie ohne Rest durch 3 und 5 teilbar ist.
2. Verwende den ternären Operator, um eine Anweisung zu schreiben, die überprüft, ob     die Länge eines Strings größer als 5 ist, und entsprechend "Lang" oder "Kurz"     
    zurückgibt. Um den String einzugeben benutze folgenden Befehl in einem Pluto-  
    Notebook:
    
	```julia
	    @bind text TextField(default="test")
```
"""

# ╔═╡ cd369ef2-83d4-422a-aceb-f92e7fcf39a3
@bind text TextField(default="test")

# ╔═╡ 4eb1def0-0b6b-4bec-86ce-25a29e891f3b
length(text)>5 ? "Lang" : "Kurz"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
FileIO = "~1.16.2"
Images = "~0.26.0"
PlutoUI = "~0.7.54"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.6"
manifest_format = "2.0"
project_hash = "4f50f408933af9ceda4b0e4d987baae020127e91"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "c278dfab760520b8bb7e9511b968bf4ba38b7acc"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.3"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "cde29ddf7e5726c9fb511f340244ea3481267608"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.7.2"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "Requires", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "bbec08a37f8722786d87bedf84eae19c020c4efa"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.7.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "0c5f81f47bbbcf4aea7b2959135713459170798b"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.5"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "601f7e7b3d36f18790e2caf83a882d88e9b71ff1"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.4"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "2118cb2765f8197b08e5958cdd17c165427425ee"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.19.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "70232f82ffaab9dc52585e0dd043b5e0c6b714f1"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.12"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "407f38961ac11a6e14b2df7095a2577f7cb7cb1b"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.6"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

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
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "886826d76ea9e72b35fcd000e535588f7b60f21d"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "ac67408d9ddf207de5cfa9a97e114352430f01ed"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.16"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "66c4c81f259586e8f002eacebc177e1fb06363b0"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.11"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "ec22cbbcd01cba8f41eecd7d44aac1f23ee985e3"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.7.2"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "c5c28c245101bd59154f649e19b038d15901b5dc"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "899050ace26649433ef1af25bc17a815b3db52b7"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.9.0"

[[deps.HistogramThresholding]]
deps = ["ImageBase", "LinearAlgebra", "MappedArrays"]
git-tree-sha1 = "7194dfbb2f8d945abdaf68fa9480a965d6661e69"
uuid = "2c695a8d-9458-5d45-9878-1b8a99cf7853"
version = "0.3.1"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "eb8fed28f4994600e29beef49744639d985a04b2"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.16"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageBinarization]]
deps = ["HistogramThresholding", "ImageCore", "LinearAlgebra", "Polynomials", "Reexport", "Statistics"]
git-tree-sha1 = "f5356e7203c4a9954962e3757c08033f2efe578a"
uuid = "cbc4b850-ae4b-5111-9e64-df94c024a13d"
version = "0.3.0"

[[deps.ImageContrastAdjustment]]
deps = ["ImageBase", "ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "eb3d4365a10e3f3ecb3b115e9d12db131d28a386"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.12"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "fc5d1d3443a124fde6e92d0260cd9e064eba69f8"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.1"

[[deps.ImageCorners]]
deps = ["ImageCore", "ImageFiltering", "PrecompileTools", "StaticArrays", "StatsBase"]
git-tree-sha1 = "24c52de051293745a9bad7d73497708954562b79"
uuid = "89d5987c-236e-4e32-acd0-25bd6bd87b70"
version = "0.1.3"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "08b0e6354b21ef5dd5e49026028e41831401aca8"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.17"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "PrecompileTools", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "432ae2b430a18c58eb7eca9ef8d0f2db90bc749c"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.8"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "bca20b2f5d00c4fbc192c3212da8fa79f4688009"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.7"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "b0b765ff0b4c3ee20ce6740d843be8dfce48487c"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.3.0"

[[deps.ImageMagick_jll]]
deps = ["JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1c0a2295cca535fabaf2029062912591e9b61987"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.10-12+3"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "6f0a801136cb9c229aebea0df296cdcd471dbcd1"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.5"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "3ff0ca203501c3eedde3c6fa7fd76b703c336b5f"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.8.2"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "7ec124670cbce8f9f0267ba703396960337e54b5"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.0"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageBinarization", "ImageContrastAdjustment", "ImageCore", "ImageCorners", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "d438268ed7a665f8322572be0dabda83634d5f45"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.0"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3d09a9f60edf77f8a4d99f9e015e8fbf9989605d"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.7+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "ea8031dea4aff6bd41f1df8f2fdfb25b33626381"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.4"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "be8e690c3973443bec584db3346ddc904d4884eb"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5fdf2fe6724d8caabf43b557b84ce53f3b7e2f6b"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2024.0.2+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "721ec2cf720536ad005cb38f50dbba7b02419a15"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.7"

[[deps.IntervalSets]]
deps = ["Dates", "Random"]
git-tree-sha1 = "3d8866c029dd6b16e69e0d4a939c4dfcb98fac47"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.8"
weakdeps = ["Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "PrecompileTools", "Printf", "Reexport", "Requires", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "e65d2bd5754885e97407ff686da66a58b1e20df8"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.41"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "fa6d0bcff8583bac20f1ffa708c3913ca605c611"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.5"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "60b1194df0a3298f460063de985eae7b01bc011a"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "62edfee3211981241b57ff1cedf4d74d79519277"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.15"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

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

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

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

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "0f5648fbae0d015e3abe5867bca2b362f67a5894"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.166"

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.LoopVectorization.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "72dc3cf284559eb8f53aa593fe62cb33f83ed0c0"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2024.0.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "b211c553c199c111d998ecdaf7623d1b89b69f93"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.12"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "1130dbe1d5276cb656f6e1094ce97466ed700e5a"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "ded64ff6d4fdd1cb68dfcbb818c69e144a5b2e4c"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.16"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "6a731f2b5c03157418a20c12195eb4b74c8f8621"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.13.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "a4ca623df1ae99d09bc9868b008262d0c0ac1e4f"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "67186a2bc9a90f9f85ff3cc8277868961fb57cbd"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.3"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "bd7c69c7f7173097e7b5e1be07cee2b8b7447f51"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.54"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "240d7170f5ffdb285f9427b92333c3463bf65bf6"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.1"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase"]
git-tree-sha1 = "3aa2bb4982e575acd7583f01531f241af077b163"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "3.2.13"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsMakieCoreExt = "MakieCore"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    MakieCore = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "00099623ffee15972c16111bcf84c58a0051257c"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.9.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "9a46862d248ea548e340e30e2894118749dc7f51"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.5"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "792d8fd4ad770b6d517a13ebb8dadfcac79405b8"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.6.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "3aac6d68c5e57449f5b9b865c9ba50ac2970c4cf"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.42"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "4b33e0e081a825dbfaf314decf58fa47e53d6acb"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.4.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

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

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.Static]]
deps = ["IfElse"]
git-tree-sha1 = "f295e0a1da4ca425659c57441bcb59abb035a4bc"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.8.8"

[[deps.StaticArrayInterface]]
deps = ["ArrayInterface", "Compat", "IfElse", "LinearAlgebra", "PrecompileTools", "Requires", "SparseArrays", "Static", "SuiteSparse"]
git-tree-sha1 = "5d66818a39bb04bf328e92bc933ec5b4ee88e436"
uuid = "0d7ed370-da01-4f52-bd93-41d350b8b718"
version = "1.5.0"
weakdeps = ["OffsetArrays", "StaticArrays"]

    [deps.StaticArrayInterface.extensions]
    StaticArrayInterfaceOffsetArraysExt = "OffsetArrays"
    StaticArrayInterfaceStaticArraysExt = "StaticArrays"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "4e17a790909b17f7bf1496e3aec138cf01b60b3b"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.0"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

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
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

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

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "eda08f7e9818eb53661b3deb74e3159460dfbc27"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.2"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "34cc045dd0aaa59b8bbe86c644679bc57f1d5bd0"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.8"

[[deps.TiledIteration]]
deps = ["OffsetArrays", "StaticArrayInterface"]
git-tree-sha1 = "1176cc31e867217b06928e2f140c90bd1bc88283"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.5.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "1fbeaaca45801b4ba17c251dd8603ef24801dd84"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.2"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "7209df901e6ed7489fe9b7aa3e46fb788e15db85"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.65"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "5f24e158cf4cee437052371455fe361f526da062"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.6"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "93284c28274d9e75218a416c65ec49d0e0fcdf3d"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.40+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═608469ba-9f6c-11ee-3740-fff2920aac1c
# ╟─211891dd-5811-454d-9530-49ed28d6adfe
# ╟─127de8a6-c092-438f-9cb0-83532a5343c7
# ╟─12606683-a23d-4b5e-acc2-94634ff6fe89
# ╟─36ec497f-191b-4b06-ac39-52aa4ac05f92
# ╟─8fdce7cf-06f8-4d5d-924e-242a06af3679
# ╟─29353080-35bb-4867-b63c-3521f56a9927
# ╠═0c6a2a3f-1f08-4e45-94dc-427702713c75
# ╟─2a012a0e-ca83-49cb-aaed-c5146ec78a13
# ╠═f473b5a4-eccf-4020-8c8d-33caddd85826
# ╠═ffd5929c-51b8-4cdb-8285-4e15026d9875
# ╟─4f133e9d-b916-41da-9251-3514fcf9f5a9
# ╟─ef37041d-0b4d-4204-9c22-9ce7d7952af7
# ╠═34cf8b22-9da3-4ab1-ba1c-0a3a1e83ee29
# ╠═0cca4b3e-3cd2-4af9-b7e4-d1b8f137301f
# ╠═51ecbb07-d338-404e-b9ae-9701e75e4d73
# ╠═aabb2fb0-06d7-43d7-8805-edb8beb8fd5c
# ╟─0c8425d7-71fd-4553-a835-4bb38561309b
# ╟─f6a7952a-c5c4-4e32-904c-e85dacf1713e
# ╠═02d72773-37ea-4ebd-9c6f-ccd51d96f4b7
# ╠═f07a1e5a-c465-499b-a92e-d9b91a1c776d
# ╟─817860ac-b284-4b02-865a-207cec9fc8ff
# ╟─42af2d00-1dbe-40bd-9031-3da3cbd2d0b4
# ╠═ec3a9cfd-dec4-47bb-8dd2-9df5a08a918b
# ╠═f9bb8c82-6cce-462b-a936-4ab823d683ae
# ╠═67f8ef07-4093-471b-883d-9551042aace9
# ╟─5f22ef4b-5cc9-4c04-814a-de81a49450ca
# ╟─f603f393-34b6-4c09-b842-13ca35f2ccf8
# ╟─cef22301-06ee-4897-ae53-497cd9946c8a
# ╠═7021d829-bde7-4121-9eab-6c3ef14a7960
# ╟─59821bea-21ea-4528-bcb6-ee8a773f5947
# ╟─5376a7f5-6e88-4b73-8a41-dd4280ac2caa
# ╟─693e21ee-d95e-49b5-b144-213b4b2983b9
# ╟─a775cd14-0cdd-4118-b3f0-aef2ff9e7f0a
# ╟─9204fd20-c3c6-48cf-acdb-2a3f1fab054e
# ╟─47e68e27-144c-46df-b180-6b491e9d9bde
# ╠═d9f6b662-c8ca-4a1a-ac09-4798ca45b841
# ╟─cef7c017-4595-4b92-8962-d9832f10e00c
# ╠═b96bde8f-4cbc-4ce8-b43b-70c58ed5fb64
# ╟─2ea1bc14-9e91-41d3-afd4-428f4503df0e
# ╟─187c092e-ad8c-4402-aa05-e0733b336550
# ╠═f6f4c530-23d1-4293-9cd3-a83251f67f11
# ╟─77e17d76-7b5b-4b89-89a1-7e889530490b
# ╠═ef89de7f-6843-40e2-beef-61a09bb914eb
# ╟─14dd583e-bb89-4ad4-887e-513423a637a9
# ╠═3288a869-9891-4177-8cbf-e6ed3e3c80bf
# ╟─e2906acf-65d5-4b2e-ab58-15521392a02d
# ╠═59c7602c-14be-4faa-81ff-387d730581e7
# ╠═c6e7aa1e-b67c-4fca-94c4-afad62e2fd17
# ╟─5a34c57e-5885-4df4-8305-5cb0391ef229
# ╟─911930fd-54ce-4f89-b2de-a6b85c1ac378
# ╠═ef92e922-3637-4f97-9012-17ddfe8823a0
# ╠═b4d55262-321d-4870-a06f-fb3dfe3c897f
# ╟─b447d086-52d2-4f05-be0b-6f3deabfd9f1
# ╟─6ff1fbaf-8551-4bf7-8bed-648fc7b07d7c
# ╟─52d76ceb-257d-4664-973c-9dc073a2f9f9
# ╠═e0144d69-0bca-4e2e-938b-3e34ca8680c8
# ╟─18181c18-f307-4ecc-99ca-0ec263d062c7
# ╠═83c1be17-dda5-472b-9208-e75a13118601
# ╟─0757fc13-1ac5-44f7-b8d8-52a4a77bbed8
# ╟─f6890cae-3312-4fcd-9efa-99336f533b24
# ╠═8a3b198e-b799-4871-94a9-d75686986857
# ╠═aaaafde9-cd2d-43c7-bab6-7ef2450391a4
# ╠═bf787872-d71a-4a3a-a506-b3cc9e618797
# ╟─99c28994-c077-47af-9764-799ab6c849f1
# ╟─29f8237b-68e9-4f4c-b877-0e7c12e1c70f
# ╟─7eab6123-7c04-47be-8e65-721f63861e46
# ╠═bd4af97c-e67b-459b-9fb8-37705b2ef870
# ╟─09a473ba-1fa8-4b38-af9a-d68669d83f34
# ╟─660f4a6f-d32f-4a94-aad2-20e022a6d860
# ╟─400df166-de80-466a-981d-16d8acfdd7e5
# ╠═52e96842-4c23-47e4-80c7-1a0e1cf9b55d
# ╟─2ee60d80-de03-42b6-9343-7f0779e79452
# ╟─1e0f1b46-cff6-4b3c-829f-637e9c6e9533
# ╠═eadf6143-781e-411c-ab2f-e04d26797803
# ╠═76feca8f-39ed-4cc5-9be2-98f366da2cc8
# ╠═ae984997-3119-486f-b3ec-5fc5a171f5eb
# ╠═9362ef16-a700-4bcf-a475-c0633e5df42a
# ╟─aace03b3-2285-4739-b17e-7e87613bf4dc
# ╟─ea358f14-f3b8-4b98-8354-9b22c830f88c
# ╟─1555e3b8-bc05-4c99-8b9f-3fc1291e7626
# ╠═e073468c-7a71-4f79-8250-3ef40c269366
# ╟─8c6817e7-67dd-46ce-9040-42a0eda29664
# ╠═6fa5cd27-4d3b-468d-8ef6-fe3c698585e2
# ╠═6d35b180-b78c-4f2f-afb9-023d00db462c
# ╟─62007b66-8b7c-4469-8525-c120bd2a7fbb
# ╠═7a66d7fc-30b4-49b8-a051-b250464f7be7
# ╟─d9969360-3f88-41c5-bbde-07bb20e62299
# ╠═8cbb96df-5cdc-4d3f-9437-159b05445b9a
# ╟─7f4e79af-797e-42cb-9fde-ef6d4801f7da
# ╟─f82751f5-bdf6-4adf-82c6-2d07bf3c1ffb
# ╠═9a226454-4dc0-4e94-829b-35cd0042891e
# ╟─430b5b21-714f-4bf1-b650-ed10a31aed80
# ╠═571a7d02-2955-4e8b-8dbd-c538d4b819f0
# ╟─3b1f09df-875c-4e05-bf56-b2ac1e84de95
# ╟─d4260739-a6c8-4f02-96b9-279abb0e11b0
# ╠═b416d9c8-803b-4e3e-b66b-7e20c89f96bb
# ╠═65fcd88e-09ca-4079-9d7d-e395f1382b2d
# ╠═0b84a9df-149b-4690-bfa1-078943b2e4b3
# ╠═59f6cb34-24e8-48a9-882e-310f1a78a1d4
# ╟─8713df22-2846-41d4-abcd-006795a6b758
# ╠═6f0af6be-69fd-42c1-98da-c868eb5f3948
# ╟─8894c690-9a0c-40d7-ac74-708a1218ada4
# ╟─fa56dc37-eeb8-4b40-a54c-6b586c85ee9a
# ╠═71024eb6-380e-4a48-ac67-e3d0ece3e0b7
# ╠═63fd5865-df42-4883-a8b0-75645a6ebbb2
# ╟─eeabf882-a967-4137-9ea3-09487055d9ec
# ╠═0e575a99-ea33-4902-920f-11938594fe5b
# ╟─f93c55c6-cb45-422d-8e07-359105252446
# ╟─543bf419-6dfd-44c0-b7af-220e99d7346c
# ╠═b1c68c08-2f35-4a2f-82cc-ade0af44cdef
# ╟─e4fc9ce0-b7c2-4686-9e47-832145654e18
# ╠═1fef8d2e-17bc-4de0-8fc3-3e48ab8ef732
# ╟─eb74a0a2-fdd9-4fd1-a810-9fbf8663f435
# ╠═89a42b4c-e44b-46eb-b904-01530bc075ee
# ╟─709f786b-e2e9-4f6f-a334-a6fda3c28abe
# ╠═6b49e12d-426b-431e-9422-4646bcbc8294
# ╟─6927ab20-a886-4657-89da-8a6b53c769b5
# ╠═bc7bc37e-22a9-4aa9-bd8a-cd2b8ede3016
# ╠═679e9257-4c43-4544-bd9f-6cbf629738be
# ╟─5519a33e-d60d-4b7a-942f-f74939746d43
# ╟─334695dc-9c14-449e-bd70-b83cf94430cb
# ╠═1c9a33f8-3156-4253-8caa-d72d66d25797
# ╠═7b5b381a-6c9d-40f9-8da4-28a9ca4f1b26
# ╟─299d68e2-8e16-455e-a926-329e48900a12
# ╠═7f1f0b4d-5887-40aa-80e8-829bc0064395
# ╠═e9bbff3b-b584-4b15-9409-00dc04ce1e16
# ╠═346b0816-0714-465b-bfa3-ae32fe170d87
# ╠═f0948abe-4447-4789-b7d8-2446b9a0a983
# ╟─efc57d33-aa5d-4f8c-87c2-b36a388daa3a
# ╠═c532c3a0-8c57-4b8c-846b-7f482fde61e7
# ╠═73646c2b-79f8-44d4-a366-76bac145cb2b
# ╠═750f16f6-47e7-4698-a683-0a54b9e31772
# ╠═56bde8fb-c208-4de6-a361-ea15e6b8197a
# ╟─6ede7c13-08b7-466f-a754-c6a84307d573
# ╠═4a64eabf-ecf9-414e-b07a-419f74f4c5b1
# ╠═1843deeb-12f5-4951-8dea-737bc4170662
# ╠═11f4fe9e-9e8e-42b5-a40a-4f7fc57b5f2d
# ╠═105cf711-666f-4579-b51a-a125d7f031c5
# ╟─b48c2a2f-0894-4b30-ab8d-7f0958a684c2
# ╠═69e311ea-56c3-4768-9a72-e5e681c9dbf8
# ╟─baf58134-1cd6-4470-8167-073970517c6d
# ╟─3d9dd161-663f-40e8-b524-4193c29196ba
# ╠═a15391d8-0c57-4a55-9562-90877043ede6
# ╟─329c9d46-99b9-40e0-96c3-69af17e03388
# ╟─62d6605a-50be-4fd4-b379-30734406e55a
# ╠═fbf70088-32db-4cb9-b4c7-185149550ea6
# ╠═2a62c447-c029-4a83-83ad-e53d974e3139
# ╟─b56bdaca-be24-4379-b245-feb7b1f15a92
# ╟─b187a837-1321-40cc-91bd-06d9c4ce30ca
# ╟─2c9f1562-5adf-4773-9482-b3ad8fa67f7a
# ╟─50584aaa-fa9e-46d9-858b-d11b7d2692a4
# ╠═853a7ad7-7cfe-4c85-8ca7-5811629d05b2
# ╟─edad0a12-5631-42d4-94d9-496c57b06f82
# ╠═8e2d2fbd-faad-4a8c-af80-a657bc8dd7cc
# ╟─5035efd7-0190-4fb5-a246-f4d95cba5f79
# ╟─f785397e-e40d-417f-b39e-884a7589625a
# ╟─0d6ba76d-b790-4a45-b5c4-de33d468e23c
# ╟─c1d50d98-06b0-4a67-b5be-cb056ffb2704
# ╟─92ea05a4-37b8-4f86-a812-ebdd05e2c937
# ╠═e79da772-748c-44f7-a224-4bad928fe635
# ╠═514bf743-dbe1-4886-9071-c7a282d6edcf
# ╠═dfe6eecd-4864-4316-821e-86e465f55456
# ╟─f372431f-08c0-4206-88a0-4ec10f012e9a
# ╠═cd369ef2-83d4-422a-aceb-f92e7fcf39a3
# ╠═4eb1def0-0b6b-4bec-86ce-25a29e891f3b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
