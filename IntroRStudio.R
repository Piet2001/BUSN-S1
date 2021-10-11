---
title: "Introductie SQL in RStudio"
date: "September 2019"
From: "Hans van Halteren"
output: html_document
---

De gemakkelijkste manier om met SQL aan de slag te gaan in RStudio, is gebruik te maken van de ingebouwde sqlite database. We kunnen een excel document inlezen maar deze moeten we dan middels een paar commando's opslaan in de ingebouwde sqlite database. Die instructies krijg je van ons. 

We starten met een uitgebreide setup chunk waarin we:

1. alle packages laden die we gebruiken;
1. de data van een excel file inlezen in een R data frame
1. een in-memory sqlite database maken
1. het ingelezen R data frame als table  in de sqlite database copieren


Benodigde libraries
```{r setup, include=FALSE}
library(tidyverse)
library(readxl)
library(lubridate)
library(DBI)
```


Lees het excel bestand in
```{r setup2, include=FALSE}

# Verander de bestandsnaam als je een andere excel gaat toepassen
df <- read_excel("Data/Kleine dataset.xlsx")

# aanpassen als een andere excel gebruikt gaat worden dan bovenstaande. 
df <- drop_na(df, Klantnummer)

```



Deze code is nodig om SQL statements los te kunnen laten op het excel bestand. 
```{r}

#Onderstaande niet veranderen !
con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")


#Als er in de tabel variabelen met datums voorkomen, dan moeten die aangepast worden zodat de datumvelden alst teksttype worden opgeslagen en niet als datumtijd type. Zie onderstaand voorbeeld: copy_to(con, mutate_at(df, vars(ends_with("datum")), as.character), "factOrders")
#copy_to(con, mutate_at(df, vars(ends_with("datum")), as.character), "factOrders")
copy_to(con,df, "MijnTabel")


knitr::opts_chunk$set(connection = "con")

```



Het resultaat van een SQL query in een sql code chunk wordt als een reguliere sql result set getoond. 
Voorbeeld van een query op de MijnTabel tabel
```{sql, connection = "con"}
select Klantnaam, Soort, sum(verkoopprijs) as TotaalVerkoop, count(soort) as Aantal
from MijnTabel
where Klantnummer = 1003
group by Soort

```

Nog een voorbeeld waarbij het resultaat van een SQL in een ggplot wordt uitgedrukt.

We kunnen het resultaat van een sql query in een sql code chunk ook capturen in een R dataframe. Dat doen we door in de chunk options aan te geven dat we de output van de query willen vangen in een R variabele.

```{sql, , connection = "con", output.var = "df_result"}
select *
from Mijntabel
```

Vervolgens kunnen we dit dataframe gebruiken als een reguliere R dataframe. We kunnen het dus gebruiken als input voor ggplot.

```{r}
ggplot(df_result, aes(Klantnummer, verkoopprijs)) +
  geom_col()
```




-------------------    Opdracht: maak verschillende eigen SQL's  op basis van de excel die je zelf hebt ingevoerd bij regel 28. Gebruik GGPLOT commando's om grafische representaties te maken.   -------------------------------



```{sql, connection = "con", output.var="df_result"}

Select 1

```


GGPLOT gedeelte
```{r}

```

