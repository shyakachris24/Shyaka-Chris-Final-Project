#  Documentation


# 🏗️ System Architecture

## 🎯 Overview
Medicine Inventory Management System - A PL/SQL-based solution for tracking medicine expiry and inventory.

---

## 📐 System Architecture

### High-Level Design
```
┌─────────────────────────────────────────┐
│         APPLICATION INTERFACE           │
│  • SQL*Plus / SQL Developer            │
│  • PL/SQL Procedures & Functions       │
└─────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────┐
│           BUSINESS LOGIC LAYER          │
│  ┌───────────────────────────────────┐  │
│  │     medicine_management_pkg       │  │
│  │  • Procedures: Automated tasks    │  │
│  │  • Functions: Calculations        │  │
│  │  • Cursors: Row processing        │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────┐
│           DATA STORAGE LAYER            │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐ │
│  │ MEDICINE│  │  BATCH  │  │ AUDIT   │ │
│  │  Table  │  │  Table  │  │  LOG    │ │
│  └─────────┘  └─────────┘  └─────────┘ │
└─────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────┐
│           DATABASE ENGINE               │
│  • Oracle 19c/21c                      │
│  • PL/SQL Processing                   │
│  • Transaction Management              │
└─────────────────────────────────────────┘
```

---

## 🔧 Key Components

### 1. **Database Tables**
- **MEDICINE** - Master medicine information
- **BATCH** - Medicine batches with expiry dates  
- **AUDIT_LOG** - Change tracking and security

### 2. **PL/SQL Components**
- **Procedures**: `display_expiry_ranking`, `process_expired_batches`
- **Functions**: `get_urgency_level`, `get_total_inventory_value`
- **Package**: `medicine_management_pkg` (groups all components)

### 3. **Business Logic**
- Expiry date calculations
- Inventory value computations
- Status validation rules
- Audit trail management

---

## 🔄 Data Flow

1. **User Action** → Calls procedure/function
2. **Business Logic** → Validates & processes
3. **Data Access** → Reads/writes tables
4. **Audit Logging** → Records changes automatically
5. **Result Return** → Displays/outputs results

**Example - Check Expiry:**
```
User → display_expiry_ranking() 
     → Query BATCH table with window functions
     → Calculate urgency levels
     → Format output
     → Display ranked list
```

---

## 🛡️ Security Features

1. **Audit Trail** - All changes logged in AUDIT_LOG
2. **Data Validation** - Check constraints on tables
3. **Error Handling** - Comprehensive exception management
4. **Access Control** - Database user privileges

---

## ⚡ Performance Optimizations

- **Indexes** on frequently queried columns (expiry_date, status)
- **Window Functions** for efficient analytics
- **Cursors** for optimized row processing
- **Package** caching for faster execution

---

## 🔗 Technology Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| Database | Oracle | Data storage & processing |
| Language | PL/SQL | Business logic implementation |
| Interface | SQL Developer | Administration & testing |
| Version Control | GitHub | Code management |

---

## 📈 Scalability

### Current: Single database, manual operation
### Future: 
- Automated scheduled jobs
- Web interface (Oracle APEX)
- Mobile notifications for expiry alerts
- Multi-location support

---
*Architecture v1.0 | Medicine Inventory System*



# **📄 documentation/design_decisions.md**


# 🎯 Design Decisions

## 📋 Why These Choices Were Made

---

## 1. **Database Choice: Oracle**
**Why?** 
- Required for course (PL/SQL focus)
- Robust enterprise features
- Excellent PL/SQL support
- Industry standard in healthcare

## 2. **Table Structure**
### Separate MEDICINE and BATCH tables
**Reason:** Real-world scenario - same medicine has multiple batches with different expiry dates.

### AUDIT_LOG table
**Reason:** Track all changes for security and compliance.

## 3. **PL/SQL Over Application Code**
**Why PL/SQL?**
- Faster data processing (closer to data)
- Reduced network traffic
- Better for batch operations
- Meets course requirements

## 4. **Package Design**
### Single package `medicine_management_pkg`
**Benefits:**
- Organized code
- Better performance (caching)
- Easier maintenance
- Professional structure

