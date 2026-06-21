# ULK Academic Activity and Resource Management System

## Student ID: 202310734

## Description

PostgreSQL database system for managing academic operations
at Kigali Independent University (ULK).

## Tables (15)

- student, lecturer, course, department, faculty
- enrollment, schedule, attendance
- research_project, supervision
- academic_event, event_participant
- academic_space, resource, person

## Database Size

- Total Size: 9,150 kB
- Total Records: 873+

## How to Run

1. Install PostgreSQL 18
2. Create database: CREATE DATABASE ulk_academic;
3. Run: psql -U postgres -d ulk_academic -f ulk_academic.sql

## Performance Dashboard (Assignment - June 22)

See /dashboard folder — Node.js + Express dashboard comparing
indexed vs non-indexed PostgreSQL search performance on 5,000,000 records.

### To run:

cd dashboard
npm install
npm start

## Course

Advanced Database Management — ULK
Lecturer: KAMATE KATENDE TIMOTHEE
