# Freakymon.sql
The FreakyMon Database System is a project inspired by Pokemon Go, a relational database designed to manage and simulate a fictional game environment. This project demonstrates the creation, management, and querying of complex datasets through SQL.

---

### Structure
- **16 Tables** organized into three levels:
  - **Level 1**: Core entities: (cuenta, gym, parade).
  - **Level 2**: Relational data: (jugador, freakydex).
  - **Level 3**: Advanced relationships: (agarre, pelea, gym_mon).

- ### Example Structure 
### **Table: Mon** (Pokémon)
| Column           | Type          | Description                        |
|-------------------|---------------|------------------------------------|
| **id_pk**         | `VARCHAR2(7)`| Primary key (unique ID for Mon).   |
| **id_dex_fk**     | `VARCHAR2(50)`| Foreign key linking to FreakyDex. |
| **genero**        | `VARCHAR2(2)`| Gender of the Mon (M/F).           |
| **hp**            | `VARCHAR2(7)`| Health points.                     |
| **fecha_captura** | `TIMESTAMP(9)`| Capture date and time.             |
| **comentario**    | `VARCHAR2(100)`| Additional comments.               |
| **cp**            | `VARCHAR2(10)`| Combat power.                      |
| **cantidad_victoria** | `VARCHAR2(10)`| Number of victories.           |
| **estrella**      | `VARCHAR2(3)`| Star rating (1-3).                 |
| **peso**          | `VARCHAR2(10)`| Weight of the Mon.                 |
| **estatura**      | `VARCHAR2(6)`| Height of the Mon.                 |
---
### **Table: Gym_Mon** (Gym-Relationship)
| Column                | Type          | Description                          |
|------------------------|---------------|--------------------------------------|
| **id_gym_pk_fk1**      | `VARCHAR2(7)`| Foreign key referencing Gym ID.      |
| **id_mon_pk_fk2**      | `VARCHAR2(7)`| Foreign key referencing Mon ID.      |
| **fecha_h_captura_pk3**| `TIMESTAMP(9)`| Timestamp of capture date and time. |
| **fecha_h_darrota_pk4**| `TIMESTAMP(9)`| Timestamp of defeat date and time.  |


---

### Purpose of the Data Structure
The FreakyMon Database System efficiently manages game data through a structured relational model of 16 tables with primary and foreign keys ensuring data integrity. It includes querying player stats, inventories, and creature metrics via 27 predefined queries, offering insights like average CP, highest CP, and creature counts by type. Designed for scalability and accuracy, it reflects real-world database practices in managing complex data relationships.

---


### Example Queries
- Retrieve player details and their captured FreakyMons.
- Calculate the average CP of FreakyMons grouped by type.
- Display player inventory and acquisition history.
- Identify the FreakyMon with the highest CP.


Type2
HP, Attack, Defense, Speed, Special Attack, Special Defense

---
