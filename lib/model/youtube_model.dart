class YouTubeSearchResult {
  final String kind;
  final String etag;
  final String nextPageToken;
  final String regionCode;
  final PageInfo pageInfo;
  final List<YouTubeVideo> items;

  YouTubeSearchResult({
    required this.kind,
    required this.etag,
    required this.nextPageToken,
    required this.regionCode,
    required this.pageInfo,
    required this.items,
  });

  factory YouTubeSearchResult.fromJson(Map<String, dynamic> json) {
    return YouTubeSearchResult(
      kind: json['kind'],
      etag: json['etag'],
      nextPageToken: json['nextPageToken'],
      regionCode: json['regionCode'],
      pageInfo: PageInfo.fromJson(json['pageInfo']),
      items: (json['items'] as List)
          .map((item) => YouTubeVideo.fromJson(item))
          .toList(),
    );
  }
}

class PageInfo {
  final int totalResults;
  final int resultsPerPage;

  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      totalResults: json['totalResults'],
      resultsPerPage: json['resultsPerPage'],
    );
  }
}

class YouTubeVideo {
  final String kind;
  final String etag;
  final VideoId id;
  final Snippet snippet;

  YouTubeVideo({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    return YouTubeVideo(
      kind: json['kind'],
      etag: json['etag'],
      id: VideoId.fromJson(json['id']),
      snippet: Snippet.fromJson(json['snippet']),
    );
  }
}

class VideoId {
  final String kind;
  final String videoId;

  VideoId({
    required this.kind,
    required this.videoId,
  });

  factory VideoId.fromJson(Map<String, dynamic> json) {
    return VideoId(
      kind: json['kind'],
      videoId: json['videoId'],
    );
  }
}

class Snippet {
  final String publishedAt;
  final String channelId;
  final String title;
  final String description;
  final Thumbnails thumbnails;
  final String channelTitle;
  final String liveBroadcastContent;
  final String publishTime;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.liveBroadcastContent,
    required this.publishTime,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) {
    return Snippet(
      publishedAt: json['publishedAt'],
      channelId: json['channelId'],
      title: json['title'],
      description: json['description'],
      thumbnails: Thumbnails.fromJson(json['thumbnails']),
      channelTitle: json['channelTitle'],
      liveBroadcastContent: json['liveBroadcastContent'],
      publishTime: json['publishTime'],
    );
  }
}

class Thumbnails {
  final ThumbnailData defaultThumbnail;
  final ThumbnailData medium;
  final ThumbnailData high;

  Thumbnails({
    required this.defaultThumbnail,
    required this.medium,
    required this.high,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) {
    return Thumbnails(
      defaultThumbnail: ThumbnailData.fromJson(json['default']),
      medium: ThumbnailData.fromJson(json['medium']),
      high: ThumbnailData.fromJson(json['high']),
    );
  }
}

class ThumbnailData {
  final String url;
  final int width;
  final int height;

  ThumbnailData({
    required this.url,
    required this.width,
    required this.height,
  });

  factory ThumbnailData.fromJson(Map<String, dynamic> json) {
    return ThumbnailData(
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}
