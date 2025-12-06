#  **Phase VI: Database Interaction & Transactions - Complete Explanation**

##  **Phase VI Objective**
**To develop PL/SQL procedures, functions, packages, and cursors that interact with the database to automate business logic and data processing.**

---

## 🔧 **What I Created AND How It Works**

### **1.  PACKAGE (`medicine_management_pkg`)**
```sql
-- PACKAGE = Container that groups related procedures/functions
CREATE OR REPLACE PACKAGE medicine_management_pkg AS
    -- Package specification (public interface)
    -- Think of this like a "menu" of available operations
END;
```

**What it does:**
- **Organizes code** - Groups related procedures/functions together
- **Encapsulates logic** - Hides complex implementation details
- **Improves performance** - Reduces parsing time
- **Controls access** - Only exposes what's needed (through specification)

**Analogy:** Like a medicine cabinet with labeled compartments - everything is organized and easy to find.

---

### **2. 📝 PROCEDURES (Automated Operations)**
```sql
CREATE OR REPLACE PROCEDURE display_expiry_ranking AS
BEGIN
    -- Automatically ranks medicines by expiration urgency
END;
```

**Key Procedures I Created:**

| Procedure | What It Does | How It Works |
|-----------|-------------|-------------|
| `display_expiry_ranking` | Shows medicines ranked by expiry date | Uses **window function** `ROW_NUMBER()` to rank items, calculates days remaining |
| `process_expired_batches` | Updates expired medicine batches | Uses **explicit cursor** to loop through expired items and mark them |
| `generate_expiry_report` | Creates expiry report for next X days | Filters by date range, formats output professionally |
| `simple_ranking_example` | Demo of ranking functionality | Shows basic `ROW_NUMBER()` usage |
| `running_total_example` | Demo of running totals | Uses `SUM() OVER()` for cumulative totals |

**Why Procedures?**
- **Reusable code** - Write once, call many times
- **Parameterized** - Can accept inputs (like days threshold)
- **Transaction control** - Can commit/rollback automatically
- **Error handling** - Built-in exception management

---

### **3. ⚙️ FUNCTIONS (Calculations & Validations)**
```sql
CREATE OR REPLACE FUNCTION get_urgency_level(p_expiry_date DATE) 
RETURN VARCHAR2 AS
BEGIN
    -- Returns 'CRITICAL', 'URGENT', 'SAFE' etc.
END;
```

**Key Functions I Created:**

| Function | What It Does | Business Logic |
|----------|-------------|---------------|
| `get_urgency_level` | Determines urgency based on expiry | Days < 0 = EXPIRED, 0-7 = CRITICAL, etc. |
| `get_total_inventory_value` | Calculates total medicine value | SUM(quantity × unit_cost) for active items |
| `validate_batch_status` | Checks if batch status needs update | Compares expiry date with current date |
| `count_expiring_medicines` | Counts items expiring soon | WHERE expiry_date BETWEEN SYSDATE AND SYSDATE+X |
| `format_currency` | Formats numbers as currency | $1,234.56 format |

**Functions vs Procedures:**
- **Functions RETURN a value** (like calculations)
- **Procedures DO something** (like updates)
- Functions can be used in SQL queries
- Procedures cannot

---

### **4. 🎯 CURSORS (Row-by-Row Processing)**
```sql
CURSOR expired_cur IS
    SELECT * FROM batch WHERE expiry_date < SYSDATE;
    
-- Then process row by row
LOOP
    FETCH expired_cur INTO v_record;
    -- Process each expired batch
END LOOP;
```

**Types of Cursors:**
- **Explicit Cursor** (what we used): Manual control - `OPEN`, `FETCH`, `CLOSE`
- **Implicit Cursor**: Automatic - used in `FOR rec IN (SELECT...)` loops

**Why Use Cursors?**
- Process large datasets in manageable chunks
- Apply business logic to each row individually
- Update records based on complex conditions

---

### **5. 📊 WINDOW FUNCTIONS (Analytics)**
```sql
ROW_NUMBER() OVER (ORDER BY expiry_date) -- Ranking
SUM(value) OVER (ORDER BY date) -- Running total
RATIO_TO_REPORT(value) OVER () -- Percentage
```

**Window Functions I Used:**

| Function | Purpose | Example Use |
|----------|---------|-------------|
| `ROW_NUMBER()` | Sequential ranking | Rank medicines by expiry urgency |
| `SUM() OVER()` | Running totals | Cumulative inventory value |
| `RATIO_TO_REPORT()` | Percentage calculation | % of total inventory per category |

