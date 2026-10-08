#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `xchange-stream-coinjar/src/main/java/info/bitrich/xchangestream/coinjar/CoinjarStreamingService.java` (around line 22): I don't this is is the right way to set this up because if you have disconnect and reconnect this will publish a message for every reconnect you have had during the course of your application. So if you disconnect 2 times and reconnect a 3rd this will publish your message 3 times a second when you reconnect.

You can test this by breaking internet connection deliberately and seeing how many time the message gets published. Something like (with your parameters and ping message): 

`    Observable.interval(1, TimeUnit.SECONDS)
        .subscribe(
            t -> {
              if (isSocketOpen()) webSocketChannel.writeAndFlush(new PingWebSocketFrame());
            });`

Should accomplish what you want
REVIEW_EOF
