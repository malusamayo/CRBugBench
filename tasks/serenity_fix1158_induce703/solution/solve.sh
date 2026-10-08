#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/model/channel/message.rs`:

This pull request introduces the defect later reported as "Pulling certain message returns decoding error". The
problem a user observed, and its root cause:

Hello,

I was trying to pull all messages of certain channels on my server, and used https://docs.rs/serenity/0.9.3/serenity/model/id/struct.ChannelId.html#method.messages to manually go from the latest to the oldest message.
I quickly ran into an error. I went to the discord to ask and people suggested I use https://docs.rs/serenity/0.9.3/serenity/model/id/struct.ChannelId.html#method.messages_iter. Fine by me, saves me a lot of code. Somehow didn't see that in the documentation.

This is my code:
```rust
async fn pull_latest_messages_from_channel(
    channel: ChannelId,
    cache_and_http: &Arc<CacheAndHttp>,
) -> anyhow::Result<Vec<Message>> {
    let mut messages = vec![];

    let mut iter = channel.messages_iter(&cache_and_http.http).boxed();

    while let Some(message_result) = iter.next().await {
        messages.push(message_result?);

        println!(
            "Pulling... ({}) - {}",
            messages.len(),
            messages.last().unwrap().timestamp
        );
    }

    Ok(messages)
}
```

I let that run as well and ran into the same error:
```
...
Pulling... (60498) - 2020-10-07 23:07:52.918 UTC
Pulling... (60499) - 2020-10-07 23:07:08.521 UTC
Pulling... (60500) - 2020-10-07 23:06:17.353 UTC
Error: Error while sending HTTP request.

Caused by:
    0: Error while sending HTTP request.
    1: error decoding response body: invalid type: string "477175586805252107", expected u64 at line 1 column 22631
    2: invalid type: string "477175586805252107", expected u64 at line 1 column 22631
```

It was suggested I manually try to get that message from the endpoint:
```
curl --location --request GET 'https://discordapp.com/api/channels/724685783503470634/messages/477175586805252107' \
--header 'Authorization: Bot <TOKEN>'
```

This however resulted in `{"message": "Unknown Message", "code": 10008}`.

I thought, if I can't access it directly maybe I can query the previous or following message. Using `messages?after=477175586805252107&limit=1` returns the first message in the channel, weirdly enough. Using `messages?before=477175586805252107&limit=1` yields an empty array.

I'm at my limits on what this could be but it makes iterating and pulling all messages from a channel practically impossible unless you catch that specific error.


I'm available in Discord if further testing is required.

This same root cause must be fixed before merging.
REVIEW_EOF
