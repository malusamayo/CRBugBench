# Code Review Task

You are a maintainer reviewing a pull request to the `jenkinsci/jenkins` repository.

**PR title:** Rewrite the build history widget (#9148)

**PR description / commit message:**

Rewrite the build history widget (#9148)

* Squashed commit of the following:

commit 1ce4cb39c7df313ad000225f1f06c21d9d55d7d8
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Tue Apr 9 09:22:36 2024 +0100

    Rename classes

commit 107d7947874a974fc16df00dcdef46a4d55ed0bc
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Tue Apr 9 08:59:54 2024 +0100

    Update HistoryWidget.java

commit 13575bc27caaf902c6685e8dfdb8ecd2ffc6e64a
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Tue Apr 9 08:59:29 2024 +0100

    Hide buttons

commit e5de5465814c810f9bb09722a00727f73b1158b9
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Tue Apr 9 08:39:04 2024 +0100

    Rename classes

commit 47c84afcd1c4e45f1e202a1a38fc68ef9ec8c702
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 23:21:36 2024 +0100

    Add animation

commit e7432b693357b800b91bf355a610fbd3ab62223e
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 23:03:19 2024 +0100

    Add navigation buttons

commit 448a09419a0706bd83fb73b555ef55c54916da13
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 22:29:32 2024 +0100

    Update _dashboard.scss

commit bb85734be0884e7cb244b13267970722db2f8c05
Merge: c451a7223c 27433f19f3
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 22:23:38 2024 +0100

    Merge branch 'master' into new-build-history-2

commit c451a7223cfc68651d11c8f83134c0ee000db363
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 13:17:05 2024 +0100

    Update _job.scss

commit 960b162dcd95715f6d1567f57d53fcf79591966d
Merge: d020eb66e5 af655e3fdc
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 13:16:54 2024 +0100

    Merge branch 'remove-table-usage' into new-build-history-2

commit af655e3fdce9d0aeb7d741a143777effffbd779f
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 13:13:38 2024 +0100

    Init

commit d020eb66e54a63c880dc3c335485aff92c86aaad
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 13:09:57 2024 +0100

    Update card.jelly

commit 81bc1d45f17adb021d67c15531d51b8421f78132
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 13:07:41 2024 +0100

    Update _buttons.scss

commit 4023460b9aa9243f45870e98ca2299a91263bcce
Merge: 875fb8fb4b da5f593fb0
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Apr 8 13:03:18 2024 +0100

    Merge branch 'master' into new-build-history-2

commit 875fb8fb4baa86c45284d71ee6f5a2a39af68aa0
Merge: 2dc9964871 fe60facf91
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Apr 6 19:29:20 2024 +0100

    Merge branch 'master' into new-build-history-2

commit 2dc9964871734a6e8386392d32a13366bc3752e9
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Apr 5 22:17:08 2024 +0100

    Reset files

commit 2da1e14f046e518bc9c22050ddf9f394d65bbc31
Merge: dce466a846 b9fac75ac8
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Apr 5 22:14:46 2024 +0100

    Merge branch 'master' into new-build-history-2

commit dce466a846b5e7bcad40625c8c5bcbd6c6477cf8
Merge: 935c16e1c1 0eed048866
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Wed Feb 28 13:55:35 2024 +0000

    Merge branch 'master' into new-build-history-2

commit 935c16e1c1033c8e33fff49b0e47f9a47615f540
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Feb 18 17:54:32 2024 +0000

    Update entry.jelly

commit 2a19a045970d65e446e4ce894d769fb27bdfd921
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Feb 18 17:51:58 2024 +0000

    Rename classes

commit 3ef46abe52ba75573bb4e634ad3baad95c2b07ba
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Feb 18 17:29:25 2024 +0000

    Update index.jelly

commit da0b2126cdc5f959905ae7eba514a68f891f6620
Merge: 281fac04c0 9d9e2ab467
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Feb 18 17:27:12 2024 +0000

    Merge branch 'revamp-dropdowns' into new-build-history-2

commit 281fac04c00e25ab05ff21c71ab30b263d0e3b9b
Merge: 9c69bd02be a6423541f0
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Feb 18 17:19:14 2024 +0000

    Merge branch 'master' into new-build-history-2

commit 9d9e2ab4673136cb41f1cd948676fe2aaf8b0c52
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Feb 10 19:39:24 2024 +0000

    Update templates.js

commit 1c19e431cee21bcbd43bfc1d5d675556dc9c5a4c
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Feb 10 19:38:13 2024 +0000

    Add clazz

commit 8b944e9e3fe9369af00621c20a14d9d527cac12f
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Feb 10 15:19:30 2024 +0000

    Update utils.js

commit 069fefbe36edca7203d3215bdd3d76868d9402fd
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Feb 10 13:23:16 2024 +0000

    Linting

commit 72707122491b727296200ad9111f15f29ed826d2
Merge: 9865811d38 a6423541f0
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Feb 10 12:20:02 2024 +0000

    Merge branch 'master' into revamp-dropdowns

commit 9865811d3879c0f3450285303e70d8349d49aced
Merge: 1e22c34016 86d39dd23b
Author: Mark Waite <mark.earl.waite@gmail.com>
Date:   Thu Jan 18 05:39:13 2024 -0700

    Merge branch 'master' into revamp-dropdowns

commit 9c69bd02bebcc13b695f112952a0ec97b297a8bb
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Jan 14 13:56:49 2024 +0000

    Push

commit 347e966aebbe013f171329c4fb00dee4acd27b33
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Jan 14 13:53:52 2024 +0000

    Update filter-build-history.js

commit 0b4a5dd5f4834824d70324b0698f9194a2ffb64b
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Jan 14 13:49:54 2024 +0000

    Renam

commit a8277bf932fc3ff5c99ec9f3496c05ed977e7990
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Jan 14 13:46:53 2024 +0000

    Fix

commit 855bf1317e8d7187cf4b2016f8571379c841ba91
Merge: 61b0a87e6c 1eb29a8792
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Jan 14 13:38:51 2024 +0000

    Merge branch 'master' into new-build-history-2

commit 1e22c340167b851096e40bce0f3601e075ec0db5
Merge: 44981c2a66 48661db9d1
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Jan 14 13:33:14 2024 +0000

    Merge branch 'master' into revamp-dropdowns

commit 44981c2a6654374500781996e2215736878f9109
Merge: 0075375c9a 1eb29a8792
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Jan 8 21:14:51 2024 +0000

    Merge branch 'master' into revamp-dropdowns

commit 0075375c9a82ac6f80e60eeb9d72e5c03a4e2f4f
Merge: 2dd9e32fab 78cdaa9f29
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Jan 4 13:26:24 2024 +0000

    Merge branch 'master' into revamp-dropdowns

commit 2dd9e32fab3b699e5cd5130b0a37df02cf4e28de
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Jan 4 13:24:53 2024 +0000

    Remove translations

commit 6800c8886a064faa7d23b7e77f759a74ce7f4075
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Jan 4 13:16:19 2024 +0000

    Update header.jelly

commit 1c3961bb64ade88f1c327d48e100611c951bd1f7
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Jan 4 13:15:49 2024 +0000

    Add additional docs

commit 163be529e7dc8c83a8796b8b782eb96ed6444366
Merge: 4cc43e47f9 444f2de993
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Wed Jan 3 21:22:20 2024 +0000

    Merge branch 'master' into revamp-dropdowns

commit 61b0a87e6c3412496e65269e20055d6123d9adb8
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 14 19:38:45 2023 +0000

    More

commit dcd6aaa54576bd1524d071b4cbe75d51aa4244f8
Merge: 0c40b9f3fc edce488000
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 14 19:38:25 2023 +0000

    Merge branch 'stop-button' into new-build-history-2

commit edce4880007e6863f283e8cdebd42fbfa6edb734
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 14 16:06:00 2023 +0000

    Tidy up

commit 157ba0b5bc9369317a393d1d6279752d3fa4cf59
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 14 16:04:46 2023 +0000

    Fix i18n

commit a112bd90c16449ec3a82bf9ca0d64e51913950e5
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Wed Dec 13 22:57:17 2023 +0000

    Update _buttons.scss

commit 91751cf650143442c71f11f10092545dd1753cb0
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Wed Dec 13 22:39:18 2023 +0000

    Update executors.jelly

commit cd89aeabf45e530ab947bfda4e44e8e41945292d
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Wed Dec 13 22:31:06 2023 +0000

    Fixes

commit 1384091663fcd4ba5d584f152dd20c7ea95b5c9b
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Wed Dec 13 22:28:54 2023 +0000

    Init

commit 0c40b9f3fcb4f12fba2f0e0d45bffd94bb1e196b
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Wed Dec 13 16:50:53 2023 +0000

    Update _buttons.scss

commit 50fe8fc74312296ba6ae1b4a43f6a67680846970
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Wed Dec 13 13:13:10 2023 +0000

    add view transitions

commit d1fd7a9a93b241e93b18ed97af696bd32997d8b7
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Tue Dec 12 20:25:44 2023 +0000

    Tidy up

commit 512b9a1baaa8482aa597785a92e6183316f60030
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Tue Dec 12 19:29:16 2023 +0000

    Push

commit 4f1569079c353c0eddd5f665867d4239a35d8797
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Dec 11 23:30:09 2023 +0000

    push

commit ad75b0f10f5afae5b61e2ac97d44b51ede5801a4
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Dec 11 23:24:11 2023 +0000

    Update _buttons.scss

commit cec222e3bdd9104095abfaa82f07e953fa69d097
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Dec 11 23:23:52 2023 +0000

    Update _buttons.scss

commit 4cc43e47f94abd36690f666ec6d2737ddf7d1ba9
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Dec 10 16:04:28 2023 +0000

    Add docs

commit a4c7f4f28cbced0f89af992095e19cdfcb9cd981
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Dec 10 16:00:23 2023 +0000

    Update taglib

commit c01db44de32a02e9c2ec87807eb82fd575ae52e2
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Dec 10 15:56:50 2023 +0000

    Init

commit 21bb3f4262cf65d30c48b76dc43b16a424d357ca
Merge: d3e2920434 428d0e560a
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Dec 10 13:22:00 2023 +0000

    Merge branch 'restyle-cards' into new-build-history-2

commit 428d0e560afcb2096a914debf21fcaba099a7ed8
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 7 20:17:10 2023 +0000

    Lower weight

commit ac5c255530fbda6fb0143f0e3009948685ae1bf8
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 7 20:15:28 2023 +0000

    Remove more bold weights

commit 2922a690bb3889faa2c95574181a47ffbb8e999d
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 7 20:11:33 2023 +0000

    Update _style.scss

commit 9657d460acfbd9e1f70ec7bec66817717d264d6c
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 7 20:06:16 2023 +0000

    Init

commit d3e2920434d44a45e968392c7617ad1ba140a062
Merge: a2bd9a08b2 cabc8f67b9
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Thu Dec 7 19:50:43 2023 +0000

    Merge branch 'master' into new-build-history-2

commit a2bd9a08b2679cc706f89cd12908197bf0244b13
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sun Nov 26 11:58:22 2023 +0000

    Fixes

commit 7cda5049b75bc7e7d7dcc8516ac6b3983d17b3b0
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 12:28:04 2023 +0000

    Working build

commit abd994ebe9680f846e13029faa44a2119c861345
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 11:58:42 2023 +0000

    Working build

commit 9b6defbf444b35127a81bb4cfd298f7648704e49
Merge: 29fcb64a74 7a0e57e35c
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 11:51:24 2023 +0000

    Merge branch 'progress-bar-new' into new-build-history-2

commit 29fcb64a74e37b445cde8b1847a6be988ad3b85c
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 11:51:10 2023 +0000

    More

commit 2f946d3f6494223351fc9da3a98654b9a666f766
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 09:17:06 2023 +0000

    Update _buttons.scss

commit f5474b33429ff8615c74e7be0cf622904c177a65
Merge: 00c3879a27 982bc48fa0
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 09:16:14 2023 +0000

    Merge branch 'use-symbols-for-build-status-new' into new-build-history-2

commit 982bc48fa0595221fac29f597090733b33be036a
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 09:15:56 2023 +0000

    Fix app bar build status icon being incorrect

commit 00c3879a2740e40d81d65463028c82f32782fecf
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 09:12:10 2023 +0000

    Fixes

commit a4960e9f2c9b9c17ec6f85fd24ef98ca7362455e
Merge: d28aada2e1 c6f5db0be7
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 08:56:01 2023 +0000

    Merge branch 'use-symbols-for-build-status-new' into new-build-history-2

commit d28aada2e1d5434a542d95afadc4c582a691319a
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 08:55:18 2023 +0000

    Update _buttons.scss

commit 1d24a19982838f50a6aa6b4510c0fe1090eef364
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Sat Nov 25 08:52:58 2023 +0000

    Init

commit 7a0e57e35c71073258a5635ebba1a87d5456aeda
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Nov 24 21:19:23 2023 +0000

    More

commit 67d4264da9a9ff8539ea74f7462b111d7da46f82
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Nov 24 21:17:09 2023 +0000

    Update _spinner.scss

commit 9befc76209eede89b3e3fd9d124c6ac92ee75c81
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Nov 24 21:07:55 2023 +0000

    Update _spinner.scss

commit 528b46acb3be57f43cf18f09a46cd7caa4ba2120
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Nov 24 21:01:06 2023 +0000

    More

commit ea0c4878137141193ece81a1970007f34e603478
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Nov 24 20:36:53 2023 +0000

    Init

commit c6f5db0be74d9cf4ff979c19294349cf3a5ee590
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Nov 24 17:52:28 2023 +0000

    Fix icon position

commit 18a84076b5bae7969e6ce9af37dc69bc34b17277
Merge: aea4d9786e a9c34d7393
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Nov 24 09:58:54 2023 +0000

    Merge branch 'master' into use-symbols-for-build-status-new

commit aea4d9786eb4f059c0c37a204361c4ff1d8c6a67
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Fri Nov 24 09:58:29 2023 +0000

    Rename ID

commit 5f76f3840c2fe61d3937f947df0bdca293832fb7
Author: Jan Faracik <43062514+janfaracik@users.noreply.github.com>
Date:   Mon Nov 20 16:00:14 2023 +0000

    Init

* Update _job.scss

* Lint

* Update filter-build-history.js

* Hide controls if not navigable

* Update RunTest.java

* Add basic JSDoc

* Use dataset rather than attributes

* Update filter-build-history.js

* Rename JS

* Update RunTest.java

* Update jenkins-test-harness version (thanks again Tim!)

* Update _job.scss

* Remove unused SCSS

* Update AbstractScmTagActionTest.java

* Update builds-card.js

* Update builds-card.js

* Rewrite SCSS/Jelly to handle more complex scenarios

* Lint

* Tidy up

* Update _side-panel-widgets.scss

* Add background to card

* Fix lint

* Update queue-items.jelly

* Fix cancel button

* Update queue-items.jelly

* Use debounce properly and adjust time to make it smoother

* Use jenkins-hidden

* Replace TODOs with comments, fix card controls showing when there are no builds

* Add hidden text for previous/next buttons

* Update builds-card.js

* Add data-tooltip-append-to-parent="true" to tooltips

* Wrap badges

* Fix relative expandable link

* Use chevron-down rather than menu icon

---------

Co-authored-by: Daniel Beck <1831569+daniel-beck@users.noreply.github.com>
Co-authored-by: Tim Jacomb <21194782+timja@users.noreply.github.com>
Co-authored-by: Tim Jacomb <timjacomb1@gmail.com>

## Working environment

The repository is checked out at `/app/jenkins` at this PR's **base commit**
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
