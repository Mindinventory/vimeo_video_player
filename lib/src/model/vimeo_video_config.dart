import 'dart:convert';

VimeoVideoConfig vimeoModelFromJson(String str) =>
    VimeoVideoConfig.fromJson(json.decode(str));

String vimeoModelToJson(VimeoVideoConfig data) => json.encode(data.toJson());

class VimeoVideoConfig {
  VimeoVideoConfig({
    this.request,
    this.video,
  });

  factory VimeoVideoConfig.fromJson(Map<String, dynamic> json) =>
      VimeoVideoConfig(
        request: VimeoRequest.fromJson(json["request"]),
        video: VimeoVideo.fromJson(json["video"]),
      );

  VimeoRequest? request;
  VimeoVideo? video;

  Map<String, dynamic> toJson() => {
        "request": request?.toJson(),
        "video": video?.toJson(),
      };
}

class VimeoEmbed {
  VimeoEmbed({
    this.autopause,
    this.playsinline,
    this.settings,
    this.color,
    this.texttrack,
    this.onSite,
    this.appId,
    this.muted,
    this.dnt,
    this.playerId,
    this.api,
    this.editor,
    this.context,
    this.keyboard,
    this.outro,
    this.transparent,
    this.logPlays,
    this.quality,
    this.time,
    this.loop,
    this.autoplay,
  });

