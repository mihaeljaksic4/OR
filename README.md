# Televizijske serije

Otvoreni skup podataka o 10 poznatih američkih i britanskih televizijskih serija. Za svaku seriju navedeni su mreža na kojoj se izvorno prikazivala, zemlja podrijetla, godine početka i završetka, broj sezona i epizoda, prosječno trajanje epizode i ocjena. Svaka serija povezana je s jednim ili više žanrova i kreatora te s tri glavne uloge (glumac i lik).

## Metapodaci

| Metapodatak       | Vrijednost                                                                                                                           |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Naziv skupa       | Televizijske serije                                                                                                                  |
| Autor             | Mihael Jakšić                                                                                                                        |
| Verzija           | 2.0                                                                                                                                  |
| Licenca           | [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) – podaci su u javnom vlasništvu i mogu se slobodno koristiti |
| Jezik             | hrvatski (nazivi serija, likova i mreža su izvorni)                                                                                  |
| Ključne riječi    | televizija, serije, glumci, kreatori, žanrovi                                                                                        |
| Vremenski obuhvat | 1999. – 2026.                                                                                                                        |
| Prostorni obuhvat | SAD, Velika Britanija                                                                                                                |
| Broj instanci     | 10 serija, 30 uloga                                                                                                                  |
| Formati           | CSV, JSON, JSON Schema, SQL dump                                                                                                     |
| Kodiranje         | UTF-8                                                                                                                                |
| Izvor podataka    | [IMDb](https://www.imdb.com)                                                                                                         |
| Baza podataka     | PostgreSQL                                                                                                                           |

## Opis atributa

| Atribut                      | Tip                                    | Opis                                                              |
| ---------------------------- | -------------------------------------- | ----------------------------------------------------------------- |
| `id`                         | cijeli broj                            | Jedinstveni identifikator serije                                  |
| `naziv`                      | tekst                                  | Izvorni naziv serije                                              |
| `zemlja`                     | tekst                                  | Zemlja podrijetla                                                 |
| `mreza`                      | objekt (`naziv`, `vrsta`)              | Mreža ili streaming servis na kojem se serija izvorno prikazivala |
| `godina_pocetka`             | cijeli broj                            | Godina prve epizode                                               |
| `godina_zavrsetka`           | cijeli broj ili `null`                 | Godina zadnje epizode; `null` ako serija još traje                |
| `broj_sezona`                | cijeli broj                            | Ukupan broj sezona                                                |
| `broj_epizoda`               | cijeli broj                            | Ukupan broj epizoda                                               |
| `prosjecno_trajanje_epizode` | cijeli broj                            | Prosječno trajanje epizode u minutama                             |
| `ocjena`                     | decimalni broj                         | Ocjena korisnika IMDb-a (0 – 10)                                  |
| `zanrovi`                    | niz tekstova                           | Žanrovi serije                                                    |
| `kreatori`                   | niz objekata (`ime`, `prezime`)        | Kreatori serije                                                   |
| `uloge`                      | niz objekata (`ime`, `prezime`, `lik`) | Tri glavne uloge, poredane po važnosti                            |

U **JSON-u** je svaka serija jedan objekt, a mreža, žanrovi, kreatori i uloge su ugniježđeni u njega. Strojno čitljiv opis strukture nalazi se u `schema.json`.

U **CSV-u** je jedan redak po ulozi, pa se podaci o seriji ponavljaju u tri retka. Žanrovi i kreatori su odvojeni znakom `;`, mreža je razdvojena u stupce `mreza` i `vrsta_mreze`, a uloga u `glumac_ime`, `glumac_prezime` i `lik`. Prazno polje znači da vrijednost ne postoji.

## Model baze podataka

| Tablica               | Sadržaj                                       | Veza                           |
| --------------------- | --------------------------------------------- | ------------------------------ |
| `serija`              | glavni entitet                                | —                              |
| `mreza`               | mreže i streaming servisi                     | 1:N (jedna mreža, više serija) |
| `zanr`, `serija_zanr` | žanrovi                                       | M:N                            |
| `osoba`               | kreatori i glumci (ista osoba se ne ponavlja) | —                              |
| `serija_kreator`      | kreatori serije                               | M:N                            |
| `uloga`               | glumac u seriji, lik i redoslijed             | M:N                            |

## Sadržaj repozitorija

| Datoteka                    | Sadržaj                                                            |
| --------------------------- | ------------------------------------------------------------------ |
| `serije.csv`, `serije.json` | Cijeli skup podataka                                               |
| `schema.json`               | Metapodaci u formatu JSON Schema                                   |
| `serije_dump.sql`           | Dump baze s podacima                                               |
| `index.html`                | Početna stranica s opisom i poveznicama za preuzimanje             |
| `datatable.html`            | Tablični prikaz s filtriranjem i preuzimanjem filtriranih podataka |
| `server.js`, `package.json` | Poslužitelj (Node.js, Express, pg)                                 |

## Pokretanje

```sh
createdb ORserije
psql -d ORserije -f serije_dump.sql
npm install
npm start
```

Stranica je dostupna na http://localhost:3000.

## Povijest verzija

- **2.0**: dodane tablice `mreza`, `zanr`, `serija_zanr`, `osoba`, `serija_kreator` i `uloga` (umjesto `glavna_uloga`); uz glavnu ulogu dodana još dva glumca i likovi; više kreatora i žanrova po seriji; dodani `schema.json`, web sučelje (`index.html`, `datatable.html`) i poslužitelj
- **1.0**: prva verzija, 10 serija s jednom glavnom ulogom
