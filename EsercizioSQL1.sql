/*
create table clienti(
numero_cliente INT primary KEY,
nome VARCHAR(50) not null,
cognome varchar(50)not null,
anno_di_nascita int not null,
regione_residenza varchar(50)not null
);

create table prodotti(
id_prodotto int primary key,
descrizione varchar(255) not null,
in_produzione boolean not null,
in_commercio boolean not null,
data_attivazione date,
data_disattivazione date
);

create table fornitori(
numero_fornitore int primary key,
denomizione varchar(100) not null,
regione_residenza varchar(50) not null
);

create table fatture(
numero_fattura int primary key,
tipologia varchar(50) not null,
importo decimal(10,2) not null,
iva decimal(5,2) not null,
id_cliente int not null,
data_fattura date not null,
numero_fornitore int not null,
foreign key (id_cliente) references clienti(numero_cliente),
foreign key (numero_fornitore) references fornitori(numero_fornitore)
);






-----------------cliente
INSERT into clienti (numero_cliente,nome,cognome,anno_di_nascita,regione_residenza)
values 
(4,'Vecchio','Lupo',1982,'Umbria');

--------------------fornitore

INSERT INTO fornitori (numero_fornitore, denominazione, regione_residenza)
VALUES (1, 'Fornitore ABC', 'Lazio');

INSERT INTO fornitori (numero_fornitore, denominazione, regione_residenza)
VALUES (2, 'Fornitore XYZ', 'Toscana');


INSERT INTO fornitori (numero_fornitore, denominazione, regione_residenza)
VALUES (3, 'Fornitore Alfa', 'Emilia-Romagna');


INSERT INTO fornitori (numero_fornitore, denominazione, regione_residenza)
VALUES (4, 'Fornitore Beta', 'Lombardia');


INSERT INTO fornitori (numero_fornitore, denominazione, regione_residenza)
VALUES (5, 'Fornitore Gamma', 'Sicilia');


-- Inserisci la prima fattura con IVA al 20%
INSERT INTO fatture (numero_fattura, tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
VALUES (1, 'Vendita', 1000.00, 20.00, 1, '2025-01-20', 1);

-- Inserisci la seconda fattura con IVA al 20%
INSERT INTO fatture (numero_fattura, tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
VALUES (2, 'Vendita', 500.00, 20.00, 1, '2025-01-20', 1);

-- Inserisci la terza fattura con IVA al 10%
INSERT INTO fatture (numero_fattura, tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
VALUES (3, 'Servizio', 300.00, 10.00, 1, '2025-01-20', 1);



-----------------------------------fattura

INSERT INTO fatture (numero_fattura, tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
VALUES (1, 'Vendita', 1000.00, 20.00, 1, '2025-01-20', 1);

INSERT INTO fatture (numero_fattura, tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
VALUES (2, 'Vendita', 500.00, 20.00, 1, '2025-01-20', 1);

INSERT INTO fatture (numero_fattura, tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
VALUES (3, 'Servizio', 300.00, 10.00, 1, '2025-01-20', 1);

-------------------------------------prodotti
INSERT INTO prodotti (id_prodotto, descrizione, in_produzione, in_commercio, data_attivazione, data_disattivazione)
VALUES (1, 'Prodotto A', TRUE, TRUE, '2017-03-15', NULL);


INSERT INTO prodotti (id_prodotto, descrizione, in_produzione, in_commercio, data_attivazione, data_disattivazione)
VALUES (2, 'Prodotto B', TRUE, TRUE, '2017-06-01', NULL);


INSERT INTO prodotti (id_prodotto, descrizione, in_produzione, in_commercio, data_attivazione, data_disattivazione)
VALUES (3, 'Prodotto C', TRUE, TRUE, '2017-11-20', NULL);

--------------------------------------esercizi---------------------------
//es1
select * from clienti where nome='Mario'


//es2
select 
nome as nome_cliente,
cognome as cognome_cliente
from clienti
where anno_di_nascita=1982;


--es3
select count(numero_fattura) as totale_fattture_iva20 from fatture where iva=20


--es4
select *
from prodotti
where extract(year from data_attivazione) = 2017
and data_disattivazione is null;


--es5 ----------------domanda----------------                 
SELECT f.numero_fattura, f.tipologia, f.importo, f.iva, f.data_fattura, c.numero_cliente, c.nome, c.cognome, c.anno_di_nascita, c.regione_residenza
FROM fatture f
JOIN clienti c ON f.id_cliente = c.numero_cliente
WHERE f.importo < 1000;


--es6---------------anche qui------------------
select f.numero_fattura,f.importo,f.iva,f.data_fattura,fo.denominazione
from fatture f
join fornitori fo on f.numero_fornitore=fo.numero_fornitore


--es7
SELECT 
    EXTRACT(YEAR FROM data_fattura) AS anno,
    COUNT(*) AS numero_fatture
FROM fatture
WHERE iva = 20
GROUP BY EXTRACT(YEAR FROM data_fattura)
ORDER BY anno;


--es8
select
extract(year from data_fattura) as anno,
count(*) as numero_fatture,
sum(importo) as somma_importi
from fatture
group by extract(year from data_fattura)
order by anno;


--es9 //extra
select extract(year from data_fattura) as anno,
count(*) as numero_fatture
from fatture
where tipologia='Vendita'
group by extract(year from data_fattura)
having count(*)>=2
order by anno;


--es10//extra
select sum(f.importo)as importo_totale,
c.regione_residenza 
from fatture f
join clienti c on f.id_cliente=c.numero_cliente
group by c.regione_residenza;


--es11//extra
INSERT into clienti (numero_cliente,nome,cognome,anno_di_nascita,regione_residenza)
values 
(5,'ultimo','orsoPolare',1980,'colorado');

INSERT INTO fatture (numero_fattura, tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
VALUES (4, 'Servizio', 300.00, 10.00, 5, '2025-01-20', 3);
*/

select count(*) as numero_clienti,
string_agg(c.nome|| ' '||c.cognome,', ') as cliente
from clienti c
join fatture f on f.id_cliente=c.numero_cliente
where c.anno_di_nascita = 1980
and f.importo>50
group by c.anno_di_nascita;
