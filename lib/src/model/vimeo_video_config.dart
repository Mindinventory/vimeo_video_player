class VimeoVideoConfig {
  VimeoVideoConfig({this.request});

  factory VimeoVideoConfig.fromJson(Map<String, dynamic> json) =>
      VimeoVideoConfig(request: VimeoRequest.fromJson(json["request"]));

  VimeoRequest? request;
}

class VimeoRequest {
  VimeoRequest({this.files});

  factory VimeoRequest.fromJson(Map<String, dynamic> json) =>
      VimeoRequest(files: VimeoFiles.fromJson(json["files"]));

  VimeoFiles? files;
}

class VimeoFiles {
  VimeoFiles({this.progressive});

  factory VimeoFiles.fromJson(Map<String, dynamic> json) {
    final jsonData = json['progressive'] as List<dynamic>;

    final progressiveUrls = List.generate(
      jsonData.length,
      (index) => VimeoProgressive.fromJson(jsonData[index]),
    );

    if (progressiveUrls.isEmpty) {
      final jsonRes = json['hls']['cdns'];

      for (final element in (jsonRes as Map).entries.toList()) {
        progressiveUrls.add(
          VimeoProgressive(
            url: element.value['url'] as String,
          ),
        );
        break;
      }
    }

    return VimeoFiles(
      progressive: progressiveUrls,
    );
  }

  List<VimeoProgressive?>? progressive;
}

class VimeoProgressive {
  VimeoProgressive({
    this.profile,
    this.width,
    this.mime,
    this.fps,
    this.url,
    this.cdn,
    this.quality,
    this.id,
    this.origin,
    this.height,
  });

  factory VimeoProgressive.fromJson(Map<String, dynamic> json) =>
      VimeoProgressive(
        profile: json["profile"],
        width: json["width"],
        mime: json["mime"],
        fps: json["fps"],
        url: json["url"],
        cdn: json["cdn"],
        quality: json["quality"],
        id: json["id"],
        origin: json["origin"],
        height: json["height"],
      );

  dynamic profile;
  dynamic width;
  dynamic mime;
  dynamic fps;
  dynamic url;
  dynamic cdn;
  dynamic quality;
  dynamic id;
  dynamic origin;
  dynamic height;
}
