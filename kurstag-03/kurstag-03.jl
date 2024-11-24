### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ dd8698ee-affb-11ee-084e-1ffdbb6f6a08
begin
	using PlutoUI, Images, FileIO, Plots, LinearAlgebra
	TableOfContents()
end

# ╔═╡ 65fb214d-3782-4de9-b8dd-34efb047f6c9
md"""
# Einführung in Julia - Kurstag 3
__Datenstrukturen und Schleifen__
"""

# ╔═╡ 4bffdb22-06fc-465f-9257-ab2974230512
md"""
## Kontainer-Datenstrukturen
"""

# ╔═╡ 7ddad624-511d-4907-9d5c-84d1bd90731c
md"""
### Arrays

Sind geordnete Kontainer-Datenstrukturen, .d.h. sie enthalten Elemente eines bestimmten Typs in einer festgelegten Ordnung. Man kann die  Elemente in einem Array gegen anderen Elemente austauschen. Arrays sind modifzierbar.
"""

# ╔═╡ fa54a5ab-fae6-43f3-9ac7-543a9ecd0e52
namen = ["Frank","Markus","Thomas","Heinrich"]

# ╔═╡ 694c26d3-00be-4369-896b-36354b8c4549
md"Array mit festem Element-Typ: "

# ╔═╡ 1a5b9dab-db33-4fab-8f03-73f8561fbebc
typeof(namen)

# ╔═╡ 6774a4bb-4b9c-4240-80d6-528fa8bde92e
fibonacci = [1,1,2,3,5,8,13]

# ╔═╡ 9fe066e4-8e90-445c-9d97-ab8dd6ce162e
typeof(fibonacci)

# ╔═╡ 95bd760c-e807-4d97-91ec-4eb4cf368416
md"""
!!! warning "Achtung"
	Arrays enthalten immer Elemente des gleichen Typs, aber es ist der gemeinsame Obertyp der enthaltenen Elemente.
"""

