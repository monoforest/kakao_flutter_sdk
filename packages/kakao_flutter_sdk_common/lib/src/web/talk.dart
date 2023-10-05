import 'dart:js_interop';

import 'package:kakao_flutter_sdk_common/src/kakao_sdk.dart';

String androidChannelIntent(String scheme, String channelPublicId, String path,
    {String? queryParameters}) {
  var customScheme = Uri.parse(scheme);

  final query = (queryParameters as JSAny).isNull ? '' : '?$queryParameters';
  final intent = [
    'intent://${customScheme.authority}/$path$query#Intent',
    'scheme=${customScheme.scheme}',
    'end'
  ].join(';');
  return intent;
}

String iosChannelScheme(String scheme, String channelPublicId, String path,
    {String? queryParameters}) {
  var query = queryParameters == null ? '' : '?$queryParameters';
  return '$scheme/$path$query';

  // 'home/$channelPublicId/add
}

Future<String> webChannelUrl(String path) async {
  return Uri(
          scheme: 'https',
          host: KakaoSdk.hosts.pf,
          path: path,
          queryParameters: await _channelBaseParams())
      .toString();
}

Future<Map<String, String>> _channelBaseParams() async {
  return {
    'app_key': KakaoSdk.appKey,
    'kakao_agent': await KakaoSdk.kaHeader,
    'api_ver': '1.0'
  };
}
