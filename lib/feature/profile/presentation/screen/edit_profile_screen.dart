// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:astronacci/feature/profile/presentation/bloc/profile-bloc/profile_bloc.dart';
import 'package:astronacci/feature/profile/presentation/bloc/update-profile-bloc/update_profile_bloc.dart';
import 'package:astronacci/feature/profile/presentation/cubit/edit-profile-cubit/edit_profile_cubit.dart';
import 'package:astronacci/feature/profile/presentation/cubit/image-cubit/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constanta/constanta_string.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../auth/presentation/cubit/obsecure-cubit/obsecure_cubit.dart';
import '../../data/model/edit_profile_resp_model.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<ObsecureCubit>()),
      BlocProvider(create: (context) => sl<ImageCubit>()),
      BlocProvider(create: ((context) => sl<UpdateProfileBloc>())),
    ], child: const EditProfileContent());
  }
}

class EditProfileContent extends StatefulWidget {
  const EditProfileContent({super.key});

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  final _formKey = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final firstNameCtr = TextEditingController();
  final lastNameCtr = TextEditingController();
  final bornPlaceCtr = TextEditingController();
  final addressCtr = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  bool isDialogOpen = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      context.read<EditProfileCubit>().addBornDate(_dateController.text);
    }
  }

  Future<void> _pickImage() async {
    _requestPermissions();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _getImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _getImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.indigo,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );

      if (croppedFile != null) {
        context.read<EditProfileCubit>().addImage(croppedFile.path);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data = context.read<EditProfileCubit>().state;
    firstNameCtr.text = data.firstName ?? "";
    lastNameCtr.text = data.lastName ?? "";
    bornPlaceCtr.text = data.bornPlace ?? "";
    addressCtr.text = data.address ?? "";
    _dateController.text = data.bornDate ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          if (!isDialogOpen) {
            isDialogOpen = true;
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()),
                  );
                }).then((_) {
              isDialogOpen = false;
            });
          }
        }
        if (state is UpdateProfileSuccess) {
          final snackbar = const SnackBar(
            content: const Text("Update Data Success"),
            duration: const Duration(seconds: 2),
          );
          context.read<ProfileBloc>().add(FetchUserData(state.data));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);
          Navigator.pushNamed(context, RouteConstanta.dashboardScreen);
        }
        if (state is UpdateProfileFailed) {
          final snackbar = SnackBar(
            content: Text(state.msg ?? ""),
            duration: const Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Text(
                      "Edit Profile",
                      style: GoogleFonts.poppins(
                          fontSize: 26.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: _pickImage,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    shape: BoxShape.circle,
                                    image: state.imageUrl != null &&
                                            state.imageUrl!.isNotEmpty
                                        ? DecorationImage(
                                            image: state.imageUrl!
                                                    .contains('http')
                                                ? NetworkImage(state.imageUrl!)
                                                : FileImage(
                                                        File(state.imageUrl!))
                                                    as ImageProvider<Object>,
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: (state.imageUrl == "" ||
                                          state.imageUrl!.isEmpty)
                                      ? const Icon(
                                          Icons.person_2_outlined,
                                          size: 100,
                                          color: Colors.white,
                                        )
                                      : null),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "First Name : ",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: firstNameCtr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First Name!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<EditProfileCubit>().addFirstName(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 4, 5),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.indigo)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.indigo)),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Last Name : ",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: lastNameCtr,
                    onChanged: (value) {
                      context.read<EditProfileCubit>().addLastName(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Last Name!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 4, 5),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.indigo)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.indigo)),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Born Place : ",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: bornPlaceCtr,
                    onChanged: (value) {
                      context.read<EditProfileCubit>().addBornPlace(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Born Place!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 4, 5),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.indigo)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.indigo)),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Born Date : ",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    controller: _dateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter born Date!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(Icons.calendar_month)),
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 4, 5),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Gender : ",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      return DropdownButtonFormField(
                        isExpanded: true,
                        value: state.gender,
                        items: [
                          const DropdownMenuItem(
                            value: 'Male',
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text('Male'),
                            ),
                          ),
                          const DropdownMenuItem(
                            value: 'Female',
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text('Female'),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            context.read<EditProfileCubit>().addGender(value);
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 5, 4, 5),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  const BorderSide(color: Colors.indigo)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  const BorderSide(color: Colors.indigo)),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Address : ",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: addressCtr,
                    maxLines: 3,
                    minLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Address!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<EditProfileCubit>().addAddress(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 4, 5),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.indigo)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.indigo)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 40.0,
                    width: width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0)))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var data = context.read<EditProfileCubit>().state;

                            context.read<UpdateProfileBloc>().add(StartEditData(
                                EditProfileParameterPost(
                                    uid: data.uid,
                                    address: data.address,
                                    bornDate: data.bornDate,
                                    bornPlace: data.bornPlace,
                                    firstName: data.firstName,
                                    gender: data.gender,
                                    lastName: data.lastName,
                                    imageUrl: data.imageUrl,
                                    fileData: File(data.imageUrl ?? ""))));
                          }
                        },
                        child: Text(
                          "Update Data",
                          style: GoogleFonts.poppins(color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
