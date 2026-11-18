-- Ejercicio 1 --
-- Enunciado: 
-- Escribe una consulta que recupere los vuelos (flights) con su identificador, que figuren con el status On Time. --

SELECT flight_id, status
FROM flights
WHERE status = 'On Time'

-- Ejercicio 2 --
-- Enunciado: 
-- Escribe una consulta que extraiga todas las columnas de la tabla bookings y muestre las reservas cuyo importe total sea mayor a 1.000.000 (unidades monetarias). --
SELECT *
FROM bookings
WHERE total_amount > 1000000

-- Ejercicio 3 --
-- Enunciado: 
-- Escribe una consulta que extraiga todas las columnas de la tabla de modelos de avión. --
SELECT *
FROM airplanes_data

-- Ejercicio 4 --
-- Enunciado:
-- Escribe una consulta que devuelva los identificadores de vuelo (flight_id) de los vuelos que se han operado con un Boeing 737.
SELECT DISTINCT flight_id
FROM routes r
JOIN flights f ON r.route_no = f.route_no 
WHERE r.airplane_code = '7M7'

-- Ejercicio 5 --
-- Enunciado:
-- Escribe una consulta que muestre la información detallada de los tickets comprados por personas cuyo nombre sea Irina --
SELECT *
FROM tickets
WHERE passenger_name ILIKE '%IRINA%'

-- Ejercicio 6 --
-- Enunciado_
-- Escribe una consulta que muestre las ciudades que tienen más de un aeropuerto, indicando cuántos tiene cada una. --
SELECT city ->> 'en' AS ciudad, COUNT(*) AS airports
FROM airports_data
GROUP BY city ->> 'en'
HAVING COUNT(*) > 1

-- Ejercicio 7 --
-- Enunciado:
-- Escribe una consulta que muestre cuántos vuelos hay por cada modelo de avión. --
SELECT a.model ->> 'en' AS model, COUNT(DISTINCT f.flight_id) AS flights_for_model
FROM routes r
JOIN flights f ON r.route_no = f.route_no
JOIN airplanes_data a ON r.airplane_code = a.airplane_code
GROUP BY a.model ->> 'en'

-- Ejercicio 8 --
-- Enunciado:
-- Escribe una consulta que muestre las reservas que incluyen más de un billete (es decir, más de un ticket).--
SELECT book_ref AS num_reserva, COUNT(*) AS num_tickets
FROM tickets
GROUP BY book_ref
HAVING COUNT(*) > 1;

-- Ejercicio 9 --
-- Enunciado:
-- Escribe una consulta que muestre los vuelos cuya salida real se retrasó más de una hora respecto a la salida programada. --
SELECT flight_id, status, scheduled_departure, actual_departure
FROM flights 
WHERE (actual_departure - scheduled_departure) > INTERVAL '1 hour' AND actual_departure IS NOT NULL

-- Ejercicio 10
-- Enunciado:
-- Escribe una consulta que muestre las 10 combinaciones de aeropuerto de origen y destino con mayor número de vuelos, ordenadas de más a menos.
SELECT departure_airport, arrival_airport, COUNT(*) AS origen_destino 
FROM routes
GROUP BY departure_airport, arrival_airport
ORDER BY origen_destino DESC
LIMIT 10

--Ejercicio 11
-- Enunciado:
-- Escribe una consulta que muestre el nombre de los pasajeros que viajaron en un vuelo concreto (elige tú un flight_id cualquiera que exista en la tabla flights).
-- Nº de Vuelo elegido: 938
SELECT s.ticket_no, t.passenger_name
FROM segments s
JOIN tickets t ON s.ticket_no = t.ticket_no
WHERE s.flight_id = '938'

-- Ejercicio 12
-- Enunciado:
-- Escribe una consulta que muestre los aeropuertos desde los que no ha salido ningún vuelo.
SELECT airport_code, airport_name ->> 'en' AS aiport_name
FROM airports_data
WHERE airport_code NOT IN (SELECT DISTINCT departure_airport FROM routes)








