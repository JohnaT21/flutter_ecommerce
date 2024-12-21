import 'package:ecommerce/src/presentation/localization/bloc/localization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants.dart';

class LanguageSelector extends StatefulWidget {
  final List<String> languages;

  const LanguageSelector({super.key, required this.languages});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('am', 'ET')
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        if (state is LocalizationLoaded) {
          return ListView.builder(
            itemCount: widget.languages.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: SizedBox(
                  width: 1.sw,
                  height: 85.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: kBaseColor,
                      border: Border.all(
                        width: 1.0,
                        color: kGreyColor.withOpacity(0.25),
                      ),
                      boxShadow: supportedLocales[index] == state.locale
                          ? [
                              const BoxShadow(
                                color: kShadowColor,
                                spreadRadius: 1.5,
                                blurRadius: 11,
                              ),
                            ]
                          : [],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.languages[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: supportedLocales[index] == state.locale
                                      ? kPrimaryColor
                                      : kDarkTextColor,
                                  letterSpacing: 0.34,
                                ),
                          ),
                          Radio<Locale>(
                            value: supportedLocales[index],
                            activeColor: kPrimaryColor,
                            groupValue: state.locale,
                            onChanged: (value) {
                              BlocProvider.of<LocalizationBloc>(context)
                                  .add(ChangeLocale(locale: value!));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