## 5. **Procedure vs Function Rules**

| Use Procedure When | Use Function When |
|-------------------|-------------------|
| Modifying data | Returning a value |
| No return needed | Using in SQL queries |
| Complex operations | Simple calculations |

**Examples:**
- `process_expired_batches()` → Procedure (updates data)
- `get_urgency_level()` → Function (returns value)

## 6. **Cursor Implementation**
### Explicit cursor in `process_expired_batches`
**Why?**
- Better control over row processing
- Proper error handling per row
- Clear OPEN/FETCH/CLOSE structure

## 7. **Window Functions Usage**
### For ranking and analytics
**Why Window Functions?**
- Single query pass (efficient)
- Clean, readable code
- Powerful analytics capabilities
- Meets Phase VI requirements

## 8. **Audit Strategy**
### Triggers + AUDIT_LOG table
**Instead of Oracle's built-in auditing:**
- More control over data format
- Easier querying for reports
- Customizable for business needs

## 9. **Error Handling Approach**
### Try-Catch in every component
**Why?**
- Prevents system crashes
- User-friendly error messages
- Logs errors for debugging
- Professional code quality

## 10. **Output Method: DBMS_OUTPUT**
**Why not GUI?**
- Course requirement (console output)
- Simple to implement and test
- Easy to demonstrate
- Can be redirected to files

---

## 🔄 Trade-offs Made

### 1. **Simplicity vs Features**
**Chose:** Core features done well
- Perfect expiry tracking
- Complete audit system
- Basic but functional

**Postponed:** Advanced features
- User interface
- Email notifications
- Mobile app

### 2. **Performance vs Flexibility**
**Example:** Batch status calculation
- Could: Store pre-calculated status (faster)
- Chose: Calculate dynamically (always accurate)

**Reason:** Expiry changes daily, accuracy is critical for medicines.

### 3. **Manual vs Automated**
**Current:** Manual procedure execution
**Future:** Automated scheduled jobs

**Reason:** Course focuses on PL/SQL development, not scheduling.

---

## ✅ Success Criteria Met

| Requirement | How Met |
|-------------|---------|
| 3-5 Procedures | 4 procedures created |
| 3-5 Functions | 5 functions created |
| Cursors | Explicit cursor implemented |
| Window Functions | ROW_NUMBER(), SUM() OVER() used |
| Packages | medicine_management_pkg created |
| Error Handling | Full exception management |
| Documentation | Complete docs provided |

---

## 🚀 Future Improvements

### Phase 2 (Next Semester):
1. Web interface with Oracle APEX
2. Automated expiry email alerts
3. Barcode scanning integration
4. Supplier management module

### Phase 3 (Production):
1. Mobile app for inventory checks
2. Real-time dashboard
3. Integration with hospital systems
4. Advanced analytics with machine learning

---

## 📚 Academic vs Practical Balance

**Academic Requirements Met:**
- All Phase I-VIII specifications
- PL/SQL concepts demonstrated
- Proper documentation

**Practical Value Added:**
- Real healthcare use case
- Production-ready code quality
- Business logic that actually works
- Scalable architecture

---

## 🏆 Key Design Principles Followed

1. **KISS** - Keep It Simple, Stupid
2. **DRY** - Don't Repeat Yourself
3. **YAGNI** - You Aren't Gonna Need It
4. **Fail Fast** - Early error detection

---
*Design Decisions v1.0 | December 2024*


---

## 📁 **File Structure:**

```
your-project-repo/
├── documentation/
│   ├── architecture.md          # 2-page system overview
│   └── design_decisions.md      # 2-page design rationale
└── (other project files...)
```

## 🎯 **Quick Summary:**

### **architecture.md** - Shows:
1. How the system is built
2. What components exist
3. How data flows
4. Technology used

### **design_decisions.md** - Explains:
1. Why we chose certain technologies
2. How we made key decisions
3. What trade-offs we accepted
4. What we'll improve next

**Both are clean, professional, and perfect for your Phase VIII submission!**
