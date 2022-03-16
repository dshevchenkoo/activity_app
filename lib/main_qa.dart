import 'package:activity_app/config/app_config.dart';
import 'package:activity_app/config/debug_options.dart';
import 'package:activity_app/config/environment/build_types.dart';
import 'package:activity_app/config/environment/environment.dart';
import 'package:activity_app/config/urls.dart';
import 'package:activity_app/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.qa,
    config: AppConfig(
      url: Url.testUrl,
      proxyUrl: Url.qaProxyUrl,
      debugOptions: DebugOptions(
        debugShowCheckedModeBanner: true,
      ),
    ),
  );

  run();
}
