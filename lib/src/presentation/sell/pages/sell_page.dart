import 'dart:io';

import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/decorations.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/core/helpers/pop_result.dart';
import 'package:ecommerce/src/core/helpers/snack_bar_service.dart';
import 'package:ecommerce/src/domain/entities/add_product_model.dart' as pm;
import 'package:ecommerce/src/domain/entities/product_category.dart';
import 'package:ecommerce/src/presentation/auth/blocs/auth/auth_bloc_bloc.dart';
import 'package:ecommerce/src/presentation/sell/pages/product_category_page.dart';
import 'package:ecommerce/src/presentation/sell/pages/product_sub_category_page.dart';
import 'package:ecommerce/src/presentation/sell/pages/values_page.dart';
import 'package:ecommerce/src/presentation/shared_widgets/app_button.dart';
import 'package:ecommerce/src/presentation/shared_widgets/dialog_not_logged_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../config/validations.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../presentation/shared_widgets/default_app_bar.dart';
import '../bloc/option/option_values_bloc.dart';
import '../bloc/sell_bloc.dart';
import '../widgets/location_page.dart';
import 'options_page.dart';

class SellPage extends StatefulWidget {
  static const String routeName = "/sell_page";

  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

List<OptionElement> options = [];
Subcategory? subcategoryElement;
Values? values;
String selectedOptionVal = "";

TextEditingController titleController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController priceController = TextEditingController();

class _SellPageState extends State<SellPage> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final _myformKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<pm.Option> optionList = [];

  List<String> nameList = [];
  String? region;
  String? location;

