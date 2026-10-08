#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `server/src/main/java/org/elasticsearch/index/query/IntervalBuilder.java`:

This pull request introduces the defect later reported as "NullPointerException with intervals query". The
problem a user observed, and its root cause:

<!--

** Please read the guidelines below. **

Issues that do not follow these guidelines are likely to be closed.

1.  GitHub is reserved for bug reports and feature requests. The best place to
    ask a general question is at the Elastic [forums](https://discuss.elastic.co).
    GitHub is not the place for general questions.

2.  Is this bug report or feature request for a supported OS? If not, it
    is likely to be closed.  See https://www.elastic.co/support/matrix#show_os

3.  Please fill out EITHER the feature request block or the bug report block
    below, and delete the other block.

-->

<!-- Bug report -->

**Elasticsearch version**: 7.0.0

**Plugins installed**: None

**JVM version**: 1.8.0_171

**OS version**: Windows Server 2016

**Description of the problem including expected versus actual behavior**:

Elastic/Lucene throws a NullPointerException when an interval query is being executed while one of the matches is a stopword (stopword filter configured for the field).

**Steps to reproduce**:

 1. Create a new index with a language analyzer active for a specific field:
```
PUT interval_test
{
  "mappings": {
    "properties": {
      "content": {
        "type": "text",
        "analyzer": "english"
      }
    }
  }
}
```
 2. Index a new document containing text with at least one stopword
```
PUT interval_test/_doc/1
{
  "content": "the pioneer"
}
```
 3. Execute an intervals query where one of the match queries is a stopword
```
POST interval_test/_search
{
  "query": {
    "intervals" : {
      "content" : {
        "all_of" : {
          "intervals" : [
            {
              "all_of" : {
                "intervals" : [
                  { "match" : { "query" : "the" } },
                  { "match" : { "query" : "pioneer" } }
                ]
              }
            }
          ]
        }
      }
    }
  }
}
```

**Provide logs (if relevant)**:

``` 
Caused by: java.lang.NullPointerException
	at org.apache.lucene.search.intervals.ConjunctionIntervalsSource.intervals(ConjunctionIntervalsSource.java:78) ~[lucene-sandbox-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 12:00:11]
	at org.apache.lucene.search.intervals.IntervalQuery$IntervalWeight.scorer(IntervalQuery.java:184) ~[lucene-sandbox-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 12:00:11]
	at org.apache.lucene.search.Weight.scorerSupplier(Weight.java:143) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.apache.lucene.search.BooleanWeight.scorerSupplier(BooleanWeight.java:374) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.apache.lucene.search.BooleanWeight.scorerSupplier(BooleanWeight.java:374) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.apache.lucene.search.BooleanWeight.scorer(BooleanWeight.java:340) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.elasticsearch.common.lucene.search.function.FunctionScoreQuery$CustomBoostFactorWeight.functionScorer(FunctionScoreQuery.java:260) ~[elasticsearch-7.0.0.jar:7.0.0]
	at org.elasticsearch.common.lucene.search.function.FunctionScoreQuery$CustomBoostFactorWeight.scorer(FunctionScoreQuery.java:282) ~[elasticsearch-7.0.0.jar:7.0.0]
	at org.apache.lucene.search.Weight.scorerSupplier(Weight.java:143) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.apache.lucene.search.BooleanWeight.scorerSupplier(BooleanWeight.java:374) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.apache.lucene.search.BooleanWeight.scorer(BooleanWeight.java:340) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.apache.lucene.search.Weight.bulkScorer(Weight.java:177) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.apache.lucene.search.BooleanWeight.bulkScorer(BooleanWeight.java:334) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.apache.lucene.search.IndexSearcher.search(IndexSearcher.java:649) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.elasticsearch.search.internal.ContextIndexSearcher.search(ContextIndexSearcher.java:177) ~[elasticsearch-7.0.0.jar:7.0.0]
	at org.apache.lucene.search.IndexSearcher.search(IndexSearcher.java:443) ~[lucene-core-8.0.0.jar:8.0.0 2ae4746365c1ee72a0047ced7610b2096e438979 - jimczi - 2019-03-08 11:58:55]
	at org.elasticsearch.search.query.QueryPhase.execute(QueryPhase.java:275) ~[elasticsearch-7.0.0.jar:7.0.0]
	at org.elasticsearch.search.query.QueryPhase.execute(QueryPhase.java:115) ~[elasticsearch-7.0.0.jar:7.0.0]
	at org.elasticsearch.search.SearchService.loadOrExecuteQueryPhase(SearchService.java:349) ~[elasticsearch-7.0.0.jar:7.0.0]
	at org.elasticsearch.search.SearchService.executeQueryPhase(SearchService.java:393) ~[elasticsearch-7.0.0.jar:7.0.0]
	at org.elasticsearch.search.SearchService.access$100(SearchService.java:124) ~[elasticsearch-7.0.0.jar:7.0.0]
	at org.elasticsearch.search.SearchService$2.onResponse(SearchService.java:358) ~[elasticsearch-7.0.0.jar:7.0.0]
```

This same root cause must be fixed before merging.
REVIEW_EOF
