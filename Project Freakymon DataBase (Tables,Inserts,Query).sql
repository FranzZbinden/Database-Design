------------------------------------------------------------------
---   Author     : Franz Zbinden Garcia                          -
---   Num.Est    : 841-22-0855                                   -
---   Curso      : SICI-4030                                     -
---   Sección    : KM1                                           -
------------------------------------------------------------------
SET ECHO ON
------------------------------------------------------------------

SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
---   Aquí se borran las tablas en caso de tener que volver a    -
---  crearlas, esta sub dividido por niveles.                    -
------------------------------------------------------------------

-- Level 3 Tables
------------------------------------------------------------------
DROP TABLE tipo_mon CASCADE CONSTRAINTS;
DROP TABLE tipo_ataque CASCADE CONSTRAINTS;
DROP TABLE pelea CASCADE CONSTRAINTS;
DROP TABLE gym_mon CASCADE CONSTRAINTS;
DROP TABLE agarre CASCADE CONSTRAINTS;
DROP TABLE inventario CASCADE CONSTRAINTS;
DROP TABLE girada CASCADE CONSTRAINTS;
DROP TABLE freakydex CASCADE CONSTRAINTS;
------------------------------------------------------------------
-- Level 2 Tables
DROP TABLE mon CASCADE CONSTRAINTS;
DROP TABLE jugador CASCADE CONSTRAINTS;
DROP TABLE ataque CASCADE CONSTRAINTS;
------------------------------------------------------------------
-- Level 1 Tables
DROP TABLE cuenta CASCADE CONSTRAINTS;
DROP TABLE item CASCADE CONSTRAINTS;
DROP TABLE gym CASCADE CONSTRAINTS;
DROP TABLE tipo CASCADE CONSTRAINTS;
DROP TABLE parada CASCADE CONSTRAINTS;
------------------------------------------------------------------

SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-1 nivel-1                             -
------------------------------------------------------------------
CREATE TABLE cuenta (
    telefono_pk                     VARCHAR2(12)NOT NULL,
    nombre                          VARCHAR2(25)NOT NULL,
    contrasena                      VARCHAR2(30)NOT NULL,
    fecha_u_creacion                TIMESTAMP(9) NOT NULL,
    fecha_acceso                    TIMESTAMP(9) NOT NULL,
    intentos_fallidos               VARCHAR2(2) NOT NULL, 
    fecha_expiracion                TIMESTAMP(9) NOT NULL,
	CONSTRAINT cuenta_telefono_pk   PRIMARY KEY (telefono_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-2 nivel-1                             -
------------------------------------------------------------------
CREATE TABLE item (
    id_pk                        VARCHAR2(7)NOT NULL,
    nombre                       VARCHAR2(25)NOT NULL,
    descripcion                  VARCHAR2(50)NOT NULL,
	CONSTRAINT item_id_pk        PRIMARY KEY (id_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-3 nivel-1                             -
------------------------------------------------------------------
CREATE TABLE gym (
    id_pk                        VARCHAR2(7)NOT NULL,
    nombre                       VARCHAR2(25)NOT NULL,
    descripcion                  VARCHAR2(50)NOT NULL,
    latitud                      VARCHAR2(50)NOT NULL,
    longitud                     VARCHAR2(50)NOT NULL,
	CONSTRAINT gym_id_pk         PRIMARY KEY (id_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-4 nivel-1                             -
------------------------------------------------------------------
CREATE TABLE parada (
    id_pk                         VARCHAR2(7)NOT NULL,
    nombre                        VARCHAR2(25)NOT NULL,
    descripcion                   VARCHAR2(50)NOT NULL,
    latitud                       VARCHAR2(50)NOT NULL,
    longitud                      VARCHAR2(50)NOT NULL,
    comentario                    VARCHAR2(50)NOT NULL,
    CONSTRAINT parada_id_pk       PRIMARY KEY (id_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-5 nivel-1                             -
------------------------------------------------------------------
CREATE TABLE tipo (
	numero_pk					  VARCHAR2(7)NOT NULL,
    nombre                        VARCHAR2(25)NOT NULL,
    descripcion                   VARCHAR2(50)NOT NULL,
    CONSTRAINT tipo_numero_pk       PRIMARY KEY (numero_pk));
-- ---------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-6 nivel-1                             -
------------------------------------------------------------------
CREATE TABLE ataque (
    id_pk                         VARCHAR2(7)NOT NULL,
    numero_tipo_fk                VARCHAR2(7)NOT NULL,
    nombre                        VARCHAR2(25)NOT NULL,
    descripcion                   VARCHAR2(70),
	CONSTRAINT ataque_id_pk       PRIMARY KEY (id_pk),
    FOREIGN KEY (numero_tipo_fk)  REFERENCES tipo(numero_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-7 nivel-2                             -
------------------------------------------------------------------
CREATE TABLE jugador (
    celular_cuenta_pk_fk          VARCHAR2(12)NOT NULL,
    fecha_nacimiento_pk           DATE NOT NULL,
    nombre                        VARCHAR2(25)NOT NULL,
    apellido                      VARCHAR2(25)NOT NULL,
	apellido_materno              VARCHAR2(25),
	linea_1                       VARCHAR2(100)NOT NULL,
	linea_2                       VARCHAR2(100)NOT NULL,
	ciudad                        VARCHAR2(25)NOT NULL,
	estado                        VARCHAR2(25)NOT NULL,
    zipcode                       VARCHAR2(6)NOT NULL,
    color                         VARCHAR2(20)NOT NULL,
	comentario                    VARCHAR2(100)NOT NULL,
    FOREIGN KEY (celular_cuenta_pk_fk) REFERENCES cuenta(telefono_pk),
	CONSTRAINT jugador_celu_fecha PRIMARY KEY (celular_cuenta_pk_fk, fecha_nacimiento_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-8 nivel-2                             -
------------------------------------------------------------------
CREATE TABLE inventario (
    cel_cuent_pk_fk1             VARCHAR2(12)NOT NULL,
    id_item_pk_fk2               VARCHAR2(7)NOT NULL,
    cantidad                     VARCHAR2(12)NOT NULL,
    FOREIGN KEY (id_item_pk_fk2) REFERENCES item(id_pk),
	FOREIGN KEY (cel_cuent_pk_fk1)  REFERENCES cuenta(telefono_pk),
    CONSTRAINT inve_cuen_item_pk  PRIMARY KEY (id_item_pk_fk2, cel_cuent_pk_fk1));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-9 nivel-2                             -
------------------------------------------------------------------
CREATE TABLE freakydex (
    id_pk                        VARCHAR2(7) NOT NULL,
    cel_cuenta_juego_fk1         VARCHAR2(12) NOT NULL,
    fecha_naci_juego_fk2         DATE NOT NULL,
    nombre                       VARCHAR2(25),
    evolucion                    VARCHAR2(25) NOT NULL,
    dulces_acumu                 VARCHAR2(5) NOT NULL,
    dulces_xl_acumul             VARCHAR2(5) NOT NULL,
    CONSTRAINT freakydex_id_pk   PRIMARY KEY (id_pk),
    FOREIGN KEY (cel_cuenta_juego_fk1, fecha_naci_juego_fk2) 
        REFERENCES jugador(celular_cuenta_pk_fk, fecha_nacimiento_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
-------------------------------------------------------------------
--    Creacion tabla TABLA-10 nivel-2                             -
-------------------------------------------------------------------
CREATE TABLE mon (
    id_pk                         VARCHAR2(7)NOT NULL,
    id_dex_fk                     VARCHAR2(50)NOT NULL,
	genero                        VARCHAR2(2)NOT NULL,
	hp                            VARCHAR2(7)NOT NULL,
    barrio                        VARCHAR2(50)NOT NULL,
	ciudad                        VARCHAR2(50)NOT NULL,
    estado                        VARCHAR2(50)NOT NULL,
    zipcode                       VARCHAR2(50)NOT NULL,
	fecha_captura                 TIMESTAMP(9) NOT NULL,
	comentario                    VARCHAR2(100),
	cp                            VARCHAR2(10)NOT NULL,
    cantidad_victoria             VARCHAR2(10)NOT NULL,
	estrella                      VARCHAR2(3)NOT NULL,
	peso                          VARCHAR2(10)NOT NULL,
	estatura                      VARCHAR2(6)NOT NULL,
	CONSTRAINT mon_id_pk          PRIMARY KEY (id_pk),
    FOREIGN KEY (id_dex_fk)       REFERENCES freakydex(id_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-11 nivel-3                            -
------------------------------------------------------------------
CREATE TABLE agarre (
    fecha_pk                              TIMESTAMP(9) NOT NULL,
    cel_cuenta_jugador_pk_fk1             VARCHAR2(12)NOT NULL,
    fecha_nacim_juga_pk_fk2               DATE NOT NULL,
    id_mon_pk_fk3                         VARCHAR2(7)NOT NULL,                        
    CONSTRAINT agarre_fech_cuen_naci_mon_pk PRIMARY KEY (fecha_pk, cel_cuenta_jugador_pk_fk1, fecha_nacim_juga_pk_fk2,id_mon_pk_fk3),
    FOREIGN KEY (cel_cuenta_jugador_pk_fk1, fecha_nacim_juga_pk_fk2) REFERENCES jugador(celular_cuenta_pk_fk, fecha_nacimiento_pk),
    FOREIGN KEY (id_mon_pk_fk3)           REFERENCES mon(id_pk));
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Creacion tabla TABLA-12 nivel-3                            -
------------------------------------------------------------------
CREATE TABLE girada (
    id_pk                                  VARCHAR2(7)NOT NULL,
    celu_cuenta_jugada_pk_fk1              VARCHAR2(12)NOT NULL,
    fecha_naci_juga_pk_fk2                 DATE NOT NULL,
    id_item_pk_fk3                         VARCHAR2(7)NOT NULL,
    id_gym_fk4                             VARCHAR2(7),
    id_parada_fk5                          VARCHAR2(7),
    fecha_h_m                              TIMESTAMP(9) NOT NULL,
    cantidad                               VARCHAR2(7)NOT NULL,
    CONSTRAINT girada_celu_fecha_item_pk    PRIMARY KEY (id_pk, celu_cuenta_jugada_pk_fk1, fecha_naci_juga_pk_fk2, id_item_pk_fk3),
	FOREIGN KEY (celu_cuenta_jugada_pk_fk1, fecha_naci_juga_pk_fk2)  REFERENCES jugador(celular_cuenta_pk_fk, fecha_nacimiento_pk),
    FOREIGN KEY (id_item_pk_fk3)            REFERENCES item(id_pk),
    FOREIGN KEY (id_gym_fk4)                REFERENCES gym(id_pk),
    FOREIGN KEY (id_parada_fk5)             REFERENCES parada(id_pk));
------------------------------------------------------------------

SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla tabla-13    nivel-3                         -
-- ----------------------------------------------------------------
CREATE TABLE tipo_mon (
    id_fmon_pk_fk1                          VARCHAR2(7),
    num_tipo_pk_fk2                         VARCHAR2(7),
    CONSTRAINT tipo_mon_fmon_tipo_pk        PRIMARY KEY (id_fmon_pk_fk1, num_tipo_pk_fk2),
    FOREIGN KEY (id_fmon_pk_fk1)            REFERENCES mon(id_pk),
    FOREIGN KEY (num_tipo_pk_fk2)           REFERENCES tipo(numero_pk));
------------------------------------------------------------------

SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla tabla-14  nivel-3                           -
-- ----------------------------------------------------------------
CREATE TABLE tipo_ataque (
    id_tipo_pk_fk                           VARCHAR2(7),
	id_ataque_pk_fk2                        VARCHAR2(7),
    CONSTRAINT tipo_ataque_pk               PRIMARY KEY (id_ataque_pk_fk2, id_tipo_pk_fk),
    FOREIGN KEY (id_ataque_pk_fk2)           REFERENCES ataque(id_pk),
    FOREIGN KEY (id_tipo_pk_fk)             REFERENCES tipo(numero_pk));
-- ----------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla tabla-15  nivel-3                           -
-- ----------------------------------------------------------------
CREATE TABLE pelea (
    id_gym_pk_fk1                           VARCHAR2(7),
    id_mon_pk_fk2                           VARCHAR2(7),
    fecha_h_m_pk3                           TIMESTAMP(9) NOT NULL,
	CONSTRAINT pelea_gym_mon_fecha_pk       PRIMARY KEY (id_mon_pk_fk2, id_gym_pk_fk1, fecha_h_m_pk3),
    FOREIGN KEY (id_mon_pk_fk2) REFERENCES mon(id_pk),
    FOREIGN KEY (id_gym_pk_fk1) REFERENCES gym(id_pk));
-- ----------------------------------------------------------------



SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla tabla-16  nivel-3                           -
-- ----------------------------------------------------------------
CREATE TABLE gym_mon (
    id_gym_pk_fk1                           VARCHAR2(7),
    id_mon_pk_fk2                           VARCHAR2(7) NOT NULL,
    fecha_h_captura_pk3                     TIMESTAMP(9) NOT NULL,
	fecha_h_darrota_pk4                     TIMESTAMP(9) NOT NULL,
	CONSTRAINT gym_mon_fecha_pk       PRIMARY KEY (id_mon_pk_fk2, id_gym_pk_fk1, fecha_h_captura_pk3, fecha_h_darrota_pk4),
    FOREIGN KEY (id_mon_pk_fk2) REFERENCES mon(id_pk),
    FOREIGN KEY (id_gym_pk_fk1) REFERENCES gym(id_pk));
-- ----------------------------------------------------------------

COMMIT;



SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Insertar datos tabla: cuenta-1                              -
-- ----------------------------------------------------------------
INSERT INTO cuenta VALUES ('1234567890', 'Juan Perez', 'Password123!', TIMESTAMP '2024-01-01 10:00:00', TIMESTAMP '2024-01-02 11:00:00', '0', TIMESTAMP '2024-12-31 23:59:59');
INSERT INTO cuenta VALUES ('2345678901', 'Maria Gomez', 'SecurePass456$', TIMESTAMP '2024-02-15 08:30:00', TIMESTAMP '2024-02-16 09:15:00', '1', TIMESTAMP '2025-01-15 23:59:59');
INSERT INTO cuenta VALUES ('3456789012', 'Carlos Lopez', 'Qwerty789&', TIMESTAMP '2024-03-20 15:45:00', TIMESTAMP '2024-03-21 16:00:00', '0', TIMESTAMP '2024-09-20 23:59:59');
INSERT INTO cuenta VALUES ('4567890123', 'Ana Martinez', 'Admin1234%', TIMESTAMP '2024-04-10 12:20:00', TIMESTAMP '2024-04-11 13:25:00', '2', TIMESTAMP '2025-04-10 23:59:59');
INSERT INTO cuenta VALUES ('5678901234', 'Luis Rivera', 'Zxcvbn654!', TIMESTAMP '2024-05-05 14:10:00', TIMESTAMP '2024-05-06 15:35:00', '0', TIMESTAMP '2025-05-05 23:59:59');
INSERT INTO cuenta VALUES ('6789012345', 'Laura Torres', 'Passw0rd!', TIMESTAMP '2024-06-25 09:05:00', TIMESTAMP '2024-06-26 10:10:00', '3', TIMESTAMP '2024-12-25 23:59:59');
INSERT INTO cuenta VALUES ('7890123456', 'Pedro Sanchez', 'AbcDef123$', TIMESTAMP '2024-07-15 11:50:00', TIMESTAMP '2024-07-16 12:45:00', '1', TIMESTAMP '2024-11-15 23:59:59');
INSERT INTO cuenta VALUES ('8901234567', 'Sofia Ramirez', 'MyPass987&', TIMESTAMP '2024-08-30 17:40:00', TIMESTAMP '2024-08-31 18:15:00', '0', TIMESTAMP '2025-08-30 23:59:59');
INSERT INTO cuenta VALUES ('9012345678', 'Diego Chavez', 'Pass!word99', TIMESTAMP '2024-09-10 13:25:00', TIMESTAMP '2024-09-11 14:35:00', '2', TIMESTAMP '2024-09-10 23:59:59');
INSERT INTO cuenta VALUES ('0123456789', 'Elena Moreno', 'SecretKey123!', TIMESTAMP '2024-10-22 16:10:00', TIMESTAMP '2024-10-23 17:20:00', '0', TIMESTAMP '2025-10-22 23:59:59');
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Insertar datos tabla: item-2                               -
------------------------------------------------------------------
INSERT INTO item VALUES ('I001', 'Pokéball', 'Used to catch mons');
INSERT INTO item VALUES ('I002', 'Superpoción', 'Heals 50 HP');
INSERT INTO item VALUES ('I003', 'Revivir', 'Revives a fainted monster');
INSERT INTO item VALUES ('I004', 'Bayas', 'Various berry types');
INSERT INTO item VALUES ('I005', 'Incubadora', 'Incubates monster eggs');
INSERT INTO item VALUES ('I006', 'Huevo Suerte', 'Doubles experience points');
INSERT INTO item VALUES ('I007', 'Caramelos', 'Enhances monster stats');
INSERT INTO item VALUES ('I008', 'Radar', 'Locates rare monsters');
INSERT INTO item VALUES ('I009', 'Pocion Max', 'Fully restores HP');
INSERT INTO item VALUES ('I010', 'Módulo Cebo', 'Attracts monsters to stops');
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Insertar datos tabla: gym-1                                -
------------------------------------------------------------------
INSERT INTO gym VALUES ('00001', 'Gym Pokémon', 'The ultimate training gym', '18.4655', '66.1057');
INSERT INTO gym VALUES ('00002', 'Gym Arena', 'A competitive battle arena', '18.4700', '66.1100');
INSERT INTO gym VALUES ('00003', 'Battle Hub', 'Gym known for fierce battles', '18.4500', '66.1150');
INSERT INTO gym VALUES ('00004', 'Elite Gym', 'Exclusive gym for top trainers', '18.4600', '66.1200');
INSERT INTO gym VALUES ('00005', 'Water Gym', 'Gym with water-based challenges', '18.4800', '66.1300');
INSERT INTO gym VALUES ('00006', 'Fire Gym', 'Gym specializing in fire-type', '18.4400', '66.1400');
INSERT INTO gym VALUES ('00007', 'Electric Gym', 'Gym for electric-type trainers', '18.4705', '66.1500');
INSERT INTO gym VALUES ('00008', 'Psychic Gym', 'Gym for psychic-type Pokémon', '18.4505', '66.1550');
INSERT INTO gym VALUES ('00009', 'Grass Gym', 'Gym for nature-loving trainers', '18.4605', '66.1450');
INSERT INTO gym VALUES ('00010', 'Rock Gym', 'Gym focused on rock-type battles', '18.4650', '66.1250');
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Insertar datos tabla: parada-1                             -
------------------------------------------------------------------
INSERT INTO parada VALUES ('00001', 'El Refugio Verde', 'A hidden gem in the forest', '18.4655', '66.1057', 'Ideal for hikers and nature lovers.');
INSERT INTO parada VALUES ('00002', 'La Plaza Dorada', 'Bustling stop near the city center', '18.4700', '66.1100', 'Surrounded by cafes and shops.');
INSERT INTO parada VALUES ('00003', 'El Lago Sereno', 'Quiet spot by the shimmering lake', '18.4500', '66.1150', 'Perfect for a relaxing pause.');
INSERT INTO parada VALUES ('00004', 'La Cima Secreta', 'High up near the mountain trail', '18.4600', '66.1200', 'Great for nature walks and adventurers.');
INSERT INTO parada VALUES ('00005', 'El Mercado Vivo', 'A lively stop near the local market', '18.4800', '66.1300', 'A popular place for locals to meet.');
INSERT INTO parada VALUES ('00006', 'El Descanso Solitario', 'A peaceful stop on the highway', '18.4400', '66.1400', 'Ideal for travelers seeking solitude.');
INSERT INTO parada VALUES ('00007', 'La Brisa Marina', 'A stop by the coastal breeze', '18.4705', '66.1500', 'Perfect for a scenic break by the sea.');
INSERT INTO parada VALUES ('00008', 'El Portal Silencioso', 'Rest stop by the park entrance', '18.4505', '66.1550', 'Quiet and peaceful, perfect for a moment of calm.');
INSERT INTO parada VALUES ('00009', 'La Costa Dorada', 'Rest stop with a golden beach view', '18.4605', '66.1450', 'A favorite among beachgoers.');
INSERT INTO parada VALUES ('00010', 'El Tren Estelar', 'Convenient stop next to the train station', '18.4650', '66.1250', 'Busy and ideal for commuters.');
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Insertar datos tabla: tipo-1                               -
------------------------------------------------------------------
INSERT INTO tipo VALUES ('00001', 'Rock', 'A type associated with the strength of');
INSERT INTO tipo VALUES ('00002', 'Dark', 'A mysterious type, related to darkness.');
INSERT INTO tipo VALUES ('00003', 'Dragon', 'A majestic and powerful type.');
INSERT INTO tipo VALUES ('00004', 'Flying', 'An agile type, capable of .');
INSERT INTO tipo VALUES ('00005', 'Water', 'A fluid type, representing ');
INSERT INTO tipo VALUES ('00006', 'Ground', 'A type related to soil and stability.');
INSERT INTO tipo VALUES ('00007', 'Steel', 'A resilient type, as strong.');
INSERT INTO tipo VALUES ('00008', 'Fighting', 'A type related to physical .');
INSERT INTO tipo VALUES ('00009', 'Fire', 'A destructive type, associated');
INSERT INTO tipo VALUES ('00010', 'Bug', 'A type related to insects and.');
-------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
---   Insertar datos tabla: ataque-1                             -
------------------------------------------------------------------
INSERT INTO ataque VALUES ('00001', '00001', 'Counter', 'A counterattack that strikes back when the opponent hits.');
INSERT INTO ataque VALUES ('00002', '00002', 'Close Combat', 'A fighting move that delivers a strong close-range punch.');
INSERT INTO ataque VALUES ('00003', '00003', 'Bullet Seed', 'A rapid-fire grass-type attack that shoots seeds at the opponent.');
INSERT INTO ataque VALUES ('00004', '00004', 'Dragon Pulse', 'A dragon-type move that launches a pulse of dragon energy.');
INSERT INTO ataque VALUES ('00005', '00005', 'Thunder', 'A powerful electric attack that strikes with lightning.');
INSERT INTO ataque VALUES ('00006', '00006', 'Dragon Tail', 'A dragon-type attack using the users tail to strike the opponent.');
INSERT INTO ataque VALUES ('00007', '00007', 'Megahorn', 'A strong bug-type move that strikes with a horn-like attack.');
INSERT INTO ataque VALUES ('00008', '00008', 'Iron Tail', 'A steel-based attack where the user strikes with a metal tail.');
INSERT INTO ataque VALUES ('00009', '00009', 'Stone Edge', 'A rock-type move that launches sharp stones toward the opponent.');
INSERT INTO ataque VALUES ('00010', '00010', 'Bullet Punch', 'A quick and strong punch, often used in close combat.');
-------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Insertar datos tabla: jugador-1                            -
------------------------------------------------------------------
INSERT INTO jugador VALUES ('1234567890', TO_DATE('01-JAN-1990', 'DD-MON-YYYY'), 'John', 'Doe', 'Smith', '123 Elm Street', 'Apt 4B', 'Los Angeles', 'California', '90001', 'Red', 'Enjoys hiking and fishing.');
INSERT INTO jugador VALUES ('2345678901', TO_DATE('15-MAR-1985', 'DD-MON-YYYY'), 'Emily', 'White', 'Johnson', '456 Maple Avenue', 'Suite 300', 'Miami', 'Florida', '33101', 'Blue', 'Avid traveler and foodie.');
INSERT INTO jugador VALUES ('3456789012', TO_DATE('22-SEP-1992', 'DD-MON-YYYY'), 'Robert', 'Green', 'Taylor', '789 Pine Road', 'Unit 2', 'New York', 'New York', '10001', 'Yellow', 'Passionate about music.');
INSERT INTO jugador VALUES ('4567890123', TO_DATE('03-JUL-1988', 'DD-MON-YYYY'), 'Sarah', 'Black', 'Davis', '321 Oak Lane', 'Box 123', 'Chicago', 'Illinois', '60601', 'Blue', 'Loves painting and reading.');
INSERT INTO jugador VALUES ('5678901234', TO_DATE('17-AUG-1995', 'DD-MON-YYYY'), 'Michael', 'Brown', 'Lee', '654 Birch Street', 'Apt 9', 'San Francisco', 'California', '94101', 'Red', 'Enjoys coding and gaming.');
INSERT INTO jugador VALUES ('6789012345', TO_DATE('05-MAY-2000', 'DD-MON-YYYY'), 'Olivia', 'Harris', 'Moore', '987 Cedar Drive', 'Floor 1', 'Seattle', 'Washington', '98101', 'Yellow', 'Enthusiastic about sports.');
INSERT INTO jugador VALUES ('7890123456', TO_DATE('11-NOV-1993', 'DD-MON-YYYY'), 'William', 'Clark', 'Walker', '234 Elm Avenue', 'Apt 303', 'Dallas', 'Texas', '75201', 'Red', 'Interested in technology.');
INSERT INTO jugador VALUES ('8901234567', TO_DATE('23-FEB-1997', 'DD-MON-YYYY'), 'Ava', 'Lewis', 'King', '567 Maple Road', 'House 45', 'Boston', 'Massachusetts', '02101', 'Blue', 'Likes photography and movies.');
INSERT INTO jugador VALUES ('9012345678', TO_DATE('30-JUL-1986', 'DD-MON-YYYY'), 'James', 'Turner', 'Scott', '345 Cedar Street', 'Box 22', 'Austin', 'Texas', '73301', 'Yellow', 'Enjoys reading and fitness.');
INSERT INTO jugador VALUES ('0123456789', TO_DATE('21-DEC-1999', 'DD-MON-YYYY'), 'Isabella', 'Martinez', 'Garcia', '876 Birch Street', 'Apt 56', 'Denver', 'Colorado', '80201', 'Red', 'Loves traveling and music.');
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Datos de la tabla inventario-2                             -
------------------------------------------------------------------
INSERT INTO inventario VALUES ('1234567890', 'I001', '50');
INSERT INTO inventario VALUES ('2345678901', 'I002', '30');
INSERT INTO inventario VALUES ('3456789012', 'I003', '100');
INSERT INTO inventario VALUES ('4567890123', 'I004', '200');
INSERT INTO inventario VALUES ('5678901234', 'I005', '60');
INSERT INTO inventario VALUES ('6789012345', 'I006', '120');
INSERT INTO inventario VALUES ('7890123456', 'I007', '75');
INSERT INTO inventario VALUES ('8901234567', 'I008', '40');
INSERT INTO inventario VALUES ('9012345678', 'I009', '90');
INSERT INTO inventario VALUES ('0123456789', 'I010', '150');
-- -------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
-------------------------------------------------------------------
--    Datos de la tabla freakydex-3                               -
-------------------------------------------------------------------
INSERT INTO freakydex VALUES ('10001', '1234567890', TO_DATE('01-JAN-1990', 'DD-MON-YYYY'), 'Thunderclaw', '3', '150', '10');
INSERT INTO freakydex VALUES ('10002', '2345678901', TO_DATE('15-MAR-1985', 'DD-MON-YYYY'), 'Fluffstorm', '1', '200', '15');
INSERT INTO freakydex VALUES ('10003', '3456789012', TO_DATE('22-SEP-1992', 'DD-MON-YYYY'), 'Rockbreaker', '2', '120', '12');
INSERT INTO freakydex VALUES ('10004', '4567890123', TO_DATE('03-JUL-1988', 'DD-MON-YYYY'), 'Aquafury', '1', '170', '18');
INSERT INTO freakydex VALUES ('10005', '5678901234', TO_DATE('17-AUG-1995', 'DD-MON-YYYY'), 'Ironclad', '3', '180', '20');
INSERT INTO freakydex VALUES ('10006', '6789012345', TO_DATE('05-MAY-2000', 'DD-MON-YYYY'), 'Psychovore', '2', '130', '14');
INSERT INTO freakydex VALUES ('10007', '7890123456', TO_DATE('11-NOV-1993', 'DD-MON-YYYY'), 'Pyroblade', '3', '160', '16');
INSERT INTO freakydex VALUES ('10008', '8901234567', TO_DATE('23-FEB-1997', 'DD-MON-YYYY'), 'Windrider', '1', '140', '13');
INSERT INTO freakydex VALUES ('10009', '9012345678', TO_DATE('30-JUL-1986', 'DD-MON-YYYY'), 'Beastflame', '2', '150', '15');
INSERT INTO freakydex VALUES ('10010', '0123456789', TO_DATE('21-DEC-1999', 'DD-MON-YYYY'), 'Venomdrake', '3', '190', '19');
-- -------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Datos de la tabla mon-4                                    -
------------------------------------------------------------------
INSERT INTO mon VALUES ('10001', '10001', 'M', '120', 'Downtown', 'San Juan', 'Puerto Rico', '00901', TO_TIMESTAMP('2024-04-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'First catch!', '3500', '12', '3', '150', '2.1');
INSERT INTO mon VALUES ('10002', '10002', 'F', '95', 'Hato Rey', 'San Juan', 'Puerto Rico', '00918', TO_TIMESTAMP('2024-04-02 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Strong defense', '2800', '9', '2', '80', '1.8');
INSERT INTO mon VALUES ('10003', '10003', 'M', '135', 'Isla Verde', 'Carolina', 'Puerto Rico', '00979', TO_TIMESTAMP('2024-04-03 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'Quick capture', '4000', '15', '3', '200', '2.5');
INSERT INTO mon VALUES ('10004', '10004', 'F', '110', 'Condado', 'San Juan', 'Puerto Rico', '00907', TO_TIMESTAMP('2024-04-05 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Rare find!', '3200', '10', '3', '90', '1.6');
INSERT INTO mon VALUES ('10005', '10005', 'M', '140', 'Bayamón', 'Bayamón', 'Puerto Rico', '00961', TO_TIMESTAMP('2024-04-06 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tough battle', '4500', '18', '3', '220', '2.8');
INSERT INTO mon VALUES ('10006', '10006', 'F', '80', 'Santurce', 'San Juan', 'Puerto Rico', '00911', TO_TIMESTAMP('2024-04-07 16:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'Very agile', '2100', '6', '2', '75', '1.5');
INSERT INTO mon VALUES ('10007', '10007', 'M', '125', 'Caguas', 'Caguas', 'Puerto Rico', '00725', TO_TIMESTAMP('2024-04-08 12:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'High CP potential', '3600', '14', '3', '160', '2.3');
INSERT INTO mon VALUES ('10008', '10008', 'F', '100', 'Ponce', 'Ponce', 'Puerto Rico', '00730', TO_TIMESTAMP('2024-04-09 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Surprising stats', '3000', '11', '2', '130', '1.9');
INSERT INTO mon VALUES ('10009', '10009', 'M', '90', 'Mayagüez', 'Mayagüez', 'Puerto Rico', '00680', TO_TIMESTAMP('2024-04-10 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Needs improvement', '2500', '7', '2', '95', '1.7');
INSERT INTO mon VALUES ('10010', '10010', 'F', '115', 'Guaynabo', 'Guaynabo', 'Puerto Rico', '00969', TO_TIMESTAMP('2024-04-11 10:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'Favorite catch', '3400', '13', '3', '145', '2.0');
-------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
-------------------------------------------------------------------
--    Datos de la tabla agarre-4                                  -
-------------------------------------------------------------------
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), '1234567890', TO_DATE('01-JAN-1990', 'DD-MON-YYYY'), '10001');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2345678901', TO_DATE('15-MAR-1985', 'DD-MON-YYYY'), '10002');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-03 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), '3456789012', TO_DATE('22-SEP-1992', 'DD-MON-YYYY'), '10003');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), '4567890123', TO_DATE('03-JUL-1988', 'DD-MON-YYYY'), '10004');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-06 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), '5678901234', TO_DATE('17-AUG-1995', 'DD-MON-YYYY'), '10005');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-07 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), '6789012345', TO_DATE('05-MAY-2000', 'DD-MON-YYYY'), '10006');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-08 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), '7890123456', TO_DATE('11-NOV-1993', 'DD-MON-YYYY'), '10007');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-09 12:10:00', 'YYYY-MM-DD HH24:MI:SS'), '8901234567', TO_DATE('23-FEB-1997', 'DD-MON-YYYY'), '10008');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-10 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), '9012345678', TO_DATE('30-JUL-1986', 'DD-MON-YYYY'), '10009');
INSERT INTO agarre VALUES (TO_TIMESTAMP('2024-04-11 11:55:00', 'YYYY-MM-DD HH24:MI:SS'), '0123456789', TO_DATE('21-DEC-1999', 'DD-MON-YYYY'), '10010');
-------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
-------------------------------------------------------------------
--    Datos de la tabla girada-4                                  -
-------------------------------------------------------------------
INSERT INTO girada VALUES ('1', '1234567890', TO_DATE('01-JAN-1990', 'DD-MON-YYYY'), 'I001', '00001', '00001', TO_TIMESTAMP('2024-01-10 09:25:00', 'YYYY-MM-DD HH24:MI:SS'), '2');
INSERT INTO girada VALUES ('2', '2345678901', TO_DATE('15-MAR-1985', 'DD-MON-YYYY'), 'I002', '00002', '00002', TO_TIMESTAMP('2024-01-11 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), '5');
INSERT INTO girada VALUES ('3', '3456789012', TO_DATE('22-SEP-1992', 'DD-MON-YYYY'), 'I003', '00003', '00003', TO_TIMESTAMP('2024-01-12 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), '3');
INSERT INTO girada VALUES ('4', '4567890123', TO_DATE('03-JUL-1988', 'DD-MON-YYYY'), 'I004', '00004', '00004', TO_TIMESTAMP('2024-01-13 16:05:00', 'YYYY-MM-DD HH24:MI:SS'), '1');
INSERT INTO girada VALUES ('5', '5678901234', TO_DATE('17-AUG-1995', 'DD-MON-YYYY'), 'I005', '00005', '00005', TO_TIMESTAMP('2024-01-14 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), '4');
INSERT INTO girada VALUES ('6', '6789012345', TO_DATE('05-MAY-2000', 'DD-MON-YYYY'), 'I006', '00006', '00006', TO_TIMESTAMP('2024-01-15 10:50:00', 'YYYY-MM-DD HH24:MI:SS'), '2');
INSERT INTO girada VALUES ('7', '7890123456', TO_DATE('11-NOV-1993', 'DD-MON-YYYY'), 'I007', '00007', '00007', TO_TIMESTAMP('2024-01-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), '6');
INSERT INTO girada VALUES ('8', '8901234567', TO_DATE('23-FEB-1997', 'DD-MON-YYYY'), 'I008', '00008', '00008', TO_TIMESTAMP('2024-01-17 12:25:00', 'YYYY-MM-DD HH24:MI:SS'), '7');
INSERT INTO girada VALUES ('9', '9012345678', TO_DATE('30-JUL-1986', 'DD-MON-YYYY'), 'I009', '00009', '00009', TO_TIMESTAMP('2024-01-18 18:15:00', 'YYYY-MM-DD HH24:MI:SS'), '8');
INSERT INTO girada VALUES ('10', '0123456789', TO_DATE('21-DEC-1999', 'DD-MON-YYYY'), 'I010', '00010', '00010', TO_TIMESTAMP('2024-01-19 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), '3');
-- ----------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
-------------------------------------------------------------------
--    Datos de la tabla tipo_mon-4                                -
-------------------------------------------------------------------

INSERT INTO tipo_mon VALUES ('10001', '00001');
INSERT INTO tipo_mon VALUES ('10002', '00002');
INSERT INTO tipo_mon VALUES ('10003', '00003');
INSERT INTO tipo_mon VALUES ('10004', '00004');
INSERT INTO tipo_mon VALUES ('10005', '00005');
INSERT INTO tipo_mon VALUES ('10006', '00006');
INSERT INTO tipo_mon VALUES ('10007', '00007');
INSERT INTO tipo_mon VALUES ('10008', '00008');
INSERT INTO tipo_mon VALUES ('10009', '00009');
INSERT INTO tipo_mon VALUES ('10010', '00010');
------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Datos de la tabla tipo_ataque-4                            -
------------------------------------------------------------------
INSERT INTO tipo_ataque VALUES ('00001', '00001');
INSERT INTO tipo_ataque VALUES ('00002', '00002');
INSERT INTO tipo_ataque VALUES ('00003', '00003');
INSERT INTO tipo_ataque VALUES ('00004', '00004');
INSERT INTO tipo_ataque VALUES ('00005', '00005');
INSERT INTO tipo_ataque VALUES ('00006', '00006');
INSERT INTO tipo_ataque VALUES ('00007', '00007');
INSERT INTO tipo_ataque VALUES ('00008', '00008');
INSERT INTO tipo_ataque VALUES ('00009', '00009');
INSERT INTO tipo_ataque VALUES ('00010', '00010');
-------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Datos de la tabla pelea-4                                  -
------------------------------------------------------------------

INSERT INTO pelea VALUES ('00001', '10001', TO_TIMESTAMP('2024-01-12 14:23:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00002', '10002', TO_TIMESTAMP('2024-01-15 09:45:30', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00003', '10003', TO_TIMESTAMP('2024-02-01 11:12:20', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00004', '10004', TO_TIMESTAMP('2024-02-10 16:30:50', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00005', '10005', TO_TIMESTAMP('2024-03-03 10:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00006', '10006', TO_TIMESTAMP('2024-03-07 18:50:25', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00007', '10007', TO_TIMESTAMP('2024-03-18 14:05:15', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00008', '10008', TO_TIMESTAMP('2024-04-01 20:23:35', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00009', '10009', TO_TIMESTAMP('2024-04-11 08:12:45', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO pelea VALUES ('00010', '10010', TO_TIMESTAMP('2024-04-20 22:30:55', 'YYYY-MM-DD HH24:MI:SS'));
-------------------------------------------------------------------


SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------
--    Datos de la tabla gym_mon-4                                -
------------------------------------------------------------------
INSERT INTO gym_mon VALUES ('00001', '10001', TO_TIMESTAMP('12-JAN-2024 14:23:10', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('05-MAY-2024 13:45:25', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00002', '10002', TO_TIMESTAMP('15-JAN-2024 09:45:30', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('15-MAY-2024 17:30:10', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00003', '10003', TO_TIMESTAMP('01-FEB-2024 11:12:20', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('25-MAY-2024 09:20:40', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00004', '10004', TO_TIMESTAMP('10-FEB-2024 16:30:50', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('02-JUN-2024 14:50:55', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00005', '10005', TO_TIMESTAMP('03-MAR-2024 10:15:00', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('10-JUN-2024 19:15:30', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00006', '10006', TO_TIMESTAMP('07-MAR-2024 18:50:25', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('25-JUN-2024 08:05:45', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00007', '10007', TO_TIMESTAMP('18-MAR-2024 14:05:15', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('01-JUL-2024 11:35:20', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00008', '10008', TO_TIMESTAMP('01-APR-2024 20:23:35', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('15-JUL-2024 15:40:50', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00009', '10009', TO_TIMESTAMP('11-APR-2024 08:12:45', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('28-JUL-2024 20:25:35', 'DD-MON-YYYY HH24:MI:SS'));
INSERT INTO gym_mon VALUES ('00010', '10010', TO_TIMESTAMP('20-APR-2024 22:30:55', 'DD-MON-YYYY HH24:MI:SS'), TO_TIMESTAMP('05-AUG-2024 10:10:00', 'DD-MON-YYYY HH24:MI:SS'));
------------------------------------------------------------------
-- Example Queries:                                              -
------------------------------------------------------------------

SHOW USER
SELECT systimestamp FROM dual;
------------------------------------------------------------------


SET LINESIZE 80
-- 1.	Mostrar los atributos de la tabla FREAKYMON
SHOW USER
SELECT systimestamp FROM dual;
DESCRIBE mon;


SET LINESIZE 200
--2.	Mostrar todos los datos de la tabla FREAKYDEX
SHOW USER
SELECT systimestamp FROM dual;
SELECT * FROM freakydex;


SET LINESIZE 200
-- 3.	Mostrar el nombre del jugador con los nombres de los pokemones que ha capturado (freakydex)
SHOW USER
SELECT systimestamp FROM dual;
SELECT j.nombre AS nombre_jugador, f.nombre AS nombre_freakymon
FROM jugador j
JOIN freakydex f 
    ON j.celular_cuenta_pk_fk = f.cel_cuenta_juego_fk1
   AND j.fecha_nacimiento_pk = f.fecha_naci_juego_fk2;

-- 4.	Mostrar el nombre del jugador con el total de pokemones que ha capturado, agrupados por nombre.
SHOW USER
SELECT systimestamp FROM dual;
SELECT j.nombre AS nombre_jugador, COUNT(f.id_pk) AS total_pokemones
FROM jugador j
JOIN freakydex f 
    ON j.celular_cuenta_pk_fk = f.cel_cuenta_juego_fk1
   AND j.fecha_nacimiento_pk = f.fecha_naci_juego_fk2
GROUP BY j.nombre;


SHOW USER
SELECT systimestamp FROM dual;
-- 5.	Mostrar los nombres de los freakymon y cantidad de dulces que ha acumulado de aquellos que tienen más de 100.
SELECT nombre, dulces_acumu
FROM freakydex
WHERE TO_NUMBER(dulces_acumu) > 100;


SHOW USER
SELECT systimestamp FROM dual;
-- 6.	Mostrar la información de todos los spins que se hayan hecho en una fecha en particular (usted decide la fecha).
SELECT *
FROM girada
WHERE TRUNC(fecha_h_m) = TO_DATE('2024-01-10', 'YYYY-MM-DD');


SHOW USER
SELECT systimestamp FROM dual;
SET LINESIZE 90
-- 7.	Mostrar los nombres de los jugadores (concatenado) y la edad que tienen y se organizan los datos por edad de menor a mayor.
SELECT j.nombre || ' ' || j.apellido || NVL(' ' || j.apellido_materno, '') AS nombre_completo,
       FLOOR(MONTHS_BETWEEN(SYSDATE, j.fecha_nacimiento_pk) / 12) AS edad
FROM jugador j
ORDER BY edad;


COMMIT;