  ///IMAGE RELATED
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList!.addAll(selectedImages);
      });
    }
    if (kDebugMode) {
      print("Image List Length:${imageFileList!.length}");
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sellBloc = BlocProvider.of<SellBloc>(context);
    return BlocBuilder<AuthBloc, AuthBlocState>(builder: (context, state) {
      if (state is AuthenticationAuthenticated || TOKEN != '') {
        return Scaffold(
          key: _scaffoldKey,
          body: CustomScrollView(
            slivers: [
              DefaultAppBar(
                title: getTranslation(context, "sell_text"),
                actions: commonActions(context),
                hasLeading: false,
              ),
              BlocConsumer<SellBloc, SellState>(
                listener: (context, state) {
                  Logger().d(state);
                  if (state is GetProductCategoryLoading) {
                    Logger().d("Loading....");
                  }
                  if (state is AddProductLoading) {
                    Logger().d("Add Product loading....");
                  }
                  if (state is AddProductError) {
                    Logger().d(state);
                    SnackBarService.showErrorSnackBar(content: state.message);
                  }
                  if (state is AddProductSuccess) {
                    Logger().d(state.productId);
                    sellBloc.add(AddProductImageEvent(
                        formData: imageFileList, pId: state.productId));
                  }
                  if (state is GetProductCategorySuccess) {
                    Logger().d(state.productCategory);
                  }
                  if (state is GetProductCategoryError) {
                    SnackBarService.showErrorSnackBar(
                        content:
                            "there is a problem to add a product, please try again");
                  }
                  if (state is AddProductImageSuccess) {
                    SnackBarService.showSuccessSnackBar(
                        content:
                            "Your product is now under review, it may take some minutes to be on live!");
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _myformKey,
                    autovalidateMode: autovalidateMode,
                    child: SliverList(
                      key: const Key("mmmm"),
                      delegate: SliverChildListDelegate.fixed(
                        [
                          SizedBox(height: 24.h),
                          InkWell(
                            onTap: () {
                              selectImages();
                            },
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundColor: kPrimaryColor,
                              child: imageFileList!.isEmpty
                                  ? Icon(
                                      Icons.image_outlined,
                                      color: kBaseColor,
                                      size: 60.r,
                                    )
                                  : Container(
                                      height: 120.r,
                                      width: 120.r,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: kPrimaryColor, width: 2),
                                      ),
                                      child: Image.file(
                                        File(imageFileList![0].path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: imageFileList!
                                      .map(
                                        (e) => Container(
                                          height: 40,
                                          width: 40,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(
                                                color: kPrimaryColor, width: 2),
                                          ),
                                          child: Image.file(
                                            File(imageFileList![
                                                    imageFileList!.indexOf(e)]
                                                .path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          InkWell(
                            onTap: () {
                              selectImages();
                            },
                            child: Text(
                              getTranslation(context, "picture_text"),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 24.w,
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                    onTap: state is GetProductCategorySuccess
                                        ? () {
                                            Navigator.of(context)
                                                .pushNamed(
                                                    ProductCategoryPage
                                                        .routeName,
                                                    arguments:
                                                        state.productCategory)
                                                .then((results) {
                                              if (results is PopWithResults) {
                                                PopWithResults popResult =
                                                    results;
                                                if (popResult.fromPage ==
                                                    ProductSubCategoryPage
                                                        .routeName) {
                                                  setState(() {
                                                    subcategoryElement =
                                                        popResult.results;
                                                    options = popResult
                                                        .results!.options;
                                                  });
                                                } else {}
                                              }
                                            });
                                          }
                                        : null,
                                    child: TextFormField(
                                      decoration: inputDecoration(
                                          subcategoryElement != null
                                              ? subcategoryElement!.name
                                              : getTranslation(
                                                  context, "category_text"),
                                          const Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            color: kTertiaryColor,
                                          ),
                                          enabled: false),
                                    )),
                                SizedBox(height: 16.h),
                                TextFormField(
                                  controller: titleController,
                                  decoration: inputDecoration(
                                      getTranslation(context, "title_text"),
                                      null),
                                ),
                                SizedBox(height: 16.h),
                                TextFormField(
                                  controller: descController,
                                  validator: (val) {
                                    return requiredValidator(val);
                                  },
                                  decoration: inputDecoration(
                                    getTranslation(context, "description_text"),
                                    null,
                                  ),
                                  maxLines: 6,
                                  minLines: 4,
                                ),
                                SizedBox(height: 16.h),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MapPicker(),
                                          )).then((results) {
                                        Logger().d(results);
                                        setState(() {
                                          region = results["region"];
                                          location = results["location"];
                                        });
                                      });
                                    },
                                    child: TextFormField(
                                      controller: locationController,
                                      decoration: inputDecoration(
                                          "${location ?? getTranslation(context, "location_text")}, ${region ?? ""}",
                                          null,
                                          enabled: false),
                                    )),
                                SizedBox(height: 16.h),
                                TextFormField(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  decoration: inputDecoration(
                                      getTranslation(context, "price_text"),
                                      null),
                                  validator: (val) {
                                    return requiredValidator(val);
                                  },
                                ),
                                SizedBox(height: 16.h),
                                subcategoryElement != null &&
                                        subcategoryElement!.options.isNotEmpty
                                    ? InkWell(
                                        onTap: options.isNotEmpty
                                            ? () {
                                                Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OptionsPaage(
                                                                    args:
                                                                        options)))
                                                    .then((results) {
                                                  if (results
                                                      is PopWithResults) {
                                                    PopWithResults popResult =
                                                        results;
                                                    if (popResult.fromPage ==
                                                        ValuesPage.routeName) {
                                                      setState(() {
                                                        values = popResult
                                                            .values![0];
                                                      });
                                                    } else {}
                                                  }
                                                });
                                              }
                                            : null,
                                        child: BlocConsumer<OptionValuesBloc,
                                            OptionValuesState>(
                                          listener: (context, state) {},
                                          builder: (context, state) {
                                            optionList = state.options;
                                            return TextFormField(
                                              decoration: inputDecoration(
                                                  state.options.isNotEmpty
                                                      ? options[0].name
                                                      : getTranslation(
                                                          context, "Options"),
                                                  const Icon(
                                                    Icons
                                                        .keyboard_arrow_right_rounded,
                                                    color: kTertiaryColor,
                                                  ),
                                                  enabled: false),
                                            );
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                                SizedBox(height: 16.h),
                                state is AddProductLoading ||
                                        state is AddProductImageLoading
                                    ? const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: kPrimaryColor,
                                        ),
                                      )
                                    : AppButton(
                                        onPressed: () {
                                          if (imageFileList!.isNotEmpty) {
                                            Logger().d("image");
                                            if (_myformKey.currentState!
                                                .validate()) {
                                              sellBloc.add(
                                                AddProductEvent(
                                                  addProductModel:
                                                      pm.AddProductModel(
                                                          name: titleController
                                                              .text,
                                                          description:
                                                              descController
                                                                  .text,
                                                          price: int.parse(
                                                              priceController
                                                                  .text),
                                                          subcategory:
                                                              subcategoryElement!
                                                                  .id,
                                                          options: optionList,
                                                          region: region!,
                                                          location: location!),
                                                ),
                                              );
                                            } else {
                                              setState(() {
                                                autovalidateMode =
                                                    AutovalidateMode
                                                        .onUserInteraction;
                                              });
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons
                                                            .info_outline_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Text(getTranslation(
                                                            context,
                                                            "Please add images"))),
                                                  ],
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.redAccent,
                                                duration:
                                                    const Duration(seconds: 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          getTranslation(context, "add_text"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontSize: 18.sp,
                                                color: kBaseColor,
                                                letterSpacing: 0.8,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      } else {
        return const DialogNotLoggedIn();
      }
    });
  }
}