**Window Function Magic:**
- **"OVER" clause** defines the "window" of data
- **PARTITION BY** = group within groups
- **ORDER BY** = sequence for calculation
- **Doesn't reduce rows** - adds calculated columns

---

## 🏗️ **ARCHITECTURE FLOW**

```
USER REQUEST 
    ↓
PACKAGE INTERFACE (Specification)
    ↓
PROCEDURE/FUNCTION EXECUTION
    ↓
DATABASE INTERACTION (SQL Queries)
    ↓
BUSINESS LOGIC (PL/SQL Processing)
    ↓
    ├──▶ CURSORS (Row processing)
    ├──▶ WINDOW FUNCTIONS (Analytics)
    ├──▶ EXCEPTION HANDLING (Error management)
    └──▶ TRANSACTION CONTROL (Commit/Rollback)
    ↓
RESULT RETURNED TO USER
```

---

## 🔄 **HOW DATA FLOWS THROUGH MY SYSTEM**

1. **Input** → User/application calls a procedure
2. **Processing** → 
   - SQL queries fetch data
   - Cursors process rows
   - Functions calculate values
   - Window functions analyze
3. **Business Rules** →
   - Check expiry dates
   - Validate quantities
   - Apply status logic
4. **Output** →
   - Formatted reports
   - Database updates
   - Return values

**Example: Processing Expired Medicines**
```
1. Cursor selects expired batches from BATCH table
2. For each batch:
   - Function calculates urgency level
   - Procedure updates status to 'EXPIRED'
   - Sets quantity to 0 (can't use expired meds)
3. Window function ranks all items by expiry
4. Package formats final report
```

---

## 🛡️ **ERROR HANDLING & EXCEPTIONS**

```sql
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle missing data
    WHEN OTHERS THEN
        -- Catch-all for unexpected errors
        -- Log error message
        -- Rollback if needed
```

**Our Custom Exceptions:**
- `invalid_date_exception` - Bad date inputs
- `invalid_quantity_exception` - Negative quantities
- `medicine_not_found_exception` - Missing medicine ID

---

## ⚡ **PERFORMANCE FEATURES**

1. **Bulk Operations** - Process multiple rows efficiently
2. **Index Usage** - Proper indexing for fast queries
3. **Cursor Optimization** - Explicit control over memory
4. **Package Caching** - Compiled code stays in memory
5. **Parameterized Queries** - Reuse execution plans

---

## 🎓 **REAL-WORLD APPLICATIONS**

| Component | Real-World Use |
|-----------|---------------|
| Procedures | Daily expiry reports for pharmacy staff |
| Functions | Calculate insurance reimbursement amounts |
| Cursors | Batch processing of inventory updates |
| Window Functions | Sales trend analysis for management |
| Packages | Complete inventory management system |

---

## ✅ **PHASE VI SUCCESS CHECKLIST**

We successfully implemented:

1. **✅ 3+ Procedures** - Automated business operations
2. **✅ 3+ Functions** - Calculations and validations  
3. **✅ 1+ Cursors** - Row-by-row processing
4. **✅ 1+ Packages** - Professional code organization
5. **✅ Window Functions** - Advanced analytics
6. **✅ Exception Handling** - Robust error management
7. **✅ Parameterization** - Flexible, reusable code
8. **✅ Documentation** - Clear, commented code

---

## 🚀 **READY FOR PHASE VII**

**Phase VI prepared us for Phase VII by:**
- Establishing database interaction patterns
- Creating reusable code components  
- Implementing business logic
- Setting up error handling framework
- Building analytics capabilities

**Phase VII will add:**
- Triggers (automatic actions on data changes)
- Auditing (track all database activities)
- Security rules (who can do what, when)
- Advanced business rules (complex validations)

---

## 📖 **KEY TAKEAWAYS**

1. **PL/SQL = SQL + Programming Logic**
   - SQL for data access
   - Programming for business rules

2. **Packages = Organization**
   - Group related functionality
   - Hide complexity
   - Improve maintenance

3. **Procedures = Actions**
   - Do things (update, insert, process)
   - Can commit transactions

4. **Functions = Calculations**
   - Return values
   - Can be used in SQL

5. **Cursors = Row Processing**
   - Handle data row by row
   - Essential for complex updates

6. **Window Functions = Analytics**
   - Advanced calculations
   - Ranking, running totals, percentages

**Result:** A production-ready database system with automated business logic, analytics capabilities, and professional code structure!
