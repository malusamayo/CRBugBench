#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Common/Securities/SecurityPortfolioModel.cs`:

This pull request introduces the defect later reported as "Future non account currency funds application". The
problem a user observed, and its root cause:

<!--- This template provides sections for bugs and features. Please delete any irrelevant sections before submitting -->

#### Expected Behavior
<!--- Required. Describe the behavior you expect to see for your case. -->
- Future last trade profit is applied correctly over non account currency cash instance.
> Behavior used as reference https://github.com/QuantConnect/Lean/blob/master/Common/Securities/SecurityPortfolioModel.cs#L75
#### Actual Behavior
<!--- Required. Describe the actual behavior for your case. -->
- When a `Future` position is closed and the funds are applied to the corresponding non account currency `Cash` https://github.com/QuantConnect/Lean/blob/master/Common/Securities/SecurityPortfolioModel.cs#L103 `lastTradeProfit` has the conversion rate applied on it (it shouldn't)
#### Potential Solution
<!--- Optional. Describe any potential solutions and/or thoughts as to what may be causing the difference between expected and actual behavior. -->
- Remove application of currency conversion
#### Reproducing the Problem
<!--- Required for Bugs. Describe how to reproduce the problem. This can be via a failing unit test or a simplified algorithm that reliably demonstrates this issue.  -->
```
        [Test]
        public void NonAccountCurrencyFuture_LongToFlat()
        {
            var reference = new DateTime(2016, 02, 16, 11, 53, 30);
            SecurityPortfolioManager portfolio;
            InitializeTest(reference, out portfolio);

            var cash = new Cash("EUR", 0, 10, CashBookTests.AccountCurrency);
            portfolio.CashBook.Add("EUR", cash);
            var future = new Future(
                Symbols.Fut_SPY_Feb19_2016,
                SecurityExchangeHours.AlwaysOpen(DateTimeZone.Utc),
                cash,
                SymbolProperties.GetDefault("EUR"),
                portfolio.CashBook
            );
            future.Holdings.SetHoldings(50m, 100);
            portfolio.Securities.Add(future);

            var fillPrice = 100m;
            var fillQuantity = -future.Holdings.Quantity;
            var orderFee = new OrderFee(new CashAmount(1m, future.QuoteCurrency.Symbol));
            var orderDirection = fillQuantity > 0 ? OrderDirection.Buy : OrderDirection.Sell;
            var fill = new OrderEvent(1, future.Symbol, reference, OrderStatus.Filled, orderDirection, fillPrice, fillQuantity, orderFee);
            portfolio.ProcessFill(fill);

            // current implementation doesn't back out fees.
            Assert.AreEqual(10, future.Holdings.TotalFees); // 1 EUR * 10 (conversion rate to account currency)
            // bought @50 and sold @100 = (-50*100)+(100*100) = 50000 * 10 (conversion rate to account currency)
            Assert.AreEqual(50000m, future.Holdings.LastTradeProfit);
            // bought @50 and sold @100 = (-50*100)+(100*100 - 1) = 4999
            Assert.AreEqual(4999, portfolio.CashBook["EUR"].Amount);
        }
```
#### System Information
<!--- Required for Bugs. Include any system specific information, such as OS. -->
N/A
#### Checklist
<!--- Confirm that you've provided all the required information. -->
<!--- Required fields --->
- [x] I have completely filled out this template
- [x] I have confirmed that this issue exists on the current `master` branch
- [x] I have confirmed that this is not a duplicate issue by searching [issues](https://github.com/QuantConnect/Lean/issues)
<!--- Required for Bugs, feature request can delete the line below. -->
- [x] I have provided detailed steps to reproduce the issue

<!--- Template inspired by https://github.com/stevemao/github-issue-templates -->

This same root cause must be fixed before merging.
REVIEW_EOF
