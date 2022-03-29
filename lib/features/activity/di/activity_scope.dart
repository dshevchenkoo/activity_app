import 'package:activity_app/features/activity/data/repository/activity_repository_impl.dart';
import 'package:activity_app/features/activity/data/storage/remote/activity_remote_storage.dart';
import 'package:activity_app/features/activity/domain/repository/activity_repository.dart';
import 'package:activity_app/features/activity/domain/storage/activity_storage.dart';
import 'package:activity_app/features/activity/domain/usecase/fetch_activity.dart';
import 'package:dio/dio.dart';

/// Scope of dependencies which need through activity form life.
class ActivityScope implements IActivityScope {
  final Dio dio;
  ActivityScope(this.dio);

  @override
  FetchActivity get fetchActivity => FetchActivity(_activityCategoryRepository);

  ActivityRepository get _activityCategoryRepository =>
      ActivityRepositoryImpl(_activityStorage);

  ActivityStorage get _activityStorage => ActivityRemoteStorage(dio: dio);
}

/// ActivityForm dependencies.
abstract class IActivityScope {
  /// usecase for get activity category.
  FetchActivity get fetchActivity;
}
