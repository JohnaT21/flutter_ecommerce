import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../config/constants.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../domain/entities/add_product_model.dart' as ad;
import '../../../domain/entities/product_category.dart';
import '../bloc/option/option_values_bloc.dart';

class ValuesPage extends StatefulWidget {
  static const String routeName = "/values_page";
  const ValuesPage({super.key});

  @override
  State<ValuesPage> createState() => _ValuesPageState();
}

class _ValuesPageState extends State<ValuesPage> {
  List<ad.Option> copy = [];
  List<ad.Option> options = [];
  Values? selectedElement;
  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as List<Values>;
    final OptionValuesBloc opBloc = BlocProvider.of<OptionValuesBloc>(context);
    Logger().d(args);
    return BlocListener<OptionValuesBloc, OptionValuesState>(
      listener: (context, state) {
        Logger().d(state);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBaseColor,
          title: const Text("Option Values",
              style: TextStyle(color: kDarkTextColor)),
          actions: [
            selectedElement == null
                ? const SizedBox()
                : BlocBuilder<OptionValuesBloc, OptionValuesState>(
                    builder: (context, state) {
                      return TextButton(
                          onPressed: () {
                            opBloc.add(RemoveOptionValueEvent(
                                option: ad.Option(
                                    id: selectedElement!.option,
                                    values: [selectedElement!.id])));
                            opBloc.add(ChangeOptionValueEvent(
                                option: ad.Option(
                                    id: selectedElement!.option,
                                    values: [selectedElement!.id])));
                            Navigator.of(context).pop();
                          },
                          child: Text(getTranslation(context, "add_text")));
                    },
                  )
          ],
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios, color: kDarkTextColor)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
              children: args
                  .map(
                    (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            Logger().d(e.toJson());
                            setState(() {
                              selectedElement = e;
                            });
                          },
                          child: AnimatedContainer(
                            height: 55,
                            width: screenWidth,
                            curve: Curves.easeInOut,
                            duration: Duration(
                                milliseconds: 300 + (args.indexOf(e) * 200)),
                            transform: Matrix4.translationValues(
                                startAnimation ? 0 : screenWidth, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: selectedElement == e
                                    ? kPrimaryColor.withOpacity(0.2)
                                    : Colors.white,
                                border: Border.all(
                                  color: kGreyBorderColor,
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                title: Text(e.value),
                              ),
                            ),
                          ),
                        )),
                  )
                  .toList()),
        ),
      ),
    );
  }
}

bool idAddedBefore(List<ad.Option> options, Values? selectedElement) {
  bool isAdded = false;
  for (var element in options) {
    if (element.id == selectedElement!.option) {
      isAdded = true;
      continue;
    }
  }
  return isAdded;
}
