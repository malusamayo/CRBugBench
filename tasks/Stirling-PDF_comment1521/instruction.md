# Code Review Task

You are a maintainer reviewing a pull request to the `Stirling-Tools/Stirling-PDF` repository.

**PR title:** Preparation for Switching to a New Database Version

**PR description:**

# Description

This pull request includes extensive changes and additions that serve as a preparation for switching to a new version of the database software. The changes aim to enhance data security, improve database backup management, and facilitate the migration to a newer version of the H2 database.

## Details of Changes

1. Gradle Build File Updates (build.gradle)
Added Exclusions: Certain paths and files are now excluded if DOCKER_ENABLE_SECURITY is set to false. This includes files such as DatabaseController.java and DatabaseWebController.java.
H2 Database Dependency: A commented line for a newer version of the H2 database (2.2.224) has been added to facilitate future updates.
2. Clean URL Interceptor (CleanUrlInterceptor.java)
New URL Parameter: The parameter infoMessage has been added to the list of ignored URL parameters.
3. New Interface for Database Backups (DatabaseBackupInterface.java)
New Methods: The interface defines methods for exporting, importing, checking, and listing database backups.
4. Initial Security Setup (InitialSecuritySetup.java)
Database Backup Integration: The init method has been updated to consider database backups. If backups are present, the database will be imported automatically.
Logging Changes: Logging is now performed using Lombok's @Slf4j.
5. User Service (UserService.java)
Database Backup Integration: Various methods have been updated to create a database backup after changes.
Logging Changes: Logging is now performed using Lombok's @Slf4j.
6. Database Backup Helper (DatabaseBackupHelper.java)
Backup and Restore Functionality: Implementation of methods for exporting and importing database backups, as well as managing backup files.
7. Scheduled Tasks for Database Backups (ScheduledTasks.java)
Scheduled Backups: A daily scheduled task has been added to automatically create database backups.
8. Database API Controller (DatabaseController.java)
New Endpoints: Endpoints for importing, deleting, and downloading database backup files have been added.
9. User API Controller (UserController.java)
Exception Handling: Methods have been updated to handle IO-related exceptions.
10. Database Web Controller (DatabaseWebController.java)
New Controller: A new controller to manage database imports and exports through the web interface.
11. File Info Utility Class (FileInfo.java)
New Utility Class: A class for handling file information, such as file size and creation date.
12. Internationalization (messages_*.properties)
New Entries: Additional entries for database import/export functionality in various language files.
13. HTML Template for Database Management (database.html)
New Template: An HTML page for managing database imports and exports through the web interface.
Conclusion

These changes are a crucial step towards a stable and secure transition to a newer version of the H2 database. They improve data integrity and enable easy management and restoration of database backups. If you have any questions or comments about these changes, please feel free to reach out.

## Checklist:

- [x] I have read the [Contribution Guidelines](https://github.com/Stirling-Tools/Stirling-PDF/blob/main/CONTRIBUTING.md)
- [x] I have performed a self-review of my own code
- [x] I have commented my code, particularly in hard-to-understand areas
- [x] My changes generate no new warnings

## Contributor License Agreement

By submitting this pull request, I acknowledge and agree that my contributions will be included in Stirling-PDF and that they can be relicensed in the future under the MPL 2.0 (Mozilla Public License Version 2.0) license.

(This does not change the general open-source nature of Stirling-PDF, simply moving from one license to another license)

## Working environment

The repository is checked out at `/app/Stirling-PDF` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
