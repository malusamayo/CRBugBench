#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `MediaBrowser.Providers/Plugins/MusicBrainz/AlbumProvider.cs`:

This pull request introduces the defect later reported as "Unstable: ProviderManager - FormatException: Am seeing this repeatedly in the logs.". The
problem a user observed, and its root cause:

```
[2020-08-25 10:08:18.509 +01:00] [ERR] [58] MediaBrowser.Providers.Manager.ProviderManager: "TmdbImageProvider" failed in GetImageInfos for type "Movie" at "D:\Films\Transformers Collection\Transformers (2007)\Transformers (2007).avi"
System.FormatException: The format of value 'Jellyfin-Server/10.7.0' is invalid.
   at System.Net.Http.Headers.HeaderUtilities.CheckValidComment(String value, String parameterName)
   at System.Net.Http.Headers.ProductInfoHeaderValue..ctor(String comment)
   at MediaBrowser.Providers.Plugins.Tmdb.Movies.TmdbMovieProvider.GetMovieDbResponse(HttpRequestMessage message) in C:\code\jellyfin\MediaBrowser.Providers\Plugins\Tmdb\Movies\TmdbMovieProvider.cs:line 385
   at MediaBrowser.Providers.Plugins.Tmdb.Movies.TmdbMovieProvider.FetchMainResult(String id, Boolean isTmdbId, String language, CancellationToken cancellationToken) in C:\code\jellyfin\MediaBrowser.Providers\Plugins\Tmdb\Movies\TmdbMovieProvider.cs:line 337
   at MediaBrowser.Providers.Plugins.Tmdb.Movies.TmdbMovieProvider.DownloadMovieInfo(String id, String preferredMetadataLanguage, CancellationToken cancellationToken) in C:\code\jellyfin\MediaBrowser.Providers\Plugins\Tmdb\Movies\TmdbMovieProvider.cs:line 192
   at MediaBrowser.Providers.Plugins.Tmdb.Movies.TmdbImageProvider.FetchImages(BaseItem item, String language, IJsonSerializer jsonSerializer, CancellationToken cancellationToken) in C:\code\jellyfin\MediaBrowser.Providers\Plugins\Tmdb\Movies\TmdbImageProvider.cs:line 186
   at MediaBrowser.Providers.Plugins.Tmdb.Movies.TmdbImageProvider.GetImages(BaseItem item, CancellationToken cancellationToken) in C:\code\jellyfin\MediaBrowser.Providers\Plugins\Tmdb\Movies\TmdbImageProvider.cs:line 60
   at MediaBrowser.Providers.Manager.ProviderManager.GetImages(BaseItem item, IRemoteImageProvider provider, IReadOnlyCollection`1 preferredLanguages, CancellationToken cancellationToken, Nullable`1 type) in C:\code\jellyfin\MediaBrowser.Providers\Manager\ProviderManager.cs:line 264
```

This same root cause must be fixed before merging.
REVIEW_EOF
