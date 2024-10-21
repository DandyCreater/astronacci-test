import 'package:astronacci/core/constanta/constanta_string.dart';
import 'package:astronacci/feature/profile/presentation/bloc/profile-bloc/profile_bloc.dart';
import 'package:astronacci/feature/profile/presentation/cubit/new-pass-cubit/new_pass_cubit.dart';
import 'package:astronacci/feature/profile/presentation/cubit/old-pass-cubit/old_pass_cubit.dart';
import 'package:astronacci/feature/profile/presentation/cubit/validate-pass-cubit/validate_pass_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/injection/injection_container.dart';
import '../bloc/change-password-bloc/change_password_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: ((context) => sl<OldPassCubit>())),
      BlocProvider(create: ((context) => sl<NewPassCubit>())),
      BlocProvider(create: ((context) => sl<ValidatePassCubit>())),
      BlocProvider(create: ((context) => sl<ChangePasswordBloc>())),
    ], child: const ChangePasswordContent());
  }
}

class ChangePasswordContent extends StatefulWidget {
  const ChangePasswordContent({super.key});

  @override
  State<ChangePasswordContent> createState() => _ChangePasswordContentState();
}

class _ChangePasswordContentState extends State<ChangePasswordContent> {
  final _formKey = GlobalKey<FormState>();
  final oldPassCtr = TextEditingController();
  final newPassCtr = TextEditingController();
  final valPassCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordLoading) {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()),
                );
              });
        }
        if (state is ChangePasswordSuccess) {
          final snackbar = SnackBar(
            content: Text("Ganti Password Berhasil!"),
            duration: const Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, RouteConstanta.loginScreen, (route) => false);
        }
        if (state is ChangePasswordFailed) {
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: SizedBox(
                        height: 150.0,
                        width: 150.0,
                        child: Lottie.network(
                            "https://lottie.host/8fdfac92-4a4b-4edc-a0d6-c6e989d90a23/4q62gvMFAQ.json"),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Change Password",
                        style: GoogleFonts.poppins(
                            fontSize: 24.0,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Old Password",
                        style: GoogleFonts.poppins(
                            fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    BlocBuilder<OldPassCubit, bool>(
                      builder: (context, state) {
                        return TextFormField(
                          obscureText: state,
                          controller: oldPassCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Old Password!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 5, 4, 5),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<OldPassCubit>()
                                      .setOldPass(!state);
                                },
                                icon: Icon(state
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
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
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: Colors.indigo)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "New Password",
                        style: GoogleFonts.poppins(
                            fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    BlocBuilder<NewPassCubit, bool>(
                      builder: (context, state) {
                        return TextFormField(
                          obscureText: state,
                          controller: newPassCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter New Password!';
                            }
                            if (value != valPassCtr.text) {
                              return 'Password tidak sama';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 5, 4, 5),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<NewPassCubit>()
                                      .setNewPass(!state);
                                },
                                icon: Icon(state
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
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
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: Colors.indigo)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Re-Enter Password",
                        style: GoogleFonts.poppins(
                            fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    BlocBuilder<ValidatePassCubit, bool>(
                      builder: (context, state) {
                        return TextFormField(
                          obscureText: state,
                          controller: valPassCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password!';
                            }
                            if (value != newPassCtr.text) {
                              return 'Password tidak sama';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 5, 4, 5),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<ValidatePassCubit>()
                                      .setValidatePass(!state);
                                },
                                icon: Icon(state
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
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
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: Colors.indigo)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileSuccess) {
                          return SizedBox(
                            height: 40.0,
                            width: width,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.indigo)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ChangePasswordBloc>().add(
                                        StartChangePass(
                                            email: state.data.email ?? "",
                                            newPassword: newPassCtr.text,
                                            oldPassword: oldPassCtr.text));
                                  }
                                },
                                child: Text(
                                  "Change Password",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16.0, color: Colors.white),
                                )),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
