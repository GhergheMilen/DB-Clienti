create database lab5Tema
use lab5Tema

--Să se creeze tabela Clienţi cu următoarele câmpuri: codcl, dencl, judeţ, localitate,
--codpostal, vânzări şi să se insereze 18 înregistrări: 6 să fie din judeţul Timiş, 6 din judeţul
--Arad şi 6 din judeţul Bihor; cei din Timiş, 3 să fie din Timişoara – 2 dintre ei cu acelaşi
--cod poştal, 3 din Lugoj – 2 dintre ei cu acelaşi cod poştal, cei din Arad: 3 din Arad – 2
--dintre ei cu acelaşi cod poştal, 3 din Lipova – 2 dintre ei cu acelaşi cod poştal, cei din
--Bihor 3: din Oradea – 2 dintre ei cu acelaşi cod poştal, 3 din Salonta – 2 dintre ei cu
--acelaşi cod poştal.

create table Clienti
(
    codcl int primary key,
    dencl varchar(100),
    judet varchar(50),
    localitate varchar(50),
    codpostal varchar(10),
    vanzari decimal(10, 2)
);

insert into Clienti
values
    (1, 'Stefan Marius', 'Timis', 'Timisora', 300013, 160),
    (2, 'Dinca Laur', 'Timis', 'Timisora', 300013, 170),
    (3, 'Colt Mihai', 'Timis', 'Timisora', 300024, 180),
    (4, 'Popescu Ana', 'Timis', 'Lugoj', 305500, 190),
    (5, 'Zghembea Gorgiana', 'Timis', 'Lugoj', 305500, 200),
    (6, 'Cocosila Adrian', 'Timis', 'Lugoj', 305501, 160),
    (7, 'Popescu Andrei', 'Arad', 'Arad', 310001, 150),
    (8, 'Rasteanu Alex', 'Arad', 'Arad', 310001, 140),
    (9, 'Croitoru Dan', 'Arad', 'Arad', 310002, 130),
    (10, 'Grigore Paul', 'Arad', 'Lipova', 315400, 120),
    (11, 'Tigaie Andra', 'Arad', 'Lipova', 315400, 110),
    (12, 'Serban Tudor', 'Arad', 'Lipova', 315401, 100),
    (13, 'Popovici David', 'Bihor', 'Oradea', 410001, 120),
    (14, 'Iancu Luca', 'Bihor', 'Oradea', 410001, 140),
    (15, 'Croituru Nica', 'Bihor', 'Oradea', 410002, 170),
    (16, 'Gheorghe Daniel', 'Bihor', 'Salonta', 415500, 190),
    (17, 'Gogu Daria', 'Bihor', 'Salonta', 415500, 150),
    (18, 'Antonescu Olivia', 'Bihor', 'Salonta', 415501, 160)


--3. Să se execute gruparea şi calculul sumei vânzărilor la nivel de judeţ.
select judet, COUNT(codcl) as Numar_Vanzatori, SUM(vanzari) as Vanzari_Judet
from Clienti
group by judet
--4. Să se execute gruparea şi calculul sumei vânzărilor la nivel de localitate.
select localitate, COUNT(codcl) as Numar_Vanzatori, SUM(vanzari) as Vanzari_Localitate
from Clienti
group by localitate
--5. Să se afişeze o sumă totală a vânzărilor tuturor clienţilor.
SELECT SUM(vanzari) as Vanzari_Judet
from Clienti
--6. Să se execute gruparea şi calculul sumei vânzărilor la nivel de judeţ şi localtate.
SELECT judet , localitate, SUM(vanzari) as Vanzari
from Clienti
GROUP by judet, localitate
--7. Să se creeze subtotaluri folosind operatorul UNION, calculându-se suma vânzărilor la nivel de judeţ şi suma totală.
    SELECT '', judet, SUM(vanzari) as Vanzari_Judet
    from Clienti
    GROUP BY judet
UNION
    select 'Total', '', SUM(vanzari) as Vanzari_Localitate
    from Clienti
--8. Să se creeze subtotaluri folosind operatorul UNION, adăugându-se interogării anterioare gruparea şi calcularea 
--sumei vânzărilor la nivel de judeţ cea la nivel de localitate.
    SELECT '', judet, localitate, SUM(vanzari) as Vanzari
    from Clienti
    GROUP BY judet, localitate
UNION
    SELECT 'Total', '', '', SUM(vanzari) as Vanzar
    FROM Clienti
--9. Să se scrie interogarea SQL folosind operatorul ROLLUP, criteriul de grupare fiind doar judeţul.
SELECT COALESCE(judet, 'TOTAL'),
    SUM(vanzari) as Vanzari_Judet
from Clienti
GROUP by rollup(judet)
--10. Să se scrie interogarea SQL folosind operatorul ROLLUP, criteriile fiind judeţul şi localitatea.
SELECT COALESCE(judet, 'TOTAL'),
    COALESCE(localitate, 'TOTAL JUDET'),
    SUM(vanzari) as Vanzari_Judet
from Clienti
GROUP by rollup(judet,localitate)
--11. Să se scrie interogarea SQL folosind operatorul ROLLUP, criteriile fiind judeţul, localitatea şi codul poştal.
SELECT COALESCE(judet, 'TOTAL'),
    COALESCE(localitate, 'TOTAL JUDET'),
    COALESCE(codpostal, 'TOTAL LOCALITATE'),
    SUM(vanzari) as Vanzari_Judet
from Clienti
GROUP by rollup(judet,localitate,codpostal)
--12. Să se scrie interogarea SQL folosind operatorul CUBE, criteriul de grupare fiind doar judeţul.
--13. Să se scrie interogarea SQL folosind operatorul CUBE, criteriul de grupare fiind jueţul şi localitatea.
--14. Să se scrie interogarea SQL folosind operatorul CUBE, criteriul de grupare fiind judeţul, localitatea şi codul poştal.