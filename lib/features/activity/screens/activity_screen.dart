import 'package:activity_app/assets/colors/colors.dart';
import 'package:activity_app/features/activity/domain/entity/activity.dart';
import 'package:activity_app/features/activity/screens/activity_screen_wm.dart';
import 'package:activity_app/features/activity_form/domain/dto/activity_params_dto.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Main widget for Activity module
class ActivityScreen extends ElementaryWidget<IActivityScreenWidgetModel> {
  final ActivityParamsDto activityParams;

  const ActivityScreen({
    required this.activityParams,
    Key? key,
    WidgetModelFactory wmFactory = defaultActivityWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IActivityScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Новая активность'),
        actions: [
          IconButton(
            onPressed: wm.onUpdatePressed,
            icon: Icon(Icons.update),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20,
          ),
          child: EntityStateNotifierBuilder<List<Activity>>(
            listenableEntityState: wm.activityState,
            loadingBuilder: (_, __) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            builder: (_, state) {
              return SingleChildScrollView(
                child: Column(
                  children: state!
                      .map((activity) => Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff363636),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: SvgPicture.asset(
                                    wm.getSvgPath(activity),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        activity.activity,
                                        style: const TextStyle(
                                          color: white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        activity.type,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (wm.price(activity).length > 0)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color: primaryColor),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  wm.price(activity),
                                                  style: const TextStyle(
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                color: primaryColor,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    wm.members(activity),
                                                    style: const TextStyle(
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .person_outline_outlined,
                                                    color: primaryColor,
                                                    size: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            },
            errorBuilder: (_, e, ___) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    e.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