  factory VimeoEmbed.fromJson(Map<String, dynamic> json) => VimeoEmbed(
        autopause: json["autopause"],
        playsinline: json["playsinline"],
        settings: Map.from(json["settings"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        color: json["color"],
        texttrack: json["texttrack"],
        onSite: json["on_site"],
        appId: json["app_id"],
        muted: json["muted"],
        dnt: json["dnt"],
        playerId: json["player_id"],
        api: json["api"],
        editor: json["editor"],
        context: json["context"],
        keyboard: json["keyboard"],
        outro: json["outro"],
        transparent: json["transparent"],
        logPlays: json["log_plays"],
        quality: json["quality"],
        time: json["time"],
        loop: json["loop"],
        autoplay: json["autoplay"],
      );

  int? autopause;
  int? playsinline;
  Map<String, int?>? settings;
  String? color;
  String? texttrack;
  int? onSite;
  String? appId;
  int? muted;
  int? dnt;
  String? playerId;
  dynamic api;
  bool? editor;
  String? context;
  int? keyboard;
  String? outro;
  int? transparent;
  int? logPlays;
  dynamic quality;
  int? time;
  int? loop;
  int? autoplay;

  Map<String, dynamic> toJson() => {
        "autopause": autopause,
        "playsinline": playsinline,
        "settings": settings != null
            ? Map.from(settings!).map((k, v) => MapEntry<String, dynamic>(k, v))
            : null,
        "color": color,
        "texttrack": texttrack,
        "on_site": onSite,
        "app_id": appId,
        "muted": muted,
        "dnt": dnt,
        "player_id": playerId,
        "api": api,
        "editor": editor,
        "context": context,
        "keyboard": keyboard,
        "outro": outro,
        "transparent": transparent,
        "log_plays": logPlays,
        "quality": quality,
        "time": time,
        "loop": loop,
        "autoplay": autoplay,
      };
}

class VimeoRequest {
  VimeoRequest({
    this.files,
    this.lang,
    this.sentry,
    this.thumbPreview,
    this.referrer,
    this.cookieDomain,
    this.timestamp,
    this.gcDebug,
    this.expires,
    this.client,
    this.currency,
    this.session,
    this.cookie,
    this.build,
    this.urls,
    this.signature,
    this.flags,
    this.country,
    this.fileCodecs,
    this.abTests,
  });

  factory VimeoRequest.fromJson(Map<String, dynamic> json) => VimeoRequest(
        files: VimeoFiles.fromJson(json["files"]),
        lang: json["lang"],
        sentry: VimeoSentry.fromJson(json["sentry"]),
        thumbPreview: VimeoThumbPreview.fromJson(json["thumb_preview"]),
        referrer: json["referrer"],
        cookieDomain: json["cookie_domain"],
        timestamp: json["timestamp"],
        gcDebug: VimeoGcDebug.fromJson(json["gc_debug"]),
        expires: json["expires"],
        client: VimeoClient.fromJson(json["client"]),
        currency: json["currency"],
        session: json["session"],
        cookie: VimeoCookie.fromJson(json["cookie"]),
        build: VimeoBuild.fromJson(json["build"]),
        urls: VimeoUrls.fromJson(json["urls"]),
        signature: json["signature"],
        flags: VimeoFlags.fromJson(json["flags"]),
        country: json["country"],
        fileCodecs: VimeoFileCodecs.fromJson(json["file_codecs"]),
        abTests: VimeoAbTests.fromJson(json["ab_tests"]),
      );

  VimeoFiles? files;
  String? lang;
  VimeoSentry? sentry;
  VimeoThumbPreview? thumbPreview;
  dynamic referrer;
  String? cookieDomain;
  int? timestamp;
  VimeoGcDebug? gcDebug;
  int? expires;
  VimeoClient? client;
  String? currency;
  String? session;
  VimeoCookie? cookie;
  VimeoBuild? build;
  VimeoUrls? urls;
  String? signature;
  VimeoFlags? flags;
  String? country;
  VimeoFileCodecs? fileCodecs;
  VimeoAbTests? abTests;

  Map<String, dynamic> toJson() => {
        "files": files?.toJson(),
        "lang": lang,
        "sentry": sentry?.toJson(),
        "thumb_preview": thumbPreview?.toJson(),
        "referrer": referrer,
        "cookie_domain": cookieDomain,
        "timestamp": timestamp,
        "gc_debug": gcDebug?.toJson(),
        "expires": expires,
        "client": client?.toJson(),
        "currency": currency,
        "session": session,
        "cookie": cookie?.toJson(),
        "build": build?.toJson(),
        "urls": urls?.toJson(),
        "signature": signature,
        "flags": flags?.toJson(),
        "country": country,
        "file_codecs": fileCodecs?.toJson(),
        "ab_tests": abTests?.toJson(),
      };
}

class VimeoAbTests {
  VimeoAbTests({
    this.chromecast,
    this.statsFresnel,
    this.llhlsTimeout,
    this.cmcd,
  });

  factory VimeoAbTests.fromJson(Map<String, dynamic> json) => VimeoAbTests(
        chromecast: VimeoChromecast.fromJson(json["chromecast"]),
        statsFresnel: VimeoChromecast.fromJson(json["stats_fresnel"]),
        llhlsTimeout: VimeoChromecast.fromJson(json["llhls_timeout"]),
        cmcd: VimeoChromecast.fromJson(json["cmcd"]),
      );

  VimeoChromecast? chromecast;
  VimeoChromecast? statsFresnel;
  VimeoChromecast? llhlsTimeout;
  VimeoChromecast? cmcd;

  Map<String, dynamic> toJson() => {
        "chromecast": chromecast?.toJson(),
        "stats_fresnel": statsFresnel?.toJson(),
        "llhls_timeout": llhlsTimeout?.toJson(),
        "cmcd": cmcd?.toJson(),
      };
}

class VimeoChromecast {
  VimeoChromecast({
    this.track,
    this.data,
    this.group,
  });

  factory VimeoChromecast.fromJson(Map<String, dynamic> json) =>
      VimeoChromecast(
        track: json["track"],
        data: VimeoData.fromJson(json["data"]),
        group: json["group"],
      );

  bool? track;
  VimeoData? data;
  bool? group;

  Map<String, dynamic> toJson() => {
        "track": track,
        "data": data?.toJson(),
        "group": group,
      };
}

class VimeoData {
  VimeoData();

  factory VimeoData.fromJson(Map<String, dynamic> json) => VimeoData();

  Map<String, dynamic> toJson() => {};
}

class VimeoBuild {
  VimeoBuild({
    this.backend,
    this.js,
  });

  factory VimeoBuild.fromJson(Map<String, dynamic> json) => VimeoBuild(
        backend: json["backend"],
        js: json["js"],
      );

  String? backend;
  String? js;

  Map<String, dynamic> toJson() => {
        "backend": backend,
        "js": js,
      };
}

class VimeoClient {
  VimeoClient({
    this.ip,
  });

  factory VimeoClient.fromJson(Map<String, dynamic> json) => VimeoClient(
        ip: json["ip"],
      );

  String? ip;

  Map<String, dynamic> toJson() => {
        "ip": ip,
      };
}

class VimeoCookie {
  VimeoCookie({
    this.scaling,
    this.volume,
    this.quality,
    this.hd,
    this.captions,
  });

  factory VimeoCookie.fromJson(Map<String, dynamic> json) => VimeoCookie(
        scaling: json["scaling"],
        volume: json["volume"],
        quality: json["quality"],
        hd: json["hd"],
        captions: json["captions"],
      );

  int? scaling;
  double? volume;
  dynamic quality;
  int? hd;
  dynamic captions;

  Map<String, dynamic> toJson() => {
        "scaling": scaling,
        "volume": volume,
        "quality": quality,
        "hd": hd,
        "captions": captions,
      };
}

class VimeoFileCodecs {
  VimeoFileCodecs({
    this.hevc,
    this.av1,
    this.avc,
  });

  factory VimeoFileCodecs.fromJson(Map<String, dynamic> json) =>
      VimeoFileCodecs(
        hevc: VimeoHevc.fromJson(json["hevc"]),
        av1: List<dynamic>.from(json["av1"].map((x) => x)),
        avc: List<int>.from(json["avc"].map((x) => x)),
      );

  VimeoHevc? hevc;
  List<dynamic>? av1;
  List<int?>? avc;

  Map<String, dynamic> toJson() => {
        "hevc": hevc?.toJson(),
        "av1": av1 != null ? List<dynamic>.from(av1!.map((x) => x)) : null,
        "avc": avc != null ? List<dynamic>.from(avc!.map((x) => x)) : null,
      };
}

class VimeoHevc {
  VimeoHevc({
    this.hdr,
    this.sdr,
  });

  factory VimeoHevc.fromJson(Map<String, dynamic> json) => VimeoHevc(
        hdr: List<dynamic>.from(json["hdr"].map((x) => x)),
        sdr: List<dynamic>.from(json["sdr"].map((x) => x)),
      );

  List<dynamic>? hdr;
  List<dynamic>? sdr;

  Map<String, dynamic> toJson() => {
        "hdr": hdr != null ? List<dynamic>.from(hdr!.map((x) => x)) : null,
        "sdr": sdr != null ? List<dynamic>.from(sdr!.map((x) => x)) : null,
      };
}

class VimeoFiles {
  VimeoFiles({
    this.dash,
    this.hls,
    this.progressive,
  });

  factory VimeoFiles.fromJson(Map<String, dynamic> json) => VimeoFiles(
        dash: VimeoDash.fromJson(json["dash"]),
        hls: VimeoHls.fromJson(json["hls"]),
        progressive: List<VimeoProgressive>.from(
            json["progressive"].map((x) => VimeoProgressive.fromJson(x))),
      );

  VimeoDash? dash;
  VimeoHls? hls;
  List<VimeoProgressive?>? progressive;

  Map<String, dynamic> toJson() => {
        "dash": dash?.toJson(),
        "hls": hls?.toJson(),
        "progressive": progressive != null
            ? List<dynamic>.from(progressive!.map((x) => x?.toJson()))
            : null,
      };
}

class VimeoDash {
  VimeoDash({
    this.separateAv,
    this.streams,
    this.cdns,
    this.streamsAvc,
    this.defaultCdn,
  });

  factory VimeoDash.fromJson(Map<String, dynamic> json) => VimeoDash(
        separateAv: json["separate_av"],
        streams: List<VimeoStream>.from(
            json["streams"].map((x) => VimeoStream.fromJson(x))),
        cdns: VimeoCdns.fromJson(json["cdns"]),
        streamsAvc: List<VimeoStream>.from(
            json["streams_avc"].map((x) => VimeoStream.fromJson(x))),
        defaultCdn: json["default_cdn"],
      );

  bool? separateAv;
  List<VimeoStream?>? streams;
  VimeoCdns? cdns;
  List<VimeoStream?>? streamsAvc;
  String? defaultCdn;

  Map<String, dynamic> toJson() => {
        "separate_av": separateAv,
        "streams": streams != null
            ? List<dynamic>.from(streams!.map((x) => x?.toJson()))
            : null,
        "cdns": cdns?.toJson(),
        "streams_avc": streamsAvc != null
            ? List<dynamic>.from(streamsAvc!.map((x) => x?.toJson()))
            : null,
        "default_cdn": defaultCdn,
      };
}

class VimeoCdns {
  VimeoCdns({
    this.akfireInterconnectQuic,
    this.fastlySkyfire,
  });

  factory VimeoCdns.fromJson(Map<String, dynamic> json) => VimeoCdns(
        akfireInterconnectQuic: VimeoAkfireInterconnectQuic.fromJson(
            json["akfire_interconnect_quic"]),
        fastlySkyfire:
            VimeoAkfireInterconnectQuic.fromJson(json["fastly_skyfire"]),
      );

  VimeoAkfireInterconnectQuic? akfireInterconnectQuic;
  VimeoAkfireInterconnectQuic? fastlySkyfire;

  Map<String, dynamic> toJson() => {
        "akfire_interconnect_quic": akfireInterconnectQuic?.toJson(),
        "fastly_skyfire": fastlySkyfire?.toJson(),
      };
}

class VimeoAkfireInterconnectQuic {
  VimeoAkfireInterconnectQuic({
    this.url,
    this.origin,
    this.avcUrl,
  });

  factory VimeoAkfireInterconnectQuic.fromJson(Map<String, dynamic> json) =>
      VimeoAkfireInterconnectQuic(
        url: json["url"],
        origin: json["origin"],
        avcUrl: json["avc_url"],
      );

  String? url;
  String? origin;
  String? avcUrl;

  Map<String, dynamic> toJson() => {
        "url": url,
        "origin": origin,
        "avc_url": avcUrl,
      };
}

class VimeoStream {
  VimeoStream({
    this.profile,
    this.quality,
    this.id,
    this.fps,
  });

  int? profile;
  String? quality;
  int? id;
  int? fps;

  factory VimeoStream.fromJson(Map<String, dynamic> json) => VimeoStream(
        profile: json["profile"],
        quality: json["quality"],
        id: json["id"],
        fps: json["fps"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
        "quality": quality,
        "id": id,
        "fps": fps,
      };
}

class VimeoHls {
  VimeoHls({
    this.separateAv,
    this.defaultCdn,
    this.cdns,
  });

  factory VimeoHls.fromJson(Map<String, dynamic> json) => VimeoHls(
        separateAv: json["separate_av"],
        defaultCdn: json["default_cdn"],
        cdns: VimeoCdns.fromJson(json["cdns"]),
      );

  bool? separateAv;
  String? defaultCdn;
  VimeoCdns? cdns;

  Map<String, dynamic> toJson() => {
        "separate_av": separateAv,
        "default_cdn": defaultCdn,
        "cdns": cdns?.toJson(),
      };
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

  int? profile;
  int? width;
  String? mime;
  int? fps;
  String? url;
  String? cdn;
  String? quality;
  int? id;
  String? origin;
  int? height;

  Map<String, dynamic> toJson() => {
        "profile": profile,
        "width": width,
        "mime": mime,
        "fps": fps,
        "url": url,
        "cdn": cdn,
        "quality": quality,
        "id": id,
        "origin": origin,
        "height": height,
      };
}

class VimeoFlags {
  VimeoFlags({
    this.dnt,
    this.preloadVideo,
    this.plays,
    this.partials,
    this.autohideControls,
  });

  factory VimeoFlags.fromJson(Map<String, dynamic> json) => VimeoFlags(
        dnt: json["dnt"],
        preloadVideo: json["preload_video"],
        plays: json["plays"],
        partials: json["partials"],
        autohideControls: json["autohide_controls"],
      );

  int? dnt;
  String? preloadVideo;
  int? plays;
  int? partials;
  int? autohideControls;

  Map<String, dynamic> toJson() => {
        "dnt": dnt,
        "preload_video": preloadVideo,
        "plays": plays,
        "partials": partials,
        "autohide_controls": autohideControls,
      };
}

class VimeoGcDebug {
  VimeoGcDebug({
    this.bucket,
  });

  factory VimeoGcDebug.fromJson(Map<String, dynamic> json) => VimeoGcDebug(
        bucket: json["bucket"],
      );

  String? bucket;

  Map<String, dynamic> toJson() => {
        "bucket": bucket,
      };
}

class VimeoSentry {
  VimeoSentry({
    this.url,
    this.enabled,
    this.debugEnabled,
    this.debugIntent,
  });

  factory VimeoSentry.fromJson(Map<String, dynamic> json) => VimeoSentry(
        url: json["url"],
        enabled: json["enabled"],
        debugEnabled: json["debug_enabled"],
        debugIntent: json["debug_intent"],
      );

  String? url;
  bool? enabled;
  bool? debugEnabled;
  int? debugIntent;

  Map<String, dynamic> toJson() => {
        "url": url,
        "enabled": enabled,
        "debug_enabled": debugEnabled,
        "debug_intent": debugIntent,
      };
}

class VimeoThumbPreview {
  VimeoThumbPreview({
    this.url,
    this.frameWidth,
    this.height,
    this.width,
    this.frameHeight,
    this.frames,
    this.columns,
  });

  factory VimeoThumbPreview.fromJson(Map<String, dynamic> json) =>
      VimeoThumbPreview(
        url: json["url"],
        frameWidth: json["frame_width"],
        height: json["height"],
        width: json["width"],
        frameHeight: json["frame_height"],
        frames: json["frames"],
        columns: json["columns"],
      );

  String? url;
  int? frameWidth;
  double? height;
  int? width;
  int? frameHeight;
  int? frames;
  int? columns;

  Map<String, dynamic> toJson() => {
        "url": url,
        "frame_width": frameWidth,
        "height": height,
        "width": width,
        "frame_height": frameHeight,
        "frames": frames,
        "columns": columns,
      };
}

class VimeoUrls {
  VimeoUrls({
    this.bareboneJs,
    this.testImp,
    this.jsBase,
    this.fresnel,
    this.js,
    this.proxy,
    this.muxUrl,
    this.fresnelMimirInputsUrl,
    this.fresnelChunkUrl,
    this.threeJs,
    this.vuidJs,
    this.fresnelManifestUrl,
    this.chromelessCss,
    this.playerTelemetryUrl,
    this.chromelessJs,
    this.css,
  });

  factory VimeoUrls.fromJson(Map<String, dynamic> json) => VimeoUrls(
        bareboneJs: json["barebone_js"],
        testImp: json["test_imp"],
        jsBase: json["js_base"],
        fresnel: json["fresnel"],
        js: json["js"],
        proxy: json["proxy"],
        muxUrl: json["mux_url"],
        fresnelMimirInputsUrl: json["fresnel_mimir_inputs_url"],
        fresnelChunkUrl: json["fresnel_chunk_url"],
        threeJs: json["three_js"],
        vuidJs: json["vuid_js"],
        fresnelManifestUrl: json["fresnel_manifest_url"],
        chromelessCss: json["chromeless_css"],
        playerTelemetryUrl: json["player_telemetry_url"],
        chromelessJs: json["chromeless_js"],
        css: json["css"],
      );

  String? bareboneJs;
  String? testImp;
  String? jsBase;
  String? fresnel;
  String? js;
  String? proxy;
  String? muxUrl;
  String? fresnelMimirInputsUrl;
  String? fresnelChunkUrl;
  String? threeJs;
  String? vuidJs;
  String? fresnelManifestUrl;
  String? chromelessCss;
  String? playerTelemetryUrl;
  String? chromelessJs;
  String? css;

  Map<String, dynamic> toJson() => {
        "barebone_js": bareboneJs,
        "test_imp": testImp,
        "js_base": jsBase,
        "fresnel": fresnel,
        "js": js,
        "proxy": proxy,
        "mux_url": muxUrl,
        "fresnel_mimir_inputs_url": fresnelMimirInputsUrl,
        "fresnel_chunk_url": fresnelChunkUrl,
        "three_js": threeJs,
        "vuid_js": vuidJs,
        "fresnel_manifest_url": fresnelManifestUrl,
        "chromeless_css": chromelessCss,
        "player_telemetry_url": playerTelemetryUrl,
        "chromeless_js": chromelessJs,
        "css": css,
      };
}

class VimeoUser {
  VimeoUser({
    this.teamOriginUserId,
    this.liked,
    this.accountType,
    this.vimeoApiClientToken,
    this.vimeoApiInteractionTokens,
    this.teamId,
    this.watchLater,
    this.owner,
    this.id,
    this.mod,
    this.privateModeEnabled,
    this.loggedIn,
  });

  VimeoUser.fromJson(dynamic json) {
    teamOriginUserId = json['team_origin_user_id'];
    liked = json['liked'];
    accountType = json['account_type'];
    vimeoApiClientToken = json['vimeo_api_client_token'];
    vimeoApiInteractionTokens = json['vimeo_api_interaction_tokens'];
    teamId = json['team_id'];
    watchLater = json['watch_later'];
    owner = json['owner'];
    id = json['id'];
    mod = json['mod'];
    privateModeEnabled = json['private_mode_enabled'];
    loggedIn = json['logged_in'];
  }

  int? teamOriginUserId;
  int? liked;
  String? accountType;
  dynamic vimeoApiClientToken;
  dynamic vimeoApiInteractionTokens;
  int? teamId;
  int? watchLater;
  int? owner;
  int? id;
  int? mod;
  int? privateModeEnabled;
  int? loggedIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['team_origin_user_id'] = teamOriginUserId;
    map['liked'] = liked;
    map['account_type'] = accountType;
    map['vimeo_api_client_token'] = vimeoApiClientToken;
    map['vimeo_api_interaction_tokens'] = vimeoApiInteractionTokens;
    map['team_id'] = teamId;
    map['watch_later'] = watchLater;
    map['owner'] = owner;
    map['id'] = id;
    map['mod'] = mod;
    map['private_mode_enabled'] = privateModeEnabled;
    map['logged_in'] = loggedIn;
    return map;
  }
}

class VimeoVideo {
  VimeoVideo({
    this.rating,
    this.version,
    this.height,
    this.duration,
    this.thumbs,
    this.owner,
    this.id,
    this.title,
    this.shareUrl,
    this.width,
    this.embedPermission,
    this.fps,
    this.spatial,
    this.liveEvent,
    this.allowHd,
    this.hd,
    this.lang,
    this.defaultToHd,
    this.url,
    this.privacy,
    this.bypassToken,
    this.unlistedHash,
  });

  VimeoVideo.fromJson(dynamic json) {
    rating =
        json['rating'] != null ? VimeoRating.fromJson(json['rating']) : null;
    version =
        json['version'] != null ? VimeoVersion.fromJson(json['version']) : null;
    height = json['height'];
    duration = json['duration'];
    thumbs =
        json['thumbs'] != null ? VimeoThumbs.fromJson(json['thumbs']) : null;
    owner = json['owner'] != null ? VimeoOwner.fromJson(json['owner']) : null;
    id = json['id'];
    title = json['title'];
    shareUrl = json['share_url'];
    width = json['width'];
    embedPermission = json['embed_permission'];
    fps = json['fps'];
    spatial = json['spatial'];
    liveEvent = json['live_event'];
    allowHd = json['allow_hd'];
    hd = json['hd'];
    lang = json['lang'];
    defaultToHd = json['default_to_hd'];
    url = json['url'];
    privacy = json['privacy'];
    bypassToken = json['bypass_token'];
    unlistedHash = json['unlisted_hash'];
  }

  VimeoRating? rating;
  VimeoVersion? version;
  int? height;
  int? duration;
  VimeoThumbs? thumbs;
  VimeoOwner? owner;
  int? id;
  String? title;
  String? shareUrl;
  int? width;
  String? embedPermission;
  double? fps;
  int? spatial;
  dynamic liveEvent;
  int? allowHd;
  int? hd;
  dynamic lang;
  int? defaultToHd;
  String? url;
  String? privacy;
  String? bypassToken;
  dynamic unlistedHash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rating != null) {
      map['rating'] = rating?.toJson();
    }
    if (version != null) {
      map['version'] = version?.toJson();
    }
    map['height'] = height;
    map['duration'] = duration;
    if (thumbs != null) {
      map['thumbs'] = thumbs?.toJson();
    }
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['id'] = id;
    map['title'] = title;
    map['share_url'] = shareUrl;
    map['width'] = width;
    map['embed_permission'] = embedPermission;
    map['fps'] = fps;
    map['spatial'] = spatial;
    map['live_event'] = liveEvent;
    map['allow_hd'] = allowHd;
    map['hd'] = hd;
    map['lang'] = lang;
    map['default_to_hd'] = defaultToHd;
    map['url'] = url;
    map['privacy'] = privacy;
    map['bypass_token'] = bypassToken;
    map['unlisted_hash'] = unlistedHash;
    return map;
  }
}

