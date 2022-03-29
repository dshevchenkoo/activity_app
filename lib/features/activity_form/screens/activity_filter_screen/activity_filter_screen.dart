import 'package:activity_app/assets/colors/colors.dart';
import 'package:activity_app/assets/themes/text_style.dart';
import 'package:activity_app/features/activity_form/screens/activity_filter_screen/activity_filter_screen_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Main widget for ActivityFilterScreen module
class ActivityFilterScreen
    extends ElementaryWidget<IActivityFilterScreenWidgetModel> {
  /// Create an instance [ActivityFilterScreen].
  const ActivityFilterScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultActivityFilterScreenModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IActivityFilterScreenWidgetModel wm) {
    return GestureDetector(
      onTap: () => wm.unfocus(),
      child: Scaffold(
        backgroundColor: textColorGrey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Создать новую активность',
                      style: textBold.copyWith(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: wm.onChangedActivityCategory,
                            style: const TextStyle(color: white),
                            controller: wm.activityCategoryTextController,
                            decoration: InputDecoration(
                              label: const Text(
                                'Категория активности',
                                style: TextStyle(
                                  color: textColorSecondary,
                                ),
                              ),
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: textColorSecondary,
                                ),
                                onPressed: wm.showActivityCategoryDialog,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Tooltip(
                          triggerMode: TooltipTriggerMode.tap,
                          message: wm.activityTooltip,
                          child: const Icon(
                            Icons.info_outline,
                            color: textColorSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Уровень доступности',
                      style: textRegular,
                    ),
                    EntityStateNotifierBuilder<double>(
                      listenableEntityState: wm.accessibilityState,
                      builder: (_, state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Slider(
                            value: state ?? 0,
                            onChanged: wm.onChangedAccessibility,
                          ),
                          Text(
                            '${wm.accessibilityPercent}%',
                            style: textRegular,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Количество участников',
                      style: textRegular,
                    ),
                    EntityStateNotifierBuilder<int>(
                      listenableEntityState: wm.participantsState,
                      builder: (_, state) => Row(
                        children: [
                          IconButton(
                            onPressed: wm.onRemoveParticipant,
                            icon: const Icon(
                              Icons.remove,
                              // color: primaryColor,
                            ),
                            color: primaryColor,
                            disabledColor: textColorSecondary,
                          ),
                          Text(
                            state.toString(),
                            style: textRegular,
                          ),
                          IconButton(
                            onPressed: wm.onAddParticipant,
                            icon: const Icon(
                              Icons.add,
                            ),
                            color: primaryColor,
                            disabledColor: textColorSecondary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Стоимость вложенийм',
                      style: textRegular,
                    ),
                    TripleSourceBuilder<EntityState<double>, EntityState<int>,
                        EntityState<double>>(
                      firstSource: wm.priceState,
                      secondSource: wm.dollarsCountState,
                      thirdSource: wm.dollarsSizeState,
                      builder: (_, price, dollarsCount, dollarsSize) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Slider(
                            value: price!.data!,
                            onChanged: wm.onChangedPrice,
                          ),
                          Text(
                            "\$" * dollarsCount!.data!,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: dollarsSize?.data,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: EntityStateNotifierBuilder<String>(
                    listenableEntityState: wm.activityCategoryState,
                    builder: (_, state) {
                      return ElevatedButton(
                        onPressed: wm.next,
                        child: Text('Далее'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
