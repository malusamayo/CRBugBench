#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Common/AlphaRuntimeStatistics.cs`:

This pull request introduces the defect later reported as "AlphaRuntimeStatistics issues with JSON deserialization". The
problem a user observed, and its root cause:

#### Expected Behavior
When deserializing an instance of `AlphaRuntimeStatistics`, the `MeanPopulationScore` and `RollingAveragedPopulationScore` values should be same as in the JSON string.

#### Actual Behavior
When deserializing an instance of `AlphaRuntimeStatistics`, the `MeanPopulationScore` and `RollingAveragedPopulationScore` values are set to zero.

#### Potential Solution
JSON deserialization requires a parameterless constructor.

#### Reproducing the Problem
This is a failing unit test:
``` C#
        [Test]
        public void HandlesSerializationRoundTrip()
        {
            var stats = new AlphaRuntimeStatistics
            {
                LongCount = 10,
                ShortCount = 11,
                TotalAccumulatedEstimatedAlphaValue = 100,
                TotalInsightsAnalysisCompleted = 7,
                TotalInsightsGenerated = 6,
                TotalInsightsClosed = 5
            };

            var time = DateTime.UtcNow;
            stats.MeanPopulationScore.SetScore(InsightScoreType.Direction, 0.5, time);
            stats.MeanPopulationScore.SetScore(InsightScoreType.Magnitude, 0.6, time);
            stats.RollingAveragedPopulationScore.SetScore(InsightScoreType.Direction, 0.55, time);
            stats.RollingAveragedPopulationScore.SetScore(InsightScoreType.Magnitude, 0.66, time);

            var json = JsonConvert.SerializeObject(stats);

            var deserialized = JsonConvert.DeserializeObject<AlphaRuntimeStatistics>(json);

            Assert.AreEqual(10, deserialized.LongCount);
            Assert.AreEqual(11, deserialized.ShortCount);
            Assert.AreEqual(100, deserialized.TotalAccumulatedEstimatedAlphaValue);
            Assert.AreEqual(7, deserialized.TotalInsightsAnalysisCompleted);
            Assert.AreEqual(6, deserialized.TotalInsightsGenerated);
            Assert.AreEqual(5, deserialized.TotalInsightsClosed);

            Assert.AreEqual(0.5, deserialized.MeanPopulationScore.Direction);
            Assert.AreEqual(0.6, deserialized.MeanPopulationScore.Magnitude);
            Assert.AreEqual(time, deserialized.MeanPopulationScore.UpdatedTimeUtc);
            Assert.AreEqual(0.55, deserialized.RollingAveragedPopulationScore.Direction);
            Assert.AreEqual(0.66, deserialized.RollingAveragedPopulationScore.Magnitude);
            Assert.AreEqual(time, deserialized.RollingAveragedPopulationScore.UpdatedTimeUtc);
        }
```

#### Checklist
- [x] I have completely filled out this template
- [x] I have confirmed that this issue exists on the current `master` branch
- [x] I have confirmed that this is not a duplicate issue by searching [issues](https://github.com/QuantConnect/Lean/issues)
- [x] I have provided detailed steps to reproduce the issue

This same root cause must be fixed before merging.
REVIEW_EOF
