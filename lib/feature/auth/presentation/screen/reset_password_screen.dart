import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/injection/injection_container.dart';
import '../bloc/reset-password-bloc/reset_password_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<ResetPasswordBloc>()),
    ], child: const ResetPasswordContent());
  }
}

class ResetPasswordContent extends StatefulWidget {
  const ResetPasswordContent({super.key});

  @override
  State<ResetPasswordContent> createState() => _ResetPasswordContentState();
}

class _ResetPasswordContentState extends State<ResetPasswordContent> {
  final _formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
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
        if (state is ResetPasswordSuccess) {
          final snackbar = SnackBar(
            content: Text("Silahkan Cek Email untuk Reset Password"),
            duration: const Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);
        }
        if (state is ResetPasswordFailed) {
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
                        "Reset Password",
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
                        "Email",
                        style: GoogleFonts.poppins(
                            fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: emailCtr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(10, 5, 4, 5),
                        prefixIcon: const Icon(Icons.person),
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
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 40.0,
                      width: width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.indigo)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<ResetPasswordBloc>()
                                  .add(StartResetPass(emailCtr.text));
                            }
                          },
                          child: Text(
                            "Send Email",
                            style: GoogleFonts.poppins(
                                fontSize: 16.0, color: Colors.white),
                          )),
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
