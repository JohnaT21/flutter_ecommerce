import 'package:ecommerce/src/presentation/sell/bloc/option/option_values_bloc.dart';
import 'package:ecommerce/src/presentation/sell/pages/values_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../config/constants.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../domain/entities/product_category.dart';
import '../../shared_widgets/rounded_card.dart';

class OptionsPaage extends StatefulWidget {
  static const String routeName = "/options_page";
  final List<OptionElement> args;
  const OptionsPaage({super.key, required this.args});

  @override
  State<OptionsPaage> createState() => _OptionsPaageState();
}

class _OptionsPaageState extends State<OptionsPaage> {
  TextEditingController? fNameController;

  final Map<String, TextEditingController> _controllerMap = {};

  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    for (var element in widget.args) {
      if (element.values.isEmpty) {
        _controllerMap[element.name] = TextEditingController();
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  void dispose() {
    _controllerMap.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final OptionValuesBloc opBloc = BlocProvider.of<OptionValuesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBaseColor,
        title:
            const Text("Options Page", style: TextStyle(color: kDarkTextColor)),
        actions: [
          BlocBuilder<OptionValuesBloc, OptionValuesState>(
            builder: (context, state) {
              return state.options.isNotEmpty
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save"))
                  : const SizedBox();
            },
          ),
        ],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: kDarkTextColor)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 12, left: 12, bottom: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: ListView(
                        children: widget.args
                            .map(
                              (e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: e.values.isNotEmpty
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, ValuesPage.routeName,
                                                arguments: e.values);
                                          },
                                          child: AnimatedContainer(
                                            height: 55,
                                            width: screenWidth,
                                            curve: Curves.easeInOut,
                                            duration: Duration(
                                                milliseconds: 300 +
                                                    (widget.args.indexOf(e) *
                                                        200)),
                                            transform:
                                                Matrix4.translationValues(
                                                    startAnimation
                                                        ? 0
                                                        : screenWidth,
                                                    0,
                                                    0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: kGreyBorderColor,
                                                  width: 1,
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Text(e.name),
                                                trailing: const Icon(
                                                  Icons
                                                      .keyboard_arrow_right_rounded,
                                                  color: kTertiaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                  // optiontextForms(e,
                                  // controller: _controllerMap[e.name]!,
                                  // onchange: (val) {
                                  //                opBloc.add(RemoveOptionValueEvent(
                                  //     option: ad.Option(
                                  //         id: ,
                                  //         values: [_controllerMap[e.name]!.text])));
                                  // opBloc.add(ChangeOptionValueEvent(
                                  //     option: ad.Option(
                                  //         id: selectedElement!.option,
                                  //         values: [selectedElement!.id])));
                                  // }
                                  // )
                                  ),
                            )
                            .toList()),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BlocBuilder<OptionValuesBloc, OptionValuesState>(
                      builder: (context, state) {
                        Logger().d(state.options);
                        List<String> values = [];
                        for (var element in state.options) {
                          values.addAll(element.values);
                        }
                        for (var element in values) {
                          Logger().d(element);
                        }
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: RoundedCard(
                            color: const Color.fromARGB(255, 225, 243, 252),
                            child: Column(
                              children: [
                                Text(
                                  getTranslation(context, "Selected Options"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                state.options.isNotEmpty
                                    ? Center(
                                        child: SizedBox(
                                          height: 70.h,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width
                                              .w,
                                          child: ListView(
                                              children: state.options
                                                  .map(
                                                    (e) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Text(widget.args
                                                          .firstWhere(
                                                              (element) =>
                                                                  e.id ==
                                                                  element
                                                                      .optionId)
                                                          .name),
                                                    ),
                                                  )
                                                  .toList()),
                                        ),
                                      )
                                    : Text(getTranslation(
                                        context, "no options added yet")),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField optiontextForms(OptionElement e,
      {required TextEditingController controller,
      required Null Function(dynamic val) onchange}) {
    return TextFormField(
      controller: controller,
      onChanged: onchange,
      decoration: InputDecoration(
          label: Text(e.name),
          hintText: "${getTranslation(context, "Please add")} ${e.name}"),
    );
  }
}
