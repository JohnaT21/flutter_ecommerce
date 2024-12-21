import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/domain/entities/profile_model.dart';
import 'package:ecommerce/src/presentation/shared_widgets/app_button.dart';
import 'package:ecommerce/src/presentation/shared_widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../config/env.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../core/helpers/snack_bar_service.dart';
import '../bloc/account_bloc.dart';
import '../widgets/select_photo_options_screen.dart';

class EditProfilePage extends StatefulWidget {
  static const String routeName = "/my_account_page";
  final ProfileModel profilModel;
  const EditProfilePage({super.key, required this.profilModel});

  @override
  State<EditProfilePage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<EditProfilePage> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final _myformKey = GlobalKey<FormState>();
  final _myScaffoldkey = GlobalKey<ScaffoldState>();

  bool isFormChanged = false;

  @override
  void initState() {
    super.initState();
    fNameController.text = widget.profilModel.data.firstName;
    lNameController.text = widget.profilModel.data.lastName;
    emailController.text = widget.profilModel.data.email;
  }

  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountBloc = BlocProvider.of<AccountBloc>(context);

    fNameController.selection =
        TextSelection.collapsed(offset: fNameController.text.length);
    lNameController.selection =
        TextSelection.collapsed(offset: lNameController.text.length);
    emailController.selection =
        TextSelection.collapsed(offset: emailController.text.length);

    return Scaffold(
      key: _myScaffoldkey,
      body: Form(
        key: _myformKey,
        autovalidateMode: autovalidateMode,
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is UpdateAccountLoading) {
              Logger().d("Update loading...");
            }
            if (state is UpdateAccountSuccess) {
              accountBloc.add(GetAccountEvent());
              SnackBarService.showSuccessSnackBar(
                  content: "Updated Successfully");
              Navigator.pop(context);
            }
            if (state is UpdateAccountError) {
              SnackBarService.showErrorSnackBar(content: state.msg);
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                DefaultAppBar(
                  title: getTranslation(context, "account_text"),
                  actions: [
                    SizedBox(
                      height: 20.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w, vertical: 8.h),
                        child: state is UpdateAccountLoading
                            ? const SizedBox(
                                child: Center(
                                child: CircularProgressIndicator(),
                              ))
                            : AppButton(
                                backgroundColor: isFormChanged || _image != null
                                    ? kPrimaryColor
                                    : kLightGreyColor,
                                onPressed: isFormChanged || _image != null
                                    ? () {
                                        accountBloc
                                            .add(UpdateAccountEvent(userModel: {
                                          "first_name": fNameController.text,
                                          "last_name": lNameController.text,
                                          "email": emailController.text
                                        }, ppImage: _image?.path));
                                      }
                                    : null,
                                child: Text(
                                  getTranslation(context, "edit_text"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: isFormChanged || _image != null
                                              ? kBaseColor
                                              : kPrimaryColor,
                                          fontFamily: 'roboto'),
                                ),
                              ),
                      ),
                    ),
                  ],
                  hasLeading: true,
                ),
                SliverList(
                  key: const Key("editprofile"),
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: kGreyColor,
                              radius: 72.r,
                              child: _image == null
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(170)),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.profilModel.data
                                                    .imageURL !=
                                                null
                                            ? '$BASE_API_URL_IMAGE${widget.profilModel.data.imageURL!.substring(1)}'
                                            : '',
                                        fit: BoxFit.cover,
                                        width: 145.r,
                                        height: 145.r,
                                        errorWidget: (context, value, data) =>
                                            SizedBox(
                                          width: 100.r,
                                          height: 85.r,
                                          child: const Center(
                                              child: Icon(Icons
                                                  .image_not_supported_outlined)),
                                        ),
                                        placeholder: (context, value) =>
                                            Image.asset(
                                          'assets/images/liyu_logo.png',
                                          fit: BoxFit.cover,
                                          width: 190.r,
                                          height: 85.r,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(170)),
                                      child: Container(
                                        height: 150.r,
                                        width: 150.r,
                                        decoration: const BoxDecoration(
                                            color: Colors.redAccent),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Image(
                                            image: FileImage(_image!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: 20,
                              right: 130,
                              child: GestureDetector(
                                onTap: () {
                                  _showSelectPhotoOptions(context);
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      infoWidget(
                          icon: const Icon(Icons.person_outline),
                          info: getTranslation(context, "first_name_text"),
                          context: context,
                          onchange: (val) {
                            setState(() {
                              isFormChanged = true;
                              fNameController.text = val;
                            });
                            // return val;
                          },
                          controller: fNameController),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.w,
                        ),
                        child: const Divider(
                          color: kDividerColor,
                        ),
                      ),
                      infoWidget(
                          icon: const Icon(Icons.person_outline),
                          info: getTranslation(context, "last_name_text"),
                          context: context,
                          onchange: (val) {
                            setState(() {
                              isFormChanged = true;
                              lNameController.text = val;
                            });
                          },
                          controller: lNameController),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.w,
                        ),
                        child: const Divider(
                          color: kDividerColor,
                        ),
                      ),
                      infoWidget(
                          icon: const Icon(Icons.mail),
                          info: getTranslation(context, "email_text"),
                          context: context,
                          onchange: (val) {
                            setState(() {
                              isFormChanged = true;
                              emailController.text = val;
                            });
                          },
                          controller: emailController),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.w,
                        ),
                        child: const Divider(
                          color: kDividerColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Padding infoWidget(
      {required Icon icon,
      required String info,
      required BuildContext context,
      required TextEditingController controller,
      required Function(dynamic val) onchange}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.h),
      child: Container(
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextFormField(
                onChanged: (val) => onchange(val),
                controller: controller,
                decoration:
                    InputDecoration(labelText: info, border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
