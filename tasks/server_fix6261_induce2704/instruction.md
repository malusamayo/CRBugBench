# Code Review Task

You are a maintainer reviewing a pull request to the `bitwarden/server` repository.

**PR title:** [SG-147] Organization Domain Claiming Feature (#2704)

**PR description / commit message:**

[SG-147] Organization Domain Claiming Feature (#2704)

* [SG-696] Organization Domain Claiming DB Objects and Migrations (#2394)

* model organization domain claiming

* Added migration scripts and db objects for mssql

* create and implement sql repository abstraction

* Added ef migrations for mysql and postgres. Removed time without timezone in previous migration

* made update on sql migration to use create or alter statement

* removed active column from OrganizationDomain table and decided to go with the hard delete approach

* Ran dotnet restore evaluate

* created DNS service verification using DNSClient (#2401)

* [SG-678] Api Endpoints for Domain Claiming (#2430)

* Added stored procedure to read claimed domains

* Updated Organization Domain Repository to include method to get claimed domains

* Updated domain entity and added request model

* Implemented organization domain respository and regsitered it in the various extensions

* Added create endpoint, request, responses and command

* Added endpoint to get domain by domain entry id

* Ran lint fix

* Added new stored procedure to get domains by organizattion id

* Moved migration scripts to init migration and added new procedure

* Renamed from domainId to Id

* Added and implemented GetDomainByOrganizationId

* Completed GetDomainByOrgId endpoint and started work on verify domain endpoint

* Updated the OrganizationDomain update procedure

* Added delete command and include other endpoints in the controller

* Remove test item from controller

* Remove test item from controller

* Changed access to allow admin, owners and manage sso roles

* changed logic for setting the initial value for the NextRunCount

* Renamed NextRunCount to JobRunCount

* Renamed NextRunCount to JobRunCount on mysql

* Renamed NextRunCount to JobRunCount on postgres

* Removed chaining pattern and added logic to get next run date

* Lint fix

* Added stored procedure to get organization sso details by email address

* Added endpoint to get sso details of an organization with email

* Added organizationDomainRepository to OrganizationController test

* merged with master and fixed conflicts

* [SG-661] Background Domain Verification Service (#2455)

* Added stored procedure to read claimed domains

* Updated Organization Domain Repository to include method to get claimed domains

* Updated domain entity and added request model

* Implemented organization domain respository and regsitered it in the various extensions

* Added create endpoint, request, responses and command

* Added endpoint to get domain by domain entry id

* Ran lint fix

* Added new stored procedure to get domains by organizattion id

* Moved migration scripts to init migration and added new procedure

* Renamed from domainId to Id

* Added and implemented GetDomainByOrganizationId

* Completed GetDomainByOrgId endpoint and started work on verify domain endpoint

* Updated the OrganizationDomain update procedure

* Added delete command and include other endpoints in the controller

* Remove test item from controller

* Remove test item from controller

* Changed access to allow admin, owners and manage sso roles

* Added stored procedure to get unverified domains by nextrundate

* Renamed stored procedure name

* Added domain verification service interface

* Added GetManyByNextRunDate to repository

* Added verification domain service implementation

* changed logic for setting the initial value for the NextRunCount

* This commit should be signed using my SSH key

* Renamed NextRunCount to JobRunCount

* Renamed NextRunCount to JobRunCount on mysql

* Renamed NextRunCount to JobRunCount on postgres

* Removed chaining pattern and added logic to get next run date

* Lint fix

* Implemented EF core version on the repository

* Created background job implementation and logic

* popped stash

* Updated stored procedure and EF script

* Lint fix

* Added logic to set next job count and the next run date when a verification is false

* Added logic to set next job count and the next run date when a verification is false

* Updated stored procedure name on repository

* Removed test trigger

* Lint fix

* Added trigger for job

* Added job count update after successful domain verification

* Lint fix

* Lint fix

* [SG-682] Add Event Log Entries to Organization Domain (#2492)

* Added domain name property to Event related objects

* Added organization domain claiming event types

* Created migration script and updated related event scripts to include domanName

* Added EF Migrations

* Renamed postres script file extension

* Added DomainName property to response model

* Added abstraction to interface

* Added system name to enum

* dotnet formattinfg fix

* Added events to organization domain actions

* Added LastCheckedDate property to domain

* Migrations and stored procedure updates with new column

* Added new stored procedure to get domain by org id and domain name

* Log organization domain event abstract method

* Ef migrattion to add new LastCheckedDate column

* Added duplicate domain exception

* Modified create command to include domain verification and last checked date and renamed methods used

* removed variable

* changed service lifetime

* Renamed trigger

* Initialed property in constructor

* Ensured domain name is stored as lower case

* Fixed suggestions from review

* Fixed suggestions from review

* Return Conflict Status on Organization Domain APIs (#2498)

* Added conflict response to end point to help translate error message on the client better

* Added conflict response to end point to help translate error message on the client better

* Set message with exception message or generic message

* Added last check date to response model (#2499)

* Fix/Check to throw exception when domain is claimed by another organization (#2503)

* Added check to ensure domain claimed by another organization cannot be verified

* Made error message consistent

* [SG-660] Organization Domain Maintenance (#2502)

* Added email template

* Mail service abstraction and implementation

* Mail template model

* Initial delete job commit

* Added SPs to get all unverifed domains after 72 hours and another to delete unverified domains after 7 days

* Moved all organization domain scripts to single file

* Added new scripts implementation for sqlserver and EF core

* Renamed service

* Formatting fix

* Added background service to send warning email and delete expired domains

* Renamed variable

* Added implementation for email warning to organization admins and for deleting expired domains after 7 days

* Added formatting

* Modified read if expired script to limit result to 4 days

* Added send mail abstract method and implementation

* Model used in build mail body

* Completed maintenace service

* Added comment to make logic clear

* Fixed cron expression (#2505)

* Modified procedure and methods to handle flexible verification adn expiration period (#2517)

* Merged with master

* [SG-908] Unit Tests for Organization Domain Claiming Feature (#2522)

* added test controlleer class

* added unit test for create command

* Added query tests

* Added tests for delete and verify command

* Formated code and added some more unit tests

* Fixed lint

* Added log event assertion to create command tests

* Added log event assertion to delete command tests

* Added unit tests for organization domain controller

* Added unit tests for organization domain service

* Modified test after merge

* fixed comment

* fixed comment

* fixed lint

* Defect/SG-977 - Org domain event logs missing details (#2573)

* SG-977 - (1) Refactor EventSystemUser.SSO to be EventSystemUser.DomainVerification to better match SCIM property and for easier display and translation on web client (2) Add new DeviceType of Server to be used on SCIM and Domain Verification logs so event log will show Server as client.

* SG-977 - SCIM bugfix - Restoring / Revoking user access via Jumpcloud activation / suspension did not properly log the events as SCIM events so the client side showed Unknown for both Client and Member.

* Run autoformat to fix lint errors

* SG-977 - Fixed broken test due to new device type logic in event service

* SG-976 - Add admin log and clean up log verbiage for domain verification (#2574)

* SG-976 - Add admin log and clean up log verbiage for domain verification

* SG-976 - (1) Use logInformation extension without exception (2) Clarify verbiage of logs

* SG-955 - On domain verification error or failure, set last checked da… (#2541)

* SG-955 - On domain verification error or failure, set last checked date on the org domain.

* SG-955 - Refactoring VerifyOrganizationDomain event logging to avoid duplication and increase efficiency (based on Gbubemi's PR feedback)

* Org Domain Background Verification service - set last checked date (#2599)

* Refactored OrganizationDomain repository to work with latest changes on code base

* Fixed formatting

* [SG-957] Cannot Delete Organizations due to FK Constraint (#2602)

* Added stored procedure to fix FX contstraint issue when deleting an organization

* Update stored procedures related to organization delete with OrganizationDomain_OrganizationDelete SP

* Fixed formatting

* Updated SP

* SG-990 - Log expired domains that are going to be deleted.

* Fix lint errors with auto format

* /home/runner/work/server/server/src/Core/OrganizationFeatures/OrganizationServiceCollectionExtensions.cs(107,2): error FINALNEWLINE: Fix final newline. Insert '\n'.

* Added missing bracket to fix compile error.

* Added imports for Domain Claiming classes that were lost on merge.

* Fixing broken unit tests + adding proper behavior for newly added SCIM logic changing device type

* Fix lint errors again

* Included domain name set in constructor (#2618)

* [SG-1001] Error Thrown When Verifying Sub Domains (#2621)

* Renamed exception to a more generic name that receives error message from the dns client and also added updates to job count and next run date

* Improved error logs by adding dns client error message

* Fixed formatting

* [SG-1001] Added event logs when a domain is not verified due to thrown exception (#2623)

* Added eevent logs when a domain is not verified due to thrown exception

* Fixed formatting

* Org Domain Verification - Small refactor to improve method/model name… (#2641)

* Org Domain Verification - Small refactor to improve method/model names and method locations - required refactoring of controller routes (I confirmed all behavior still functional)

* Fixed organization test controller issue

* Fixed lint

* Autoformat org domain controller

* Removing whitespace for lint argh, why does Rider not do this.

---------

Co-authored-by: gbubemismith <gsmithwalter@gmail.com>

* Tweak name of Request model to match Response model for ClaimedOrgDomain call

* [SG-1009] Users with Custom Role and "Manage SSO" permission don't receive verification failed email (#2645)

* Modified condition to pick up unverified domains after said period

* Fix to get emails of custom users with manage sso rights

* Formatted code

* Removed return that made background job exit on successful validation (#2648)

* [SG-1014] Unit Tests for Get Organization Sso Details (#2655)

* Added unit tests for GetOrgDomainSsoDetails

* renamed variable

* Adjust OrganizationDomainSsoDetails_ReadByEmail to use outer join so … (#2657)

* Adjust OrganizationDomainSsoDetails_ReadByEmail to use outer join so that claimed domain results will come back if an org has not yet setup a policy

* Removed migration as not needed

* Updated OrganizationDomainSsoDetails_ReadByEmail from original creation migration to use outer join & handle null policy results (and still return results)

* Fixed lint formatting

---------

Co-authored-by: Jared Snider <116684653+JaredSnider-Bitwarden@users.noreply.github.com>
Co-authored-by: Jared Snider <jsnider@bitwarden.com>
Co-authored-by: Todd Martin <tmartin@bitwarden.com>

## Working environment

The repository is checked out at `/app/server` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
