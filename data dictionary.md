

## **4. DATA DICTIONARY (Key Tables)**

### **Table: MEDICINE**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| medicine_id | NUMBER(10) | PK, NOT NULL | Unique medicine identifier |
| medicine_name | VARCHAR2(100) | NOT NULL | Brand name of medicine |
| generic_name | VARCHAR2(100) | | Generic chemical name |
| category | VARCHAR2(50) | CHECK | Tablet, Capsule, Syrup, etc. |
| dosage_form | VARCHAR2(50) | | Oral, Injection, Topical, etc. |
| strength | VARCHAR2(50) | | 500mg, 250mg, etc. |
| manufacturer | VARCHAR2(100) | | Manufacturing company |
| storage_conditions | VARCHAR2(200) | | Room temp, Refrigerated, etc. |
| min_stock_level | NUMBER(5) | DEFAULT 10 | Minimum stock before reorder |
| max_stock_level | NUMBER(5) | | Maximum stock capacity |
| created_date | DATE | DEFAULT SYSDATE | Record creation date |
| last_updated | DATE | DEFAULT SYSDATE | Last update timestamp |

### **Table: BATCH (Most Important Table)**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| batch_id | NUMBER(10) | PK, NOT NULL | Unique batch identifier |
| medicine_id | NUMBER(10) | FK → MEDICINE, NOT NULL | Reference to medicine |
| supplier_id | NUMBER(10) | FK → SUPPLIER | Supplier reference |
| batch_number | VARCHAR2(50) | UNIQUE, NOT NULL | Manufacturer batch number |
| manufacture_date | DATE | NOT NULL | Date of manufacture |
| expiry_date | DATE | NOT NULL | Expiry date |
| purchase_date | DATE | DEFAULT SYSDATE | Date purchased |
| purchase_price | NUMBER(10,2) | | Price per unit |
| quantity_received | NUMBER(6) | NOT NULL, CHECK>0 | Total received quantity |
| quantity_available | NUMBER(6) | NOT NULL | Current available quantity |
| status | VARCHAR2(20) | CHECK, DEFAULT 'ACTIVE' | ACTIVE/EXPIRED/DISPOSED |
| shelf_location | VARCHAR2(50) | | Physical storage location |
| received_by | NUMBER(10) | FK → EMPLOYEE | Employee who received |

**Constraints on BATCH:**
- `expiry_date > manufacture_date` (CHECK constraint)
- `quantity_available ≤ quantity_received` (CHECK constraint)
- `status IN ('ACTIVE', 'EXPIRED', 'DISPOSED', 'RETURNED')`

### **Table: ALERT**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| alert_id | NUMBER(10) | PK, NOT NULL | Unique alert identifier |
| batch_id | NUMBER(10) | FK → BATCH, NOT NULL | Reference to batch |
| alert_type | VARCHAR2(30) | CHECK | Type of alert |
| alert_date | DATE | DEFAULT SYSDATE | Alert generation date |
| alert_message | VARCHAR2(500) | | Detailed alert message |
| acknowledged | CHAR(1) | DEFAULT 'N', CHECK | Y/N flag |
| acknowledged_by | NUMBER(10) | FK → EMPLOYEE | Employee who acknowledged |
| acknowledged_date | DATE | | Date of acknowledgement |

**Alert Types:** EXPIRY_30_DAYS, EXPIRY_15_DAYS, EXPIRY_7_DAYS, EXPIRED, LOW_STOCK

---