class VimeoOwner {
  VimeoOwner({
    this.accountType,
    this.name,
    this.img,
    this.url,
    this.img2x,
    this.id,
  });

  VimeoOwner.fromJson(dynamic json) {
    accountType = json['account_type'];
    name = json['name'];
    img = json['img'];
    url = json['url'];
    img2x = json['img_2x'];
    id = json['id'];
  }

  String? accountType;
  String? name;
  String? img;
  String? url;
  String? img2x;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_type'] = accountType;
    map['name'] = name;
    map['img'] = img;
    map['url'] = url;
    map['img_2x'] = img2x;
    map['id'] = id;
    return map;
  }
}

class VimeoRating {
  VimeoRating({
    this.id,
  });

  VimeoRating.fromJson(dynamic json) {
    id = json['id'];
  }

  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }
}

class VimeoThumbs {
  VimeoThumbs({
    this.base640,
    this.base960,
    this.base,
  });

  VimeoThumbs.fromJson(dynamic json) {
    base640 = json['640'];
    base960 = json['960'];
    base = json['base'];
  }

  String? base640;
  String? base960;
  String? base;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['640'] = base640;
    map['960'] = base960;
    map['base'] = base;
    return map;
  }
}

class VimeoVersion {
  VimeoVersion({
    this.current,
    this.available,
  });

  VimeoVersion.fromJson(dynamic json) {
    current = json['current'];
    available = json['available'];
  }

  dynamic current;
  dynamic available;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current'] = current;
    map['available'] = available;
    return map;
  }
}
