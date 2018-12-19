/*1. Quantitat de registres de la taula de vols:*/
SELECT COUNT(*)
FROM usairlineflights.flights;
/*2. Retard promig de sortida i arribada segons l’aeroport origen.*/

SELECT origin, avg(ArrDelay), avg(depDelay)
FROM usairlineflights.flights
group by origin;
/*3. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen. A més,
volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files):
LAX, 2000, 01, retard
LAX, 2000, 02,​ retard
LAX, 2000, 03,​ retard
...
LAX, 2000, 12,​ retard
LAX, 2001​, 01,​ retard
...
LAX, 2001, 12,​ retard
ONT​, 2000​, 01,​ retard
ONT, 2000, 02,​ retard
etc.*/
SELECT origin, colYear, colMonth, avg(ArrDelay)
FROM usairlineflights.flights
group by origin, colYear, colMonth
order by origin;

/*4. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen (mateixa consulta que abans i amb el mateix ordre). Però a més, ara volen que en comptes
del codi de l’aeroport es mostri el nom de la ciutat.
Los Angeles, 2000, 01, retard
Los Angeles, 2000, 02, retard*/

SELECT a.City, f.colYear, f.colMonth, avg(ArrDelay)
FROM usairlineflights.flights f
LEFT JOIN usairlineflights.usairports a
ON f.origin=a.IATA
GROUP BY a.City, f.colYear, f.colMonth;


/*5. Les companyies amb més vols cancelats. A més, han d’estar ordenades de forma
que les companyies amb més cancelacions apareguin les primeres.*/
SELECT c.description, sum(f.Cancelled)
FROM usairlineflights.flights f
LEFT JOIN usairlineflights.carriers c
on f.uniquecarrier = c.carriercode
group by c.description
order by sum(cancelled) desc;

/*6. L’identificador dels 10 avions que més distància han recorregut fent vols.*/
SELECT f.flightID, f.distance
FROM usairlineflights.flights f
order by distance desc limit 10;

/*7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols
arriben al seu destí amb un retràs promig major de 10 minuts.*/
select c.description, avg(f.CarrierDelay)
from usairlineflights.flights f
left join usairlineflights.carriers c
on f.UniqueCarrier = c.CarrierCode;
