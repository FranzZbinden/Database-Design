# FreakyMon GO Database Project

A complete relational database system for **FreakyMon GO**, a mobile game featuring creature collection, battles, and world exploration.

---

## 📋 Project Overview
This project simulates the **backend database** of a Pokémon GO–style game.  
It was developed for the **SICI-4030 – Database Systems** course to demonstrate advanced relational database design principles.

---

## 🎯 Project Goals
- Design and implement a robust database simulating **real-world game mechanics**.  
- Support player progression, creature collection, battles, and inventory management.  
- Showcase **complex relationships** including recursive, ternary, and many-to-many structures.  

---

## 🗃️ Database Architecture

### Design Specifications
- **16 total tables** organized by complexity levels  
- **6 associative tables** (for many-to-many relationships)  
- **1 ternary relationship** with exclusivity constraints  
- **1 recursive relationship** (FreakyMon evolution chain)  
- **1 one-to-one relationship**  

### Core Entity Groups
- **User Management** → Accounts, player profiles, progression  
- **Creature System** → FreakyMon species, types, evolution chains  
- **Game World** → Gyms, stops, and locations  
- **Inventory** → Items, player inventory, usage tracking  
- **Gameplay** → Battles, captures, FreakyDex collections  
- **Combat System** → Attacks, type effectiveness, battle records  

---

## 📊 Design Documentation
### Entity-Attribute Matrix
<img width="1474" height="796" alt="Entity Matrix" src="https://github.com/user-attachments/assets/b56acd4b-ab83-43a4-8127-5501f2a627c2" />

### ERD Diagram
<img width="589" height="682" alt="ERD Diagram" src="https://github.com/user-attachments/assets/d5b1c91e-2a34-4202-a56a-0f871e36d5c3" />

---

## ⚙️ Technical Implementation

### Database Features
- **Platform:** Oracle SQL  
- **Constraints:** Referential integrity, composite keys, temporal tracking  
- **Relationships:** Complex primary/foreign key mappings  

---

## 🎮 Game Mechanics Simulated

### Core Systems
- **Player Progression**
  - Account management and level tracking  
  - Experience points and achievement systems  

- **Creature Collection**
  - Capture and evolution tracking  
  - FreakyDex completion progress  
  - Rarity and type systems  

- **World Interaction**
  - Gym battles with exclusive participation  
  - Stop spinning for item collection  
  - Location-based gameplay  

- **Inventory Management**
  - Item collection and usage limits  
  - Potions, balls, and boost items  
  - Battle item effectiveness  

- **Combat System**
  - Type-based attack effectiveness  
  - Battle history and outcomes  
  - Multi-participant battle support  

---

## ✅ Project Deliverables

### Technical Components
- Complete **DDL Implementation** (all 16 tables with constraints)  
- **Sample Data Population** (realistic test data)  
- **Complex Query Demonstrations** (10+ queries)  
- **Documentation** (entity matrix and ERD)  
- **Level-Based Organization** (progressive complexity structure)  

### Database Objectives
- Normalized relational design  
- Complex relationship modeling  
- Referential integrity enforcement  
- Real-world system simulation  

---

## 🔬 Key Technical Achievements

### Advanced Features
- **Recursive Evolution Tracking** – modeling creature evolution chains  
- **Exclusive Relationship Handling** – gym/stop spin mechanics  
- **Temporal Data Management** – battle timestamps and progression history  
- **Inventory Constraints** – item limits and usage validation  

### Query Capabilities
Supports analytical queries for:  
- Player progression analytics  
- Battle outcome statistics  
- Creature collection completeness  
- Item usage patterns  
- Type effectiveness analysis  

---

## 📈 Project Significance
This project demonstrates **professional-grade database design** for a complex game system by showcasing:  
- Scalable architecture capable of supporting thousands of players  
- Data integrity through comprehensive constraints  
- Query performance considerations via indexing  
- Maintainability with normalized design and clear documentation  

---

## 🎯 System Capabilities

### Data Management
- **Player Accounts:** Secure profile management and progression tracking  
- **Creature Database:** Complete FreakyMon catalog with evolution paths  
- **Live Gameplay:** Real-time battle and capture event logging  
- **Inventory System:** Dynamic item management with usage constraints  

### Business Intelligence
- **Player Analytics:** Behavior tracking and engagement metrics  
- **Game Balance:** Type effectiveness and rarity analysis  
- **Economic Modeling:** Item usage and resource flow  
- **Performance Monitoring:** System load and database optimization  

