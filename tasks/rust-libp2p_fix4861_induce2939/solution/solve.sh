#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `protocols/mdns/src/behaviour/iface.rs`:

This pull request introduces the defect later reported as "Mdns `InterfaceState` never being called again after returning `Poll::Pending`". The
problem a user observed, and its root cause:

### Summary

When updating to `0.53.0`, we encountered a curious bug with Mdns.

After sending an incorrect Mdns packet, which is dropped (as expected), no packet is ever received by the peer after that, even if it is correct.

### Expected behavior

An incorrect Mdns packet should not stop the polling of an `InterfaceState`.

### Actual behavior

The polling of an `InterfaceState` is stopped after receiving an incorrect Mdns packet.

### Relevant log output

_No response_

### Possible Solution

Members of our team diagnosed the problem and managed to find the solution. It seems a dormant bug was present for a long time in the `poll` implementation of `InterfaceState` but it was only awakened with the merge of #4623. 

https://github.com/libp2p/rust-libp2p/blob/cddc306978a7cca705de5ce10ec5e16e8b732084/protocols/mdns/src/behaviour/iface.rs#L313-L325

As we can see in the above code sample, many `Poll::Ready` are handled and returned as `Poll::Pending`. However, in the [rust documentation,](https://doc.rust-lang.org/stable/std/task/enum.Poll.html#variant.Pending) we can read that "When a function returns Pending, the function *must* also ensure that the current task is scheduled to be awoken when progress can be made". When looking at the current implementation, we can safely say that, when a `Poll::Ready` is caught and converted into a `Poll::Pending`, no scheduling is done to ensure the task will be woken up.

Even if this bug has been present for a long time, it has not caused any problems up until now. Indeed, before the previously mentioned PR, all `InterfaceState` were stored in the `iface_states` `HashMap` and [were polled no matter what their previous returned value was](https://github.com/libp2p/rust-libp2p/pull/4623/files?diff=split&w=0#diff-9ec8c5fcec2242a830ffe46e2c0d7e32186d28ec335f0452af531a9025803b9fL292) (since `poll` was called in a `loop` over each `InterfaceState`). So, even if the `poll` method of `InterfaceState` had not scheduled its own awakening, it would still be called at the next iteration of the `poll` method of the mdns `Behaviour`.

However, now that each `InterfaceState` is `spawned` in its own task, nobody is calling `poll` when it returns `Poll::Pending`. That is why returning a `Poll::Pending` when internally getting a `Poll::Ready` result in the `poll` method of `InterfaceState` never being called again, causing packets to never be handled.

### Version

v0.53.0 (master)

### Would you like to work on fixing this bug ?

Yes

This same root cause must be fixed before merging.
REVIEW_EOF
