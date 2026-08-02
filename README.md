# Swimming Analytics Platform

## Overview

Swimming Analytics Platform is a personal analytics project designed to collect, organize, and analyze swimming training data over an entire season.

The project combines workout data exported from Apple Health with manually maintained training plans and official meet results to create a centralized swimming data warehouse. The goal is to measure long-term progress, identify training trends, and build meaningful performance analytics rather than simply displaying workout summaries.

The project also serves as a portfolio demonstrating modern data engineering practices including medallion architecture, data modeling, automated transformations, and analytical reporting.

---

# Goals

The primary goals of the project are to:

* Preserve all exported Apple Health workout data
* Build a clean and reusable analytics model
* Track season-long training volume
* Measure improvements in swimming performance
* Compare practice data with official meet results
* Provide dashboards for historical analysis
* Serve as a hands-on data engineering project

---

# Project Scope

## Version 1

Version 1 focuses on practice-level analytics.

Features include:

* Apple Health data ingestion
* Bronze, Silver, and Gold data layers
* Practice summaries
* Weekly and monthly training metrics
* Meet result tracking
* Performance dashboards

Version 1 intentionally does **not** attempt to reconstruct every interval or analyze individual strokes.

---

## Future Versions

Potential future enhancements include:

* Interval reconstruction
* Stroke count analysis
* Heart rate analytics
* Stroke efficiency metrics
* Automatic workout matching
* AI-generated training insights
* Predictive race performance
* Coach dashboards

These features remain possible because all raw source data is preserved within the Bronze layer.

---

# Architecture

The project follows the Medallion Architecture.

```text
Apple Health Export
        │
        ▼
+----------------+
| Bronze Layer   |
| Raw Data       |
+----------------+
        │
        ▼
+----------------+
| Silver Layer   |
| Cleaned Models |
+----------------+
        │
        ▼
+----------------+
| Gold Layer     |
| Analytics      |
+----------------+
        │
        ▼
Dashboards & Reports
```

---

# Data Layers

## Bronze

The Bronze layer stores all raw Apple Health exports exactly as received.

Examples include:

* Workouts
* Distance
* Heart Rate
* Stroke Count

No business logic is applied.

The Bronze layer is considered the immutable source of truth.

---

## Silver

The Silver layer standardizes and cleans the source data.

Typical transformations include:

* Unit conversions
* Timestamp normalization
* Data quality validation
* Practice aggregation
* Dimension creation

This layer provides consistent datasets for downstream analytics.

---

## Gold

The Gold layer contains business-ready analytical models.

Examples include:

* Practice summaries
* Weekly training volume
* Monthly distance
* Average pace
* Meet performance
* Season statistics
* Historical trend reporting

---

# Technology Stack

* Apple Health Export
* Python
* Databricks
* Delta Lake
* dbt
* SQL
* Git / GitHub

Future dashboard options may include:

* Power BI
* Tableau
* Databricks Dashboards

---

# Design Principles

This project follows several guiding principles.

## Preserve Raw Data

Raw source data is never modified.

Every export is stored exactly as received.

---

## Keep Version 1 Simple

Version 1 prioritizes reliable practice analytics over advanced swimming metrics.

Complex features can be added later without redesigning the architecture.

---

## Build Incrementally

Each layer should provide value independently.

Every enhancement should build upon an already working foundation.

---

## Document Design Decisions

Important architectural decisions are documented using Architecture Decision Records (ADRs).

This provides historical context for future enhancements and maintenance.

---

# Repository Structure

```text
swimming-analytics/

├── data/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── dbt/
│
├── notebooks/
│
├── ingestion/
│
├── dashboards/
│
├── docs/
│   ├── adr/
│   ├── architecture.md
│   ├── data-model.md
│   └── roadmap.md
│
├── tests/
│
└── README.md
```

---

# Roadmap

## Version 1

* [ ] Apple Health ingestion
* [ ] Bronze data models
* [ ] Silver transformations
* [ ] Gold practice summaries
* [ ] Meet results
* [ ] Basic dashboards

## Version 2

* [ ] Workout interval reconstruction
* [ ] Heart rate enrichment
* [ ] Stroke count analytics
* [ ] Training load metrics

## Version 3

* [ ] Predictive performance analytics
* [ ] AI-powered insights
* [ ] Coach reporting
* [ ] Automated recommendations

---

# License

This project is intended for personal learning, experimentation, and portfolio development.
