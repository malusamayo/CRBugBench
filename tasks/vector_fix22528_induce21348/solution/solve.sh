#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/topology/running.rs`:

This pull request introduces the defect later reported as "Use of enrichment tables cause panic in 0.45.0.". The
problem a user observed, and its root cause:

### A note for the community

<!-- Please keep this note for the community -->
* Please vote on this issue by adding a 👍 [reaction](https://blog.github.com/2016-03-10-add-reactions-to-pull-requests-issues-and-comments/) to the original issue to help the community and maintainers prioritize this request
* If you are interested in working on this issue or have submitted a pull request, please leave a comment
<!-- Thank you for keeping this note for the community -->

### Problem

After upgrading to `0.45.0`, our vector container has been stuck on a crash loop. After further investigation, it seems like loading any (possibly only geoip) enrichment table will crash the program.

The provided configuration example is a simplification of our production configuration file, providing the smaller configuration in which we've been able to reproduce the issue. If we remove all enrichment tables from our configuration, vector will successfully start. Removing enrichment tables is not an acceptable workaround and thus we have rolled back to `0.44.0`

### Configuration

```text
[api]
enabled = true

[enrichment_tables.geoip-city]
path = "/etc/vector/GeoIP/GeoLite2-City.mmdb"
type = "geoip"

#
# Vector Metrics
#

[sources.internal_metrics]
type = "internal_metrics"

[sinks.prometheus]
type = "prometheus_exporter"
inputs = [ "internal_metrics" ]
address = "0.0.0.0:9598"
default_namespace = "service"
distributions_as_summaries = true

[sources.syslog]
type = "syslog"
address = "0.0.0.0:514"
max_length = 102_400
mode = "udp"

[transforms.modify]
type = "remap"
inputs = ["syslog"]
source = '''
structured = 
  parse_json!(.message)
. = merge!(., structured)
.appname = replace!(.appname, "_", "-")
del(.message)
'''

[transforms.geoip-city]
type = "remap"
inputs = [ "modify" ]
source = '''
geoip_data, err = get_enrichment_table_record("geoip-city",
  {
    "ip": .remote_addr
  }
)
if err != null {
  log("Unable to GeoLocate IP Address (City): " + err, level: "warn")
  .geoip = {}
} else {
  .geoip = merge!(.geoip || {}, geoip_data)
}
'''

# GeoIP Debug
[sinks.debug]
type = "console"
inputs = ["geoip-city"]
  [sinks.debug.encoding]
  codec = "json"
```

### Version

0.45.0

### Debug Output

```text
(...)
2025-02-25T22:29:16.405201Z DEBUG vector::topology::running: Connecting inputs for transform. component=geoip-city
2025-02-25T22:29:16.405208Z DEBUG vector::topology::running: Adding component input to fanout. component=geoip-city fanout_id=modify
2025-02-25T22:29:16.405220Z DEBUG vector::topology::running: Connecting inputs for sink. component=debug
2025-02-25T22:29:16.405224Z DEBUG vector::topology::running: Adding component input to fanout. component=debug fanout_id=geoip-city
2025-02-25T22:29:16.405230Z DEBUG vector::topology::running: Connecting inputs for sink. component=prometheus
2025-02-25T22:29:16.405234Z DEBUG vector::topology::running: Adding component input to fanout. component=prometheus fanout_id=internal_metrics
2025-02-25T22:29:16.405238Z DEBUG vector::topology::running: Connecting inputs for enrichment table sink. component=geoip-city
thread 'main' panicked at src/topology/running.rs:791:58:
called `Option::unwrap()` on a `None` value
stack backtrace:
   0:     0x5d56e2021da0 - <std::sys::backtrace::BacktraceLock::print::DisplayBacktrace as core::fmt::Display>::fmt::h5b6bd5631a6d1f6b
   1:     0x5d56e14501b3 - core::fmt::write::h7550c97b06c86515
   2:     0x5d56e1fdf002 - std::io::Write::write_fmt::h7b09c64fe0be9c84
   3:     0x5d56e2025e12 - std::sys::backtrace::BacktraceLock::print::h2395ccd2c84ba3aa
   4:     0x5d56e2025c74 - std::panicking::default_hook::{{closure}}::he19d4c7230e07961
   5:     0x5d56e2026356 - std::panicking::rust_panic_with_hook::h8942133a8b252070
   6:     0x5d56e2025eb5 - std::panicking::begin_panic_handler::{{closure}}::hb5f5963570096b29
   7:     0x5d56e2025e49 - std::sys::backtrace::__rust_end_short_backtrace::h6208cedc1922feda
   8:     0x5d56e2025e3c - rust_begin_unwind
   9:     0x5d56e0b73bbf - core::panicking::panic_fmt::h0c3082644d1bf418
  10:     0x5d56e0b73c6b - core::panicking::panic::h957f98c65a3b3074
  11:     0x5d56e0b74038 - core::option::unwrap_failed::h098b0d47c83374d6
  12:     0x5d56e4b716ae - vector::topology::running::RunningTopology::setup_inputs::{{closure}}::h5113077975083205
  13:     0x5d56e4b575a1 - vector::topology::running::RunningTopology::connect_diff::{{closure}}::hdfe04c4187373f9b
  14:     0x5d56e4c61360 - vector::topology::running::RunningTopology::start_validated::{{closure}}::h311ff05d5e955ef3
  15:     0x5d56e4c5c9c0 - vector::app::ApplicationConfig::from_opts::{{closure}}::hf987d2435b927f29
  16:     0x5d56e4c4584e - vector::app::Application::prepare_from_opts::h91d0cc87b3176408
  17:     0x5d56e4ae3feb - vector::app::Application::run::h3030700df9a2c025
  18:     0x5d56e0c60671 - vector::main::h9382626f68952a2b
  19:     0x5d56e0c5e993 - std::sys::backtrace::__rust_begin_short_backtrace::h6437f4e4caf590ec
  20:     0x5d56e0c613f3 - main
  21:     0x72c0c2a3924a - <unknown>
  22:     0x72c0c2a39305 - __libc_start_main
  23:     0x5d56e0c5e889 - _start
  24:                0x0 - <unknown>
```

### Example Data

_No response_

### Additional Context

Running `timberio/vector:0.45.0-debian` docker image.

### References

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