# ╔═╡ 1bd57323-0d30-4853-b6a0-c225570441a7
andere_zahlen=[1,1.0,1//1,π, "Pi","🥧"]

# ╔═╡ febe956a-5d6a-4c82-82ff-39167a624a70
typeof(andere_zahlen)

# ╔═╡ 83856275-e0af-489f-a529-f8c456aaae87
md"#### Array-Operationen"

# ╔═╡ 49e0160c-b6c1-402e-b909-baaa9e4a3a80
length(fibonacci)

# ╔═╡ 6d80fd45-7311-4cb0-ad55-80e631f05909
md"Hinzufügen eines Elementes"

# ╔═╡ 77311223-fea8-44ae-b3ef-616e954272dd
push!(fibonacci,21)

# ╔═╡ 626d6b76-9cdf-4866-9cbc-961f89ac6146
md"""
!!! remark "Bemerkung"
	Die Funktion `push!` verändert das Array, dass man ihr übergibt. Im Allgemeinen wird in Julia mittels Konvention durch ein `!` ausdrückt, dass eine Funktion ihre Argumente verändert.
"""

# ╔═╡ ac149eee-8553-47ab-bff9-9631810b1a04
md"Entfernen eines Elementes"

# ╔═╡ 20472e7d-0d12-41c4-953c-2c8d9a293c98
begin
	entfernetes_element = pop!(fibonacci)
	entfernetes_element
end

# ╔═╡ 658be04e-c557-4f2b-82af-fae89a392163
md"Aktualisieren eines Elementes"

# ╔═╡ f5dbfb3f-0bf6-444f-9d91-d730ebdcc686
md"""
!!! warning "Achtung"
	Im Gegensatz zu vielen anderen Sprachen (Java, C, etc) fängt die Indizierung bei 1 an. Dies ist aber auch hier nur eine Konvention und kann angepasst werden. Um Probleme damnit zu umgehen benutzt man `begin` und `end` (siehe später).
"""

# ╔═╡ 44de9b65-9e43-450c-974a-4d9844315160
begin
	namen[1] = "Frank"
	namen
end

# ╔═╡ 8f8abd58-cbac-4ead-b1f1-09dc58f3aff9
md"""
!!! tip "Bemerkung"
	Um das erste und letzte Element eines Arrays zu adressieren, kann man `begin` und `end` als Index nutzen.
"""

# ╔═╡ a321cf2c-4127-478b-80cb-81c43f5bfa60
begin
	namen[begin] = "Piotr"
	namen
end

# ╔═╡ 6146a1e4-4f71-441b-bd29-b2568a7bc762
begin
	namen[end] = "Tobias"
	namen
end

# ╔═╡ 7a807a7f-5b61-4404-9344-51c3234db1c7
md"andere Einträge werden durch ihre Postion im Array adressiert:"

# ╔═╡ bf8f94c2-f323-485c-80c9-17e9ff313aa7
begin
	namen[2] = "Lena"
	namen
end

# ╔═╡ 532e7dbb-752e-4cde-8fd0-f167819db312
md"2-dimensionale Arrays"

# ╔═╡ c0956429-4b92-45b0-903a-2f97ee2db9c5
matr1 = [1 2 3; 4 5 5;5 7 8; 9 10 11 ]

# ╔═╡ 94617964-1f9f-49b8-9450-12f61d7b7791
length(matr1) # gibt die Anzahl der Elemente aus

# ╔═╡ 15611340-6181-4608-8ed0-898b3bcae2d9
size(matr1)

# ╔═╡ 216371f0-7bbd-4fe5-9ab8-179c75ee20aa
size(matr1,1)

# ╔═╡ 0c31d665-56da-42c1-9507-67e64f890eab
ndims(matr1)

# ╔═╡ 26f426b3-62ea-4845-af79-1005683f004c
md"extrahieren einer Zeile"

# ╔═╡ 01ca76ae-a730-4853-9c9b-58c15148c493
matr1[3,:]

# ╔═╡ de7633f8-9426-4605-88e6-96a90a172f68
md"extrahieren einer Spalte"

# ╔═╡ d2dc0c10-4c3a-46b6-b334-68ce48eb3f5b
matr1[:,3]

# ╔═╡ 98104de1-935a-4002-8297-671cf6fcd274
md"mehrdimensionale Arrays"

# ╔═╡ 7f2ec829-d0c5-48f0-9028-ba9b85bbb410
matr2 = Array{Int}(undef,3,3,2)

# ╔═╡ 392a15b4-31b4-4ea4-9ed0-dae40cbf59bd
md"dies könnte zum Beispiel die Position von drei Teilchen im dreidimensionalen Raum zu bestimmten Zeitpunkten sein"

# ╔═╡ 67b6a6f4-5f1c-46ce-8968-1ae5768f75e0
md"""
### Vektoren und Matrizen 
"""

# ╔═╡ 259b58d4-026b-4ace-8bf2-ea810d2932f1
md"#### Vektoren"

# ╔═╡ 125c13ae-cbbd-489a-ab8a-f40364be1a84
md"Definieren von n=3-diemensionalen Vektore"

# ╔═╡ ee16caec-c2c7-4e3b-b09e-d7bb622d073c
a=vec([1,2,3])

# ╔═╡ fa740a2e-0db7-48b9-b025-4a8e7148b90b
b=vec([4,2,1])

# ╔═╡ 1ec27440-0af1-44c0-a09e-450fbc11ff2d
md"Addition von Vektoren:"

# ╔═╡ de322420-6d63-4d3e-9250-dfb2e862db7f
a+b

# ╔═╡ 432729b5-3a62-4ea8-8f3a-ed70edc23391
md"Skalarprodukt von Vektoren"

# ╔═╡ 69625c58-5d2e-4190-8d62-bdf730190e11
dot(a,b) 

# ╔═╡ a241b4c3-6c1e-4435-9c53-ce10c50ce829
a ⋅ b

# ╔═╡ 0cbbd97f-cda9-4153-b990-310b54f3f782
md"Kreuzprodukt $\vec{a} \times \vec{b}$ von Vektoren"

# ╔═╡ 3343586a-3828-4128-b31f-e1cacb3b0295
cross(a,b)

# ╔═╡ 7a7f45c7-d674-4560-96a8-a533b926eede
a×b

# ╔═╡ d05bd3a0-166b-4e0a-9bea-a02e0c17b1a0
md"Veranschaulichung der Addition von Vektoren"

# ╔═╡ e033443d-fde2-42ea-9608-e00be347b3ee
v1 = [2, 3]

# ╔═╡ 8fa20894-d4a7-4f97-94ab-26aec0c043a1
v2 = [3, 1]

# ╔═╡ 6102c977-34cc-4036-bf71-28515bdaf395
vs=v1 + v2

# ╔═╡ 0b18aa82-6d31-4023-b5ad-64df9303e6ef
md"""
#### Übung 1: 
1. Zeige am Beispiel, dass das Kreuzprodukt (cross) eines Vektors mit sich selbst null ist.
2. Zeige am Beispiel, dass das Skalarprodukt (dot) zweier Vektoren, die senkrecht aufeinander stehen null ist (das Kreuzprodukt zweier Vektoren stehen senkrecht auf diesen).
"""

# ╔═╡ 00afa9f3-d7b9-492c-a0ee-c3946e9dc842
md"##### Lösungen zu 1:"

# ╔═╡ 32f8b5ee-bef4-4cfb-9dad-e9b4cf93ec66
a × a

# ╔═╡ f3802ee2-fe0e-4177-afe6-94c81c38fffc
(a×b)⋅b

# ╔═╡ 8a06860b-a85f-446f-82d1-142594af5581
md"#### Matrizen"

# ╔═╡ 7ef9db2d-89dd-4b6f-9646-cc6e4c9ed4c3
A = [2 3 5; 4 5 6]

# ╔═╡ 378a4897-9736-4dff-b965-a2f5b6ca7c0e
B = [10 3 7; 2 4 8]

# ╔═╡ 51252320-8757-4882-acf8-9402914957e7
md"""
Multiplikation einer Zahl mit einer Matrix:

alle Einträge der Matrix (Elemente) werden mit der Zahl multipliziert
"""

# ╔═╡ dd5662cd-2e4e-407f-a2cd-61875a764a6c
3*A

# ╔═╡ 681c83e8-0ba5-4724-9c4d-53b9aa865ade
md"Addition von Matrizen"

# ╔═╡ fe033625-d6b1-47a0-944a-46ba8d3fcfc5
A+B

# ╔═╡ 66f0e5b2-9c72-4cf2-9f73-a244310e8421
A-B

# ╔═╡ 7069abc3-a33d-4781-b500-9983a5de8e4d
A-B == A+(-1*B)

# ╔═╡ a14f4c5d-9f7e-426f-902e-c7072275c36f
md"Nullelement bei Matrizen -- Neutrales Element bzgl. Addition"

# ╔═╡ 25172caf-42f7-4ac8-8948-522e48ac20ce
NM=zeros(2,3)

# ╔═╡ b8ad5e08-d012-42a0-b6a1-f41c47f4a95c
A == A+NM

# ╔═╡ e5d7cf38-b7ac-48d0-8e35-9eb332545c76
md"Addition nur möglich, wenn Anzahl der Spalten von A gleich Anzeihl der Spalten von B und gleiches für Zeilen"

# ╔═╡ f6099034-1179-4a16-931f-7981aed0a6e5
#ones(3,1)+ones(4,1) # auskommentieren führt zu Fehler

# ╔═╡ 7b7721f0-c068-4e9c-8e4c-76f151bc0731
md"""Mulitplikation einer Matrix

Das Produkt M*N zweier Matrixzen M und N ist nur definiert, wenn die Anzahl der Zeilen von M gleich der Anzahl der Spalten von N ist.
"""

# ╔═╡ 13b77128-cf5a-4e63-b2be-1e9adf491741
M = rand(3,2)

# ╔═╡ 0974f396-5578-4453-b094-4d3b96058dd6
N = rand(2,4)

# ╔═╡ b3f905f3-67a9-4d51-8a3e-289b893b59d7
M*N

# ╔═╡ 45ca7ba4-d562-4d40-89c9-72121818d6b4
#N*M  # auskommentieren führt zu Fehler

# ╔═╡ f3ab8b09-a273-4044-a62c-1c2ee51d3935
md"Defintion einer Einheitsmatrix"

# ╔═╡ a2437175-2f4c-4239-8d18-89e6ea702634
UM = Matrix(I,4,3)

# ╔═╡ c4826478-e39e-4ee4-a8e2-e717b15afb54
N*UM

# ╔═╡ d34befae-d1be-4cdd-8feb-55f79bd37fee
md"wenn Matrizen quadratisch sind, d.h. Anzahl von Zeilen und Spalten gleich so ändert die Multiplikation mit der Einheitsmatrix die Matrix __nicht__"

# ╔═╡ 11d53620-eef9-4294-8462-57269ffb2f5f
C = rand(1:20,3,3)

# ╔═╡ 0b48c2ab-90ce-4e2c-9336-821b7a1aeb34
I_3 = Matrix(I,3,3)

# ╔═╡ 2df0b930-95c2-43e7-bce0-196cf622b0fa
C*I_3

# ╔═╡ 11eacb65-7526-455c-85cd-867866a7bc4d
C*I_3 == I*C

# ╔═╡ 24c0b295-4738-4727-bbaa-f84e23066037
md"""
!!! tip "Bemerkung"
	Die Einheitsmatrix I ist in Julia so definiert, dass Sie die relevante Dimension erkennt.
"""

# ╔═╡ 4b87d085-a814-4606-bc7f-79a48e29eafc
md"""
#### Übung 2: 
1. Definiere die Matrizen:
   	$$\sigma_1 = \begin{pmatrix} 0 & 1\\ 1 & 0 \end{pmatrix}, \sigma_2 = \begin{pmatrix} 0 & -\mathrm{i}\\ \mathrm{i} & 0 \end{pmatrix}, \sigma_3 = \begin{pmatrix} 1 & 0\\ 0 & -1 \end{pmatrix}$$
2. Zeige, dass $\sigma_1^2=\sigma_2^2=\sigma_3^3=1_{2\times 2}$ ist.
3. Zeige, dass $\sigma_2\sigma_1-\sigma_1\sigma_2= -2 i \sigma_3$.
"""

# ╔═╡ b20cf4c6-1391-4e6d-b348-971176a1915c
md"""
### Schlüssel-Wert-Paare (dict)
"""

# ╔═╡ bfbe7b02-1b6f-4c07-9143-d12c7db73e64
md"""
Anlegen eines Dict (Schlüssel-Werte-Paar)
"""

# ╔═╡ c42d2bfc-2d1c-456f-b09a-d68c56973f7b
names_age = Dict("Frank"=> 49, "Anna" => 45, "Egon" => 92)

# ╔═╡ 2b707f5a-f258-4b52-a9ce-8050f6e70b71
names_age["Klaus"]

# ╔═╡ f42b5d23-c122-4401-b32d-2878cb2f4ea4
names_age["Anna"]

# ╔═╡ c26961b7-5daf-4570-b10f-918b0ed11581
names_age

# ╔═╡ 7e23f17c-9b87-4fca-bc60-38515443124a
md"""
!!! warning "Achtung"
	Im Gegensatz zu Array sind Dicts __nicht__ geordnet.
"""

# ╔═╡ b734cfe0-5ad1-4f5c-bb50-25430d9df3a9
md"Hinzufügen eines Wertes zu bestehendem Dict"

# ╔═╡ 291bbe09-a638-4a05-9681-b1db737c6ffe
begin
	names_age["Tobias"] = 40
	names_age
end

# ╔═╡ 851c1c0b-24b1-4707-9eb8-15ced8ff867d
md"Prüfung, ob Schlüssel in Dict enthalten ist"

# ╔═╡ dc0ac6e4-6bc7-47fc-8aec-7484ce769554
haskey(names_age,"Frank"),haskey(names_age,"FRANK")

# ╔═╡ d4b28d7e-03a9-42c0-8054-bfa94ad69b76
md"""
!!! warning "Achtung"
	Die Prüfung auf den Schlüssel beachtet Groß- und Kleinschreibung.
"""

# ╔═╡ 0cdd697b-2253-4029-b513-9daebe1b15cf
md"Abfragen eine Wertes bzgl. eines Schlüssels"

# ╔═╡ a9abd3fb-f74a-4bd8-9862-3bfafec6f579
names_age["Frank"]

# ╔═╡ aa0e87f3-8795-4a57-8068-d1afaf3856db
#names_age["FRANK"] # wirft Fehler, wenn auskommentiert

# ╔═╡ 1b13bafe-e46d-46d7-b49b-6534bd112627
md"Abfrage eines Schlüssel mit Default-Rückgabe"

# ╔═╡ a03db1b0-0145-4f2e-8d02-93617348a73a
get(names_age,"FRANK",-1)

# ╔═╡ 10efb5d1-146e-476c-bf37-f944a9492626
md"Löschen eines Schlüssel-Wert-Paares:"

# ╔═╡ 2a7913e4-22d7-4c07-8ee4-c05a31638e2f
delete!(names_age,"FRANK") # Schlüssel nicht enthalten, Dict wird zurückgegeben

# ╔═╡ 8170c94b-ed7a-462d-b4ec-c2cc8ce4f057
delete!(names_age,"Frank") 

# ╔═╡ e0c197a2-b798-49c6-98d0-4396fc2695df
md"Element mit Schlüssel wurde entfernt, Dict ohne Schlüssel-Wert-Paar wird zurückgegeben."

# ╔═╡ c921a63c-5e9f-48c9-9e4f-62997eb0dfa9
length(names_age)

# ╔═╡ af5c06b8-fcfe-442d-8d16-49ed808d9d8d
md"gibt die Anzahl der Schlüssel-Wert-Paare zurück."

# ╔═╡ 04e2bfd7-ee1b-4f27-a1a6-3f30e921a0e9
md"Interessant ist noch alle Schlüssel und/oder alle Werte eines Dicts zu extrahieren, um damit weiter zu arbeiten."

# ╔═╡ a38375a6-8c3b-45a1-a85e-cd31c7cb82ab
keys(names_age)

# ╔═╡ 1d4ec249-44cc-4b87-8b37-c75ad2bd982a
values(names_age)

# ╔═╡ 53b4636b-e021-4e33-a65a-628ac31b48da
md"""
#### Übung 2: 
1. Erstelle verschachtelte Dicts, die die Adresse und Telefonnummer von Personen speichern kann.
2. Untersuche die Funktion `merge` für Dicts.
"""

# ╔═╡ 563d8d0b-aa48-4002-b578-e54d4aa8b283
md"""
### Tuple 

Sind, wie Arrays, geordnete Kontainer-Datenstrukturen, .d.h. sie enthalten Elemente eines bestimmten Typs in einer festgelegten Reihenfolge. Im Gegensatz zu Arrays sind Tuple __NICHT__ modifzierbar. Damit sind sie besonderes für Asynchrone Aufgaben hervorragend geeignet. Die Typen von Tuple-Elemente müssen nicht gleich sein und werden durch Julia im Tuple mitgespeichert.
"""

# ╔═╡ 31ecf613-811f-41a5-9d93-255d8a611b41
md"Erzeuge eines Tuples"

# ╔═╡ 784872e1-cb49-42ee-990b-0750c0e89585
t1 = ("Frank", 49)

# ╔═╡ 28c75d66-ec91-4e97-b67c-fea5bda2915e
typeof(t1)

# ╔═╡ af3a9b41-d940-4c90-a0f5-72416745aece
md"Auslesen eines Tuples"

# ╔═╡ 52d85fe0-31b9-4056-ab6d-03153c2de1c2
"$(t1[1]) ist $(t1[2]) Jahre alt."

# ╔═╡ de243369-924e-4f63-826e-a25269e56bd5
md"wie Arrays können Tuples Elemente über ihre Position ausgelesen werden"

# ╔═╡ 36d2055f-74fe-4c35-a104-bc66a30eda9f
md"Tuple sind __nicht__ modifizierbar:"

# ╔═╡ ab4f703c-dbf9-4331-bd85-2a7f72beae34
t1[1] = "Egon"	

# ╔═╡ 5b47b087-3a8a-43c5-bd0d-65f336570a3b
t1

# ╔═╡ aff50e48-af73-4198-905d-7b6e545fb429
md"""
#### Unpacking und Splatting von  Tuplen
"""

# ╔═╡ 1f4af46a-41bf-4f9a-b464-53795930048b
md"Beispiel für das Auspacken (Unpacking) eines Tuples"

# ╔═╡ d429861a-4a5b-4106-b9c7-8741b990ae68
begin
	name, age = t1;
	"$name ist $age Jahre alt."
end

# ╔═╡ df62f062-031b-454d-bdb6-ff638847e8ed
md"man kann Tuple auch verschachteln"

# ╔═╡ f609d6f9-28ff-4ad0-9a2f-531d29047625
t2 = ("Egon", 92)

# ╔═╡ 469ba0cb-c9a9-465b-a8c1-55ac3adccf42
t_both = (t1,t2)

# ╔═╡ 3b27cd67-b73b-4bb8-aa8f-081b8ac1b807
md" aber dies ist oft nicht, was man möchte. Man möchte die Elemente alle in einem Tupel und nicht verschachtelt. Dazu nutzt man den Splat-Operator `...`"

# ╔═╡ 4ae9a1ac-2272-46b1-9619-5ae95aaa6715
t_both_in_one = (t1...,t2...)

# ╔═╡ 582f0ee1-febc-4774-8ff2-ac68ae81ada4
md"""
#### Named-Tuple
"""

# ╔═╡ 8bb5c9e7-08ad-4694-ba43-1cb79c2dd1d5
t3 = (name="Frank",age=49)

# ╔═╡ 5d7610ff-c5ad-4a2c-9cb9-ba4efcbffb7e
t4=(street_same="Annenstraße",house_number=10)

# ╔═╡ bae5735c-c529-4ba1-a4bf-14c227adcc38
typeof(t3)

# ╔═╡ d770789a-1c3e-44b1-bd39-657c8060276d
md"Auslesen eines Named-Tuples"

# ╔═╡ 273738b2-3781-4374-b619-d69bc481cf89
"$(t3.name) ist $(t3[:age]) Jahre alt."

# ╔═╡ f095bff5-0c7a-4763-bdd7-7eb9f85718eb
t4.street_same

# ╔═╡ e28bda3f-f1fa-4dab-9449-8c7b37eface6
md"""
#### Übung 3: 
1. Finde eine Möglichkeit den Inhalt zweier Variablen x und y auszutauschen ohne eine Hilfsvariable zu nutzen.
2. Erstelle zwei oder mehr Named-Tuple und spiele mit der Funktion `merge` rum. Was passiert, wenn die Namen übereinstimmen, aber die Werte nicht.
"""

# ╔═╡ 7adb3cbb-ea05-43f9-94ee-38f99863f8f8
md"""### Mengen


In einer Menge kann es jedes Element nur ein Mal geben, d.h. die Elemente sind einzigartig. Einen Menge kann durch den Konstruktor eine Menge erzeugt werden.
"""

# ╔═╡ 291ea98a-a3c0-4326-8d14-ee1c106a5de8
m = Set() # leere Menge

# ╔═╡ 835ba65f-1891-4e4b-9de4-dd40d59649c7
isempty(m)

# ╔═╡ 42a3195b-e350-4269-993a-446556a11397
push!(m,1)

# ╔═╡ 2ea39680-c858-43e0-9679-2cc6ae6426a8
isempty(m)

# ╔═╡ d6fbc218-be8b-4f67-8f35-893804c482b4
push!(m,1) # ein weitere Element 1 kann nicht hinzugefügt werden, da es bereits in der Menge enhalten ist

# ╔═╡ ef3220b1-abe3-4961-a28e-9e36ad85dc01
delete!(m,1)

# ╔═╡ 9c654798-b87d-47de-8ca1-6e44937d7d57
m1 = Set([1,2,2])

# ╔═╡ 79f7ec2c-77af-4569-9159-dfd490862697
length(m1)

# ╔═╡ b710b7c4-37d7-4b63-b0c4-82e5f69b5ed4
m2=Set([3,4])

# ╔═╡ e44a3e75-3de4-46ce-b6cd-f87f925a57f7
intersect(m1,m2)

# ╔═╡ 795b4f8c-b148-4351-b0bd-dbf7fc17a8fa
m1 ∩ m2 # \cap

# ╔═╡ 21547e7c-cfb9-4a78-8ee5-f16777bf9410
union(m1,m2)

# ╔═╡ 80b580fe-f374-43b4-bac1-f8b5c1c62995
m1 ∪ m1 #\cup

# ╔═╡ 23015954-b2c9-4200-b849-7af9ce013655
1 in m1, 1 ∈ m2

# ╔═╡ 2f1dfdb9-79ff-4687-b685-58d568945d3b
m1 ⊆ m2 # ist m1 eine Teilmenge 

# ╔═╡ 961708cd-3889-4289-bf8b-7c9f26f93d32
issubset(Set(3),m2)

# ╔═╡ fd6b4a7c-6bc8-4cb2-9c36-2190678f9ad8
md"""### Sequenzen (Ranges)

Sequenzen (Ranges) sind ein spezieller Kontainer-Typ, der

a. nur Zahlen enthalten kann und

b. unveränderbar ist, d.h. nach seiner Erstellung nicht mehr modifziert werden kann.
"""

# ╔═╡ b06f108f-84c5-4a57-b2d4-3dd32b18f39a
r1 = 1:10 # einfach

# ╔═╡ f04945b6-e57a-4781-9ea2-2093ca154d58
collect(r1)

# ╔═╡ 30d7794a-e020-4853-95a5-b55dae8fdb5f
r2 = 1:2:10

# ╔═╡ be1eb45e-ff60-401d-91aa-d28b60996bce
collect(r2)

# ╔═╡ c50bd5cb-e6bd-449f-8354-b4be99af60fa
begin
	r3 = range(0,10,5); 
	# schaut Euch auch die anderen Möglichkeiten hier in der Dokumentation an
	collect(r3), length(r3)
end

# ╔═╡ 24ffe410-2558-4f08-b770-5ed317859e39
begin
	r4 = 10:-1:0
	collect(r4)
end

# ╔═╡ 38236c4c-dad2-471c-b098-0716eaad9f77
md"""
## Schleifen
"""

# ╔═╡ ad00afb5-63b1-4975-ac29-e1463ba2f15c
md"In den meisten Fällen werden Schleifen dazu genutzt, um über Daten-Kontainer, wie Arrays, Tuples, Dicts, etc. zu iterieren."

# ╔═╡ 98f08e1e-e5da-47de-aaf4-6f02a02cb251
md"### While-Schleife"

# ╔═╡ 855410f1-0d89-4aca-99f4-89c02554eef8
md"""
Die `while`-Schleife hat die folgende Struktur
```julia

while <boolsche-Bedingung>
   <Schleifen-Körper>
end

```

Beispiel:

```julia 
while true
	println("Toller VHS-Kurs")
end
```
Dies ist eine Endlos-Schleife, d.h. es wird in der Konsole untereinander immer
wieder `Toller VHS-Kurs` ausgegeben. Diese Ausgabe kann nur durch ein Abbrechen des 
Programmes gestoppt werden.

#### Beispiel:

"""

# ╔═╡ 5955efa5-b7ed-4bc7-a60e-ee0ad816166b
begin
	zaehler = 1
	while zaehler <= 10
		println("Toller VHS-Kurs (Ausgabe: $zaehler)")
		zaehler +=1
	end
end

# ╔═╡ 114b260d-8ba3-4a09-8375-c021da9cf532
md"Nutzung der `while`-Schleife, um über ein Array zu iterieren:"

# ╔═╡ 2edbb136-ebb8-448f-a76e-ca7a98200ecc
begin 
	teilnehmer_namen = ["Frank", "Markus", "Thomas", "Heinrich"]
	index = 1
	while index <= length(teilnehmer_namen)
    	println("Hallo $(teilnehmer_namen[index]), wie geht es Dir?")
    	global index += 1
	end
end

# ╔═╡ 1cb77434-2530-44c2-8ea1-59c5b90a3f00
md"""### For-Schleife

Die `for`-Schleife hat die folgende Struktur

```julia
for <Variable> in / ∈ <Iterator>
	<Schleifen-Körper>
end
```

Beispiel:
"""

# ╔═╡ 4079c83b-5f4c-4e75-a3c8-1f16ae7f09c5
for name in ["Frank","Tobias","Karla","Ewa"]
	println(name)
end

# ╔═╡ 1ffcab90-d482-4ae8-818e-1cbfbfa015eb
for zahl in m1 # iteriere über Menge 
	print("$zahl ")
end

# ╔═╡ 6369ae98-35b7-4d69-93c4-55e8f2f1c57f
begin
	for zahl in r4
		print("$zahl ")
	end
	print("lift off")
end

# ╔═╡ 4962b3a1-c990-4cb8-94ab-0c229d324dc3
md"""
#### continue-Keyword

Überspringen eines Elementes - continue-Keyword
"""

# ╔═╡ 1c6bc7f7-36cc-4568-ad4d-ea5cba648a7a
for name in ["Ewa","Frank","Tobias","Karla"]
	if endswith(name,"a")
		continue
	end
	println(name)
end

# ╔═╡ 2ac468d7-da8c-42ae-9259-21e898ed9a79
md"""
#### break-Keyword
Abbrechen der for-Schleife durch Bedingung - break-Keyword
"""

# ╔═╡ 04c33e60-ac9a-4a24-a70c-d2ecc27a9ea5
for name ∈ ["Ewa","Frank","Tobias","Karla"]
	if startswith(name,"T")
		break
	end
	println(name)
end

# ╔═╡ 1f669e06-88c1-40d4-a58a-248b0057843d
md"""
#### Übung 4: 
1. Schreibe eine While-Schleife, die nach einer Benutzereingabe fragt und solange weiterläuft, bis der Benutzer "exit" eingibt. Wenn der Benutzer nicht "exit" eingibt soll das Programm den gegebenen Text in umgekehrter Reihenfolge ausgeben." 
2. Schreibe eine For-Schleife, die nur gerade Zahlen von 2 bis 100 ausgibt.
3. Verwende den in-Operator mit einem benannten Range, um eine For-Schleife zu erstellen, die die Buchstaben "A" bis "E" ausgibt. Hinweis: schaue die das Kommando `range` an.
"""

# ╔═╡ 8ac5955a-11f8-4006-88f4-7bb543a5b467
md"## Hilfsfunktionen für Notebook"

# ╔═╡ 7aea8983-9d64-4e10-8fa1-c69c42c0eade
function plot_vector_addition(v1::Vector,v2::Vector)
	plot(legend=true, ratio=1, xlims=(-1, 5), ylims=(-1, 5))
	plot!([0,v1[1]],[0,v1[2]], color=:blue, label="Vector v₁",arrow=(:closed, 2.0))
	plot!([0,v2[1]],[0,v2[2]], color=:red, label="Vector v₂",arrow=(:closed, 2.0))
	plot!([v1[1],v1[1]+v2[1]],[v1[2],v1[2]+v2[2]], color=:red, label="Vector v₂",arrow=(:closed, 2.0))
	plot!([0, vs[1]],[0,vs[2]] , color=:green, label="v₁ + v₂",arrow=(:closed, 2.0))	
end

# ╔═╡ aec21670-3f10-4573-925d-d1a77b73c43e
plot_vector_addition(v1,v2)

# ╔═╡ 640b0485-17eb-4107-96e2-b175aaacf419
begin
	hint(text) = Markdown.MD(Markdown.Admonition("hint", "Antwort", [text]))
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
FileIO = "~1.16.2"
Images = "~0.26.0"
Plots = "~1.39.0"
PlutoUI = "~0.7.54"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.6"
manifest_format = "2.0"
project_hash = "95b24dffa4850c23dc55df3313cac2e4ab466d46"

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

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "0c5f81f47bbbcf4aea7b2959135713459170798b"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.5"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "601f7e7b3d36f18790e2caf83a882d88e9b71ff1"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.4"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

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

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "cd67fc487743b2f0fd4380d4cbd3a24660d0eec8"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.3"

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

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "8cfa272e8bdedfa88b6aefbbca7c19f1befac519"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.3.0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

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

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

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

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

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

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "8e2d86e06ceb4580110d9e716be26658effc5bfd"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.8"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "da121cbdc95b065da07fbb93638367737969693f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.8+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "e94c92c7bf4819685eb80186d51c43e71d4afa17"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.76.5+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "899050ace26649433ef1af25bc17a815b3db52b7"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.9.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "abbbb9ec3afd783a7cbd82ef01dcd088ea051398"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.1"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

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

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "a53ebe394b71470c7f97c2e7e170d51df21b17af"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.7"

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

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d986ce2d884d49126836ea94ed5bfb0f12679713"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

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

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

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

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a12e56c72edee3ce6b96667745e6cbbe5498f200"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

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

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "862942baf5663da528f66d24996eb6da85218e76"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "ccee59c6e48e6f2edf8a5b64dc817b6729f99eb5"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.39.0"

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

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

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

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

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

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "7209df901e6ed7489fe9b7aa3e46fb788e15db85"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.65"

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

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "5f24e158cf4cee437052371455fe361f526da062"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.6"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "801cbe47eae69adc50f36c3caec4758d2650741b"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.2+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

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
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a68c9655fbe6dfcab3d972808f1aafec151ce3f8"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.43.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

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

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

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
# ╟─dd8698ee-affb-11ee-084e-1ffdbb6f6a08
# ╟─65fb214d-3782-4de9-b8dd-34efb047f6c9
# ╟─4bffdb22-06fc-465f-9257-ab2974230512
# ╟─7ddad624-511d-4907-9d5c-84d1bd90731c
# ╠═fa54a5ab-fae6-43f3-9ac7-543a9ecd0e52
# ╟─694c26d3-00be-4369-896b-36354b8c4549
# ╠═1a5b9dab-db33-4fab-8f03-73f8561fbebc
# ╠═6774a4bb-4b9c-4240-80d6-528fa8bde92e
# ╠═9fe066e4-8e90-445c-9d97-ab8dd6ce162e
# ╟─95bd760c-e807-4d97-91ec-4eb4cf368416
# ╠═1bd57323-0d30-4853-b6a0-c225570441a7
# ╠═febe956a-5d6a-4c82-82ff-39167a624a70
# ╟─83856275-e0af-489f-a529-f8c456aaae87
# ╠═49e0160c-b6c1-402e-b909-baaa9e4a3a80
# ╟─6d80fd45-7311-4cb0-ad55-80e631f05909
# ╠═77311223-fea8-44ae-b3ef-616e954272dd
# ╟─626d6b76-9cdf-4866-9cbc-961f89ac6146
# ╟─ac149eee-8553-47ab-bff9-9631810b1a04
# ╠═20472e7d-0d12-41c4-953c-2c8d9a293c98
# ╟─658be04e-c557-4f2b-82af-fae89a392163
# ╟─f5dbfb3f-0bf6-444f-9d91-d730ebdcc686
# ╠═44de9b65-9e43-450c-974a-4d9844315160
# ╟─8f8abd58-cbac-4ead-b1f1-09dc58f3aff9
# ╠═a321cf2c-4127-478b-80cb-81c43f5bfa60
# ╠═6146a1e4-4f71-441b-bd29-b2568a7bc762
# ╟─7a807a7f-5b61-4404-9344-51c3234db1c7
# ╠═bf8f94c2-f323-485c-80c9-17e9ff313aa7
# ╟─532e7dbb-752e-4cde-8fd0-f167819db312
# ╠═c0956429-4b92-45b0-903a-2f97ee2db9c5
# ╠═94617964-1f9f-49b8-9450-12f61d7b7791
# ╠═15611340-6181-4608-8ed0-898b3bcae2d9
# ╠═216371f0-7bbd-4fe5-9ab8-179c75ee20aa
# ╠═0c31d665-56da-42c1-9507-67e64f890eab
# ╟─26f426b3-62ea-4845-af79-1005683f004c
# ╠═01ca76ae-a730-4853-9c9b-58c15148c493
# ╟─de7633f8-9426-4605-88e6-96a90a172f68
# ╠═d2dc0c10-4c3a-46b6-b334-68ce48eb3f5b
# ╟─98104de1-935a-4002-8297-671cf6fcd274
# ╠═7f2ec829-d0c5-48f0-9028-ba9b85bbb410
# ╟─392a15b4-31b4-4ea4-9ed0-dae40cbf59bd
# ╟─67b6a6f4-5f1c-46ce-8968-1ae5768f75e0
# ╟─259b58d4-026b-4ace-8bf2-ea810d2932f1
# ╟─125c13ae-cbbd-489a-ab8a-f40364be1a84
# ╠═ee16caec-c2c7-4e3b-b09e-d7bb622d073c
# ╠═fa740a2e-0db7-48b9-b025-4a8e7148b90b
# ╟─1ec27440-0af1-44c0-a09e-450fbc11ff2d
# ╠═de322420-6d63-4d3e-9250-dfb2e862db7f
# ╟─432729b5-3a62-4ea8-8f3a-ed70edc23391
# ╠═69625c58-5d2e-4190-8d62-bdf730190e11
# ╠═a241b4c3-6c1e-4435-9c53-ce10c50ce829
# ╟─0cbbd97f-cda9-4153-b990-310b54f3f782
# ╠═3343586a-3828-4128-b31f-e1cacb3b0295
# ╠═7a7f45c7-d674-4560-96a8-a533b926eede
# ╟─d05bd3a0-166b-4e0a-9bea-a02e0c17b1a0
# ╠═e033443d-fde2-42ea-9608-e00be347b3ee
# ╠═8fa20894-d4a7-4f97-94ab-26aec0c043a1
# ╠═6102c977-34cc-4036-bf71-28515bdaf395
# ╠═aec21670-3f10-4573-925d-d1a77b73c43e
# ╟─0b18aa82-6d31-4023-b5ad-64df9303e6ef
# ╟─00afa9f3-d7b9-492c-a0ee-c3946e9dc842
# ╠═32f8b5ee-bef4-4cfb-9dad-e9b4cf93ec66
# ╠═f3802ee2-fe0e-4177-afe6-94c81c38fffc
# ╟─8a06860b-a85f-446f-82d1-142594af5581
# ╠═7ef9db2d-89dd-4b6f-9646-cc6e4c9ed4c3
# ╠═378a4897-9736-4dff-b965-a2f5b6ca7c0e
# ╟─51252320-8757-4882-acf8-9402914957e7
# ╠═dd5662cd-2e4e-407f-a2cd-61875a764a6c
# ╟─681c83e8-0ba5-4724-9c4d-53b9aa865ade
# ╠═fe033625-d6b1-47a0-944a-46ba8d3fcfc5
# ╠═66f0e5b2-9c72-4cf2-9f73-a244310e8421
# ╠═7069abc3-a33d-4781-b500-9983a5de8e4d
# ╟─a14f4c5d-9f7e-426f-902e-c7072275c36f
# ╠═25172caf-42f7-4ac8-8948-522e48ac20ce
# ╠═b8ad5e08-d012-42a0-b6a1-f41c47f4a95c
# ╟─e5d7cf38-b7ac-48d0-8e35-9eb332545c76
# ╠═f6099034-1179-4a16-931f-7981aed0a6e5
# ╟─7b7721f0-c068-4e9c-8e4c-76f151bc0731
# ╠═13b77128-cf5a-4e63-b2be-1e9adf491741
# ╠═0974f396-5578-4453-b094-4d3b96058dd6
# ╠═b3f905f3-67a9-4d51-8a3e-289b893b59d7
# ╠═45ca7ba4-d562-4d40-89c9-72121818d6b4
# ╟─f3ab8b09-a273-4044-a62c-1c2ee51d3935
# ╠═a2437175-2f4c-4239-8d18-89e6ea702634
# ╠═c4826478-e39e-4ee4-a8e2-e717b15afb54
# ╟─d34befae-d1be-4cdd-8feb-55f79bd37fee
# ╠═11d53620-eef9-4294-8462-57269ffb2f5f
# ╠═0b48c2ab-90ce-4e2c-9336-821b7a1aeb34
# ╠═2df0b930-95c2-43e7-bce0-196cf622b0fa
# ╠═11eacb65-7526-455c-85cd-867866a7bc4d
# ╟─24c0b295-4738-4727-bbaa-f84e23066037
# ╟─4b87d085-a814-4606-bc7f-79a48e29eafc
# ╟─b20cf4c6-1391-4e6d-b348-971176a1915c
# ╟─bfbe7b02-1b6f-4c07-9143-d12c7db73e64
# ╠═c42d2bfc-2d1c-456f-b09a-d68c56973f7b
# ╠═2b707f5a-f258-4b52-a9ce-8050f6e70b71
# ╠═f42b5d23-c122-4401-b32d-2878cb2f4ea4
# ╠═c26961b7-5daf-4570-b10f-918b0ed11581
# ╟─7e23f17c-9b87-4fca-bc60-38515443124a
# ╟─b734cfe0-5ad1-4f5c-bb50-25430d9df3a9
# ╠═291bbe09-a638-4a05-9681-b1db737c6ffe
# ╟─851c1c0b-24b1-4707-9eb8-15ced8ff867d
# ╠═dc0ac6e4-6bc7-47fc-8aec-7484ce769554
# ╟─d4b28d7e-03a9-42c0-8054-bfa94ad69b76
# ╟─0cdd697b-2253-4029-b513-9daebe1b15cf
# ╠═a9abd3fb-f74a-4bd8-9862-3bfafec6f579
# ╠═aa0e87f3-8795-4a57-8068-d1afaf3856db
# ╟─1b13bafe-e46d-46d7-b49b-6534bd112627
# ╠═a03db1b0-0145-4f2e-8d02-93617348a73a
# ╟─10efb5d1-146e-476c-bf37-f944a9492626
# ╠═2a7913e4-22d7-4c07-8ee4-c05a31638e2f
# ╠═8170c94b-ed7a-462d-b4ec-c2cc8ce4f057
# ╟─e0c197a2-b798-49c6-98d0-4396fc2695df
# ╠═c921a63c-5e9f-48c9-9e4f-62997eb0dfa9
# ╟─af5c06b8-fcfe-442d-8d16-49ed808d9d8d
# ╟─04e2bfd7-ee1b-4f27-a1a6-3f30e921a0e9
# ╠═a38375a6-8c3b-45a1-a85e-cd31c7cb82ab
# ╠═1d4ec249-44cc-4b87-8b37-c75ad2bd982a
# ╟─53b4636b-e021-4e33-a65a-628ac31b48da
# ╟─563d8d0b-aa48-4002-b578-e54d4aa8b283
# ╟─31ecf613-811f-41a5-9d93-255d8a611b41
# ╠═784872e1-cb49-42ee-990b-0750c0e89585
# ╠═28c75d66-ec91-4e97-b67c-fea5bda2915e
# ╟─af3a9b41-d940-4c90-a0f5-72416745aece
# ╠═52d85fe0-31b9-4056-ab6d-03153c2de1c2
# ╟─de243369-924e-4f63-826e-a25269e56bd5
# ╟─36d2055f-74fe-4c35-a104-bc66a30eda9f
# ╠═ab4f703c-dbf9-4331-bd85-2a7f72beae34
# ╠═5b47b087-3a8a-43c5-bd0d-65f336570a3b
# ╟─aff50e48-af73-4198-905d-7b6e545fb429
# ╟─1f4af46a-41bf-4f9a-b464-53795930048b
# ╠═d429861a-4a5b-4106-b9c7-8741b990ae68
# ╟─df62f062-031b-454d-bdb6-ff638847e8ed
# ╠═f609d6f9-28ff-4ad0-9a2f-531d29047625
# ╠═469ba0cb-c9a9-465b-a8c1-55ac3adccf42
# ╟─3b27cd67-b73b-4bb8-aa8f-081b8ac1b807
# ╠═4ae9a1ac-2272-46b1-9619-5ae95aaa6715
# ╟─582f0ee1-febc-4774-8ff2-ac68ae81ada4
# ╠═8bb5c9e7-08ad-4694-ba43-1cb79c2dd1d5
# ╠═5d7610ff-c5ad-4a2c-9cb9-ba4efcbffb7e
# ╠═bae5735c-c529-4ba1-a4bf-14c227adcc38
# ╟─d770789a-1c3e-44b1-bd39-657c8060276d
# ╠═273738b2-3781-4374-b619-d69bc481cf89
# ╠═f095bff5-0c7a-4763-bdd7-7eb9f85718eb
# ╟─e28bda3f-f1fa-4dab-9449-8c7b37eface6
# ╟─7adb3cbb-ea05-43f9-94ee-38f99863f8f8
# ╠═291ea98a-a3c0-4326-8d14-ee1c106a5de8
# ╠═835ba65f-1891-4e4b-9de4-dd40d59649c7
# ╠═42a3195b-e350-4269-993a-446556a11397
# ╠═2ea39680-c858-43e0-9679-2cc6ae6426a8
# ╠═d6fbc218-be8b-4f67-8f35-893804c482b4
# ╠═ef3220b1-abe3-4961-a28e-9e36ad85dc01
# ╠═9c654798-b87d-47de-8ca1-6e44937d7d57
# ╠═79f7ec2c-77af-4569-9159-dfd490862697
# ╠═b710b7c4-37d7-4b63-b0c4-82e5f69b5ed4
# ╠═e44a3e75-3de4-46ce-b6cd-f87f925a57f7
# ╠═795b4f8c-b148-4351-b0bd-dbf7fc17a8fa
# ╠═21547e7c-cfb9-4a78-8ee5-f16777bf9410
# ╠═80b580fe-f374-43b4-bac1-f8b5c1c62995
# ╠═23015954-b2c9-4200-b849-7af9ce013655
# ╠═2f1dfdb9-79ff-4687-b685-58d568945d3b
# ╠═961708cd-3889-4289-bf8b-7c9f26f93d32
# ╟─fd6b4a7c-6bc8-4cb2-9c36-2190678f9ad8
# ╠═b06f108f-84c5-4a57-b2d4-3dd32b18f39a
# ╠═f04945b6-e57a-4781-9ea2-2093ca154d58
# ╠═30d7794a-e020-4853-95a5-b55dae8fdb5f
# ╠═be1eb45e-ff60-401d-91aa-d28b60996bce
# ╠═c50bd5cb-e6bd-449f-8354-b4be99af60fa
# ╠═24ffe410-2558-4f08-b770-5ed317859e39
# ╟─38236c4c-dad2-471c-b098-0716eaad9f77
# ╟─ad00afb5-63b1-4975-ac29-e1463ba2f15c
# ╟─98f08e1e-e5da-47de-aaf4-6f02a02cb251
# ╟─855410f1-0d89-4aca-99f4-89c02554eef8
# ╠═5955efa5-b7ed-4bc7-a60e-ee0ad816166b
# ╟─114b260d-8ba3-4a09-8375-c021da9cf532
# ╠═2edbb136-ebb8-448f-a76e-ca7a98200ecc
# ╟─1cb77434-2530-44c2-8ea1-59c5b90a3f00
# ╠═4079c83b-5f4c-4e75-a3c8-1f16ae7f09c5
# ╠═1ffcab90-d482-4ae8-818e-1cbfbfa015eb
# ╠═6369ae98-35b7-4d69-93c4-55e8f2f1c57f
# ╟─4962b3a1-c990-4cb8-94ab-0c229d324dc3
# ╠═1c6bc7f7-36cc-4568-ad4d-ea5cba648a7a
# ╟─2ac468d7-da8c-42ae-9259-21e898ed9a79
# ╠═04c33e60-ac9a-4a24-a70c-d2ecc27a9ea5
# ╟─1f669e06-88c1-40d4-a58a-248b0057843d
# ╟─8ac5955a-11f8-4006-88f4-7bb543a5b467
# ╟─7aea8983-9d64-4e10-8fa1-c69c42c0eade
# ╟─640b0485-17eb-4107-96e2-b175aaacf419
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
