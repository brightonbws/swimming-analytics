ADR-001: Store All Apple Health Data in Bronze

Status: Accepted

Date: 2026-08-02

Context

Apple Health exports multiple files (workouts, distance, heart rate, stroke count, etc.). Future analyses may require fields not currently used.

Decision

Store every exported file in the Bronze layer exactly as received. No transformations except ingestion metadata.

Consequences
Pros
Never lose source data.
Can build new Silver models later.
Easy to reprocess if business rules change.
Cons
Requires more storage (minimal concern).
Some Bronze tables won't be used immediately.