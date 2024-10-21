import 'package:astronacci/core/constanta/constanta_string.dart';
import 'package:astronacci/feature/auth/presentation/bloc/login-bloc/login_bloc.dart';
import 'package:astronacci/feature/auth/presentation/cubit/obsecure-cubit/obsecure_cubit.dart';
import 'package:astronacci/feature/profile/presentation/bloc/profile-bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/injection/injection_container.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<LoginBloc>()),
      BlocProvider(create: (context) => sl<ObsecureCubit>())
    ], child: const LoginContent());
  }
}

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
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
        if (state is LoginSuccess) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, RouteConstanta.dashboardScreen, (route) => false);

          context.read<ProfileBloc>().add(FetchUserData(state.data));
        }
        if (state is LoginFailed) {
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
                        "LOG IN",
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
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Password",
                        style: GoogleFonts.poppins(
                            fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    BlocBuilder<ObsecureCubit, bool>(
                      builder: (context, state) {
                        return TextFormField(
                          controller: passCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password!';
                            }
                            return null;
                          },
                          obscureText: state,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 5, 4, 5),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<ObsecureCubit>()
                                        .setObsecure(!state);
                                  },
                                  icon: Icon((state)
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
                                      const BorderSide(color: Colors.indigo))),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: GoogleFonts.poppins(
                                fontSize: 16.0, color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteConstanta.resetPasswordScreen);
                            },
                            child: Text(
                              "Reset Password",
                              style: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
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
                              context.read<LoginBloc>().add(StartLogin(
                                  email: emailCtr.text,
                                  password: passCtr.text));
                            }
                          },
                          child: Text(
                            "Log In",
                            style: GoogleFonts.poppins(
                                fontSize: 16.0, color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dont Have account?",
                            style: GoogleFonts.poppins(
                                fontSize: 16.0, color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteConstanta.registerScreen);
                            },
                            child: Text(
                              "Create account",
                              style: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    )
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
