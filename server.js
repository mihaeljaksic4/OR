const express = require('express');
const { Pool, types } = require('pg');
types.setTypeParser(1700, parseFloat);

const app = express();
const PORT = 3000;

const pool = new Pool({
    host: 'localhost',
    port: '5433',
    user: 'postgres',
    password: process.env.PGPASSWORD,
    database: 'ORserije'
});

app.use(express.static(__dirname));

const UPIT = `
            SELECT s.id, s.naziv, s.zemlja,
                   json_build_object('naziv', m.naziv, 'vrsta', m.vrsta) AS mreza,
                   s.godina_pocetka, s.godina_zavrsetka, s.broj_sezona, s.broj_epizoda,
                   s.prosjecno_trajanje_epizode, s.ocjena,
                   (SELECT json_agg(z.naziv ORDER BY z.naziv)
                      FROM serija_zanr sz JOIN zanr z ON z.id = sz.zanr_id
                     WHERE sz.serija_id = s.id) AS zanrovi,
                   (SELECT json_agg(json_build_object('ime', o.ime, 'prezime', o.prezime) ORDER BY o.id)
                      FROM serija_kreator sk JOIN osoba o ON o.id = sk.osoba_id
                     WHERE sk.serija_id = s.id) AS kreatori,
                   (SELECT json_agg(json_build_object('ime', o.ime, 'prezime', o.prezime, 'lik', u.lik) ORDER BY u.redoslijed)
                      FROM uloga u JOIN osoba o ON o.id = u.osoba_id
                     WHERE u.serija_id = s.id) AS uloge
            FROM serija s
            JOIN mreza m ON m.id = s.mreza_id
`;

const UVJETI = {
    naziv:            `s.naziv ILIKE $1`,
    zemlja:           `s.zemlja ILIKE $1`,
    mreza:            `m.naziv ILIKE $1`,
    godina_pocetka:   `s.godina_pocetka::text ILIKE $1`,
    godina_zavrsetka: `COALESCE(s.godina_zavrsetka::text, 'u tijeku') ILIKE $1`,
    broj_sezona:      `s.broj_sezona::text ILIKE $1`,
    broj_epizoda:     `s.broj_epizoda::text ILIKE $1`,
    trajanje:         `s.prosjecno_trajanje_epizode::text ILIKE $1`,
    ocjena:           `s.ocjena::text ILIKE $1`,
    zanr: `EXISTS (SELECT 1 FROM serija_zanr sz JOIN zanr z ON z.id = sz.zanr_id
                   WHERE sz.serija_id = s.id AND z.naziv ILIKE $1)`,
    kreator: `EXISTS (SELECT 1 FROM serija_kreator sk JOIN osoba o ON o.id = sk.osoba_id
                      WHERE sk.serija_id = s.id AND o.ime || ' ' || o.prezime ILIKE $1)`,
    glumac: `EXISTS (SELECT 1 FROM uloga u JOIN osoba o ON o.id = u.osoba_id
                     WHERE u.serija_id = s.id AND o.ime || ' ' || o.prezime ILIKE $1)`,
    lik: `EXISTS (SELECT 1 FROM uloga u WHERE u.serija_id = s.id AND u.lik ILIKE $1)`,
};

function csvPolje(vrijednost) {
    if (vrijednost === null || vrijednost === undefined) return '';
    const tekst = String(vrijednost);
    if (/[",\n"]/.test(tekst)) {
        return '"' + tekst.replace(/"/g, '""') + '"';
    }
    return tekst;
}

function uCsv(serije) {
    const redovi = ['id,naziv,zemlja,mreza,vrsta_mreze,godina_pocetka,godina_zavrsetka,broj_sezona,broj_epizoda,prosjecno_trajanje_epizode,ocjena,zanrovi,kreatori,glumac_ime,glumac_prezime,lik'];

    for (const s of serije) {
        for (const u of s.uloge) {
            const red = [
                s.id, s.naziv, s.zemlja, s.mreza.naziv, s.mreza.vrsta,
                s.godina_pocetka, s.godina_zavrsetka, s.broj_sezona, s.broj_epizoda,
                s.prosjecno_trajanje_epizode, s.ocjena.toFixed(1),
                s.zanrovi.join('; '),
                s.kreatori.map(k => k.ime + ' ' + k.prezime).join('; '),
                u.ime, u.prezime, u.lik,
            ];
            redovi.push(red.map(csvPolje).join(','));
        }
    }
    return redovi.join('\n') + '\n';
}

app.get('/api/serije', async (req, res) => {
    try {
        const pojam = (req.query.pojam || '').trim();
        const atribut = req.query.atribut || 'sve';

        let sql = UPIT;
        let parametri = [];

        if (pojam !== '') {
            let uvjet;
            if (atribut === 'sve') {
                uvjet = Object.values(UVJETI).map(u => `(${u})`).join(' OR ');
            } else if (UVJETI[atribut]) {
                uvjet = UVJETI[atribut];
            } else {
                return res.status(400).json({ greska: 'Nepoznat atribut' });
            }
            sql += ' WHERE ' + uvjet;
            parametri = ['%' + pojam + '%'];
        }

        sql += ' ORDER BY s.id';
        const rezultat = await pool.query(sql, parametri);

        const serije = rezultat.rows;

        if (req.query.format === 'csv') {
            res.attachment('serije_filtrirano.csv');
            res.send(uCsv(serije));
        } else if (req.query.format === 'json') {
            res.attachment('serije_filtrirano.json');
            res.send(JSON.stringify(serije, null, 2));
        } else {
            res.json(serije);
        }
    } catch (greska) {
        console.error(greska);
        res.status(500).json({ greska: 'greska pri citanju iz baze' });
    }
});

app.listen(PORT, () => {
    console.log(`Posluzitelj radi na http://localhost:${PORT}`);
});