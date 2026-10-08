#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Infrastructure.EntityFramework/Repositories/CollectionRepository.cs`:

This pull request introduces the defect later reported as "Login entries disappear after adding Organization when using SQLite". The
problem a user observed, and its root cause:

### Steps To Reproduce

1. Stand up a fresh docker container (using SQLite as the DB) from the latest bitwarden/self-host:beta  (or dev, doesn't matter in this case)

Using Web Vault...
2. Create your account and verify your email address.
3. Add two fake login entries just to visually see there is an underlying problem.
4. +New Organization and upload the License file. (in my case it is a family org)
5. Log out and log back in.

### Expected Result

You should see the login entries you created and the organization you added.

### Actual Result

You don't see your login entries or the organization you added.  The client is receiving an HTTP 500 when attempting to sync.

### Screenshots or Videos

_No response_

### Additional Context

There is an API.log stack trace entry which I included below.  I pulled the latest Master and through some trial and error, I was able to isolate the issue to [Infrastructure.EntityFramework.Repositories.CollectionRepository.GetManyByUserIdAsync](https://github.com/bitwarden/server/blob/3d0ca908ff7c2bfb67d495ae263da69a822dfd6b/src/Infrastructure.EntityFramework/Repositories/CollectionRepository.cs#L308)

I did try mysql/mariadb and the the issue is not present in that configuration. (Though, I didn't go through all supported DB options...)

I refactored the code and built a new docker image/container and found that when the UserCollectionDetailsQuery is executed prior to the group by operation, it works.  **There could be a deeper underlying problem in the query, but I was able to get it to successfully execute by separately executing the group by.

This implementation executes:
`    public async Task<ICollection<CollectionDetails>> GetManyByUserIdAsync(Guid userId)
    {
        using (var scope = ServiceScopeFactory.CreateScope())
        {
            var dbContext = GetDatabaseContext(scope);
            var queryResult = await new UserCollectionDetailsQuery(userId).Run(dbContext).ToListAsync();

            var groupedResult = queryResult.GroupBy(c => new { c.Id, c.OrganizationId, c.Name, c.CreationDate, c.RevisionDate, c.ExternalId });

            return groupedResult.Select(cg => new CollectionDetails
            {
                Id = cg.Key.Id,
                OrganizationId = cg.Key.OrganizationId,
                Name = cg.Key.Name,
                CreationDate = cg.Key.CreationDate,
                RevisionDate = cg.Key.RevisionDate,
                ExternalId = cg.Key.ExternalId,
                ReadOnly = Convert.ToBoolean(cg.Min(c => Convert.ToInt32(c.ReadOnly))),
                HidePasswords = Convert.ToBoolean(cg.Min(c => Convert.ToInt32(c.HidePasswords))),
            }).ToList();
        }
    }`




Stack Trace:

2023-03-20 16:05:55.323 +00:00 [ERR] The LINQ expression 'GroupByShaperExpression:
KeySelector: new { 
    Id = c.Id, 
    OrganizationId = c.OrganizationId, 
    Name = c.Name, 
    CreationDate = c.CreationDate, 
    RevisionDate = c.RevisionDate, 
    ExternalId = c.ExternalId
 }, 
GroupingEnumerable:ShapedQueryExpression: 
    QueryExpression: 
        Projection Mapping:
            Outer.Outer.Outer.Outer.Outer.Outer -> EntityProjectionExpression: Collection
            Outer.Outer.Outer.Outer.Outer.Inner -> EntityProjectionExpression: OrganizationUser
            Outer.Outer.Outer.Outer.Inner -> EntityProjectionExpression: Organization
            Outer.Outer.Outer.Inner -> EntityProjectionExpression: CollectionUser
            Outer.Outer.Inner -> EntityProjectionExpression: GroupUser
            Outer.Inner -> EntityProjectionExpression: Group
            Inner -> EntityProjectionExpression: CollectionGroup
        SELECT 1
        FROM Collection AS c
        INNER JOIN OrganizationUser AS o ON c.OrganizationId == o.OrganizationId
        INNER JOIN Organization AS o0 ON c.OrganizationId == o0.Id
        LEFT JOIN CollectionUsers AS c0 ON ((o.AccessAll == 0) && (c.Id == c0.CollectionId)) && (o.Id == c0.OrganizationUserId)
        LEFT JOIN GroupUser AS g ON ((c0.CollectionId == NULL) && (o.AccessAll == 0)) && (o.Id == g.OrganizationUserId)
        LEFT JOIN Group AS g0 ON g.GroupId == g0.Id
        LEFT JOIN CollectionGroups AS c1 ON ((g0.AccessAll == 0) && (c.Id == c1.CollectionId)) && (g.GroupId == c1.GroupId)
        WHERE ((((o.UserId == @___userId_0) && (o.Status == 2)) && o0.Enabled) && (((o.AccessAll || (c0.CollectionId != NULL)) || g0.AccessAll) || (c1.CollectionId != NULL))) && ((((((c.Id == c.Id) && (c.OrganizationId == c.OrganizationId)) && (c.Name == c.Name)) && (c.CreationDate == c.CreationDate)) && (c.RevisionDate == c.RevisionDate)) && (c.ExternalId == c.ExternalId))
    ShaperExpression: new TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<Collection, OrganizationUser>, Organization>, CollectionUser>, GroupUser>, Group>, CollectionGroup>(
            Outer = new TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<Collection, OrganizationUser>, Organization>, CollectionUser>, GroupUser>, Group>(
                Outer = new TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<Collection, OrganizationUser>, Organization>, CollectionUser>, GroupUser>(
                    Outer = new TransparentIdentifier<TransparentIdentifier<TransparentIdentifier<Collection, OrganizationUser>, Organization>, CollectionUser>(
                        Outer = new TransparentIdentifier<TransparentIdentifier<Collection, OrganizationUser>, Organization>(
                            Outer = new TransparentIdentifier<Collection, OrganizationUser>(
                                Outer = EntityShaperExpression: 
                                    Bit.Infrastructure.EntityFramework.Models.Collection
                                    ValueBufferExpression: 
                                        ProjectionBindingExpression: Outer.Outer.Outer.Outer.Outer.Outer
                                    IsNullable: False
                                , 
                                Inner = EntityShaperExpression: 
                                    Bit.Infrastructure.EntityFramework.Models.OrganizationUser
                                    ValueBufferExpression: 
                                        ProjectionBindingExpression: Outer.Outer.Outer.Outer.Outer.Inner
                                    IsNullable: False
                            ), 
                            Inner = EntityShaperExpression: 
                                Bit.Infrastructure.EntityFramework.Models.Organization
                                ValueBufferExpression: 
                                    ProjectionBindingExpression: Outer.Outer.Outer.Outer.Inner
                                IsNullable: False
                        ), 
                        Inner = EntityShaperExpression: 
                            Bit.Infrastructure.EntityFramework.Models.CollectionUser
                            ValueBufferExpression: 
                                ProjectionBindingExpression: Outer.Outer.Outer.Inner
                            IsNullable: True
                    ), 
                    Inner = EntityShaperExpression: 
                        Bit.Infrastructure.EntityFramework.Models.GroupUser
                        ValueBufferExpression: 
                            ProjectionBindingExpression: Outer.Outer.Inner
                        IsNullable: True
                ), 
                Inner = EntityShaperExpression: 
                    Bit.Infrastructure.EntityFramework.Models.Group
                    ValueBufferExpression: 
                        ProjectionBindingExpression: Outer.Inner
                    IsNullable: True
            ), 
            Inner = EntityShaperExpression: 
                Bit.I

This same root cause must be fixed before merging.
REVIEW_EOF
