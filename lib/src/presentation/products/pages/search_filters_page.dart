import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/products/widgets/filter_container.dart';
import 'package:ecommerce/src/presentation/shared_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/localization_helper.dart';

class SearchFiltersPage extends StatefulWidget {
  static const routeName = "/search_filters_page";

  SearchFiltersPage({super.key});

  RangeValues currentRangeValues = const RangeValues(500, 1500);
  double max = 10000;

  @override
  State<SearchFiltersPage> createState() => _SearchFiltersPageState();
}

class _SearchFiltersPageState extends State<SearchFiltersPage> {
  List<String> selected = [];
  List<String> selectedColor = [];

  List<String> stars = [
    'unrated',
    '1 star',
    '2 star',
    '3 star',
    '4 star',
    '5 star'
  ];
  List<String> colors = [
    'red',
    'blue',
    'white',
    'black',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyTextColor,
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: kBaseColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0.r),
                  topLeft: Radius.circular(15.0.r),
                ),
              ),
              padding: EdgeInsets.all(16.w),
              height: 540.h,
              child: Column(
                children: [
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(getTranslation(context, "price_range_text"),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  fontSize: 24.sp,
                                  color: kDarkTextColor,
                                  fontFamily: 'roboto'))),
                  RangeSlider(
                    values: widget.currentRangeValues,
                    max: widget.max,
                    divisions: 100,
                    activeColor: kPrimaryColor,
                    labels: RangeLabels(
                      widget.currentRangeValues.start.round().toString(),
                      widget.currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        widget.currentRangeValues = values;
                      });
                    },
                  ),
                  const Divider(
                    color: kGreyTextColor,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      getTranslation(context, "rating_text"),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 24.sp,
                          color: kDarkTextColor,
                          fontFamily: 'roboto'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: GridView.builder(
                        itemCount: stars.length,
                        padding: EdgeInsets.only(top: 12.h),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 1,
                                crossAxisCount: 3,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 20.h,
                            child: filterContainer(
                              index: index,
                              name: stars[index],
                              list: selected,
                              select: () {
                                setState(() {
                                  if (selected.contains(stars[index])) {
                                    selected.remove(stars[index]);
                                  } else {
                                    selected.add(stars[index]);
                                  }
                                });
                              },
                              context: context,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(
                    color: kGreyTextColor,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(getTranslation(context, "color_text"),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 24.sp,
                                color: kDarkTextColor,
                                fontFamily: 'roboto')),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: GridView.builder(
                        itemCount: colors.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2 / 1,
                                crossAxisCount: 4,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                              height: 20.h,
                              child: filterContainer(
                                  index: index,
                                  name: colors[index],
                                  list: selectedColor,
                                  select: () {
                                    setState(() {
                                      if (selectedColor
                                          .contains(colors[index])) {
                                        selectedColor.remove(colors[index]);
                                      } else {
                                        selectedColor.add(colors[index]);
                                      }
                                    });
                                  },
                                  context: context));
                        },
                      ),
                    ),
                  ),
                  AppButton(
                    onPressed: (() {}),
                    child: Text(
                      getTranslation(context, "apply_text"),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 24.sp,
                          color: kBaseColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'roboto'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
