// ignore_for_file: use_build_context_synchronously

import 'package:astronacci/feature/auth/data/model/login_resp_model.dart';
import 'package:astronacci/feature/auth/presentation/bloc/register-bloc/register_bloc.dart';
import 'package:astronacci/feature/auth/presentation/cubit/obsecure-cubit/obsecure_cubit.dart';
import 'package:astronacci/feature/auth/presentation/cubit/register-cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constanta/constanta_string.dart';
import '../../../../core/injection/injection_container.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<ObsecureCubit>()),
      BlocProvider(create: (context) => sl<RegisterCubit>()),
      BlocProvider(create: (context) => sl<RegisterBloc>()),
    ], child: const RegisterContent());
  }
}

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      context.read<RegisterCubit>().addBornDate(_dateController.text);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
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
        if (state is RegisterSuccess) {
          final snackbar = SnackBar(
            content: Text('Registration successful!'),
            duration: const Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackbar);

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteConstanta.loginScreen);
          });
        }
        if (state is RegisterFailed) {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60.0,
                  ),
                  Center(
                    child: Text(
                      "Register Form",
                      style: GoogleFonts.poppins(
                          fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Lottie.network(
                          "https://lottie.host/6b730eae-de45-4c03-8890-578e43b63b8e/GoMHBpGWa1.json"),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Biodata",
                    style: GoogleFonts.poppins(
                        fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First Name!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<RegisterCubit>().addFirstName(value);
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
                    onChanged: (value) {
                      context.read<RegisterCubit>().addLastName(value);
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
                    onChanged: (value) {
                      context.read<RegisterCubit>().addBornPlace(value);
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
                  BlocBuilder<RegisterCubit, RegistState>(
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
                            context.read<RegisterCubit>().addGender(value);
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
                    maxLines: 3,
                    minLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Address!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<RegisterCubit>().addAddress(value);
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
                  Text(
                    "Account Information",
                    style: GoogleFonts.poppins(
                        fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Email : ",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<RegisterCubit>().addEmail(value);
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
                      "Password : ",
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  BlocBuilder<ObsecureCubit, bool>(
                    builder: (context, state) {
                      return TextFormField(
                        obscureText: state,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          context.read<RegisterCubit>().addPassword(value);
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<ObsecureCubit>()
                                    .setObsecure(!state);
                              },
                              icon: Icon(state
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
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
                            var data = context.read<RegisterCubit>().state;
                            context.read<RegisterBloc>().add(StartRegister(
                                    parameter: RegisterParameterPost(
                                  firstName: data.firstName,
                                  address: data.address,
                                  bornDate: data.bornDate,
                                  bornPlace: data.bornPlace,
                                  gender: data.gender,
                                  lastName: data.lastName,
                                  password: data.password,
                                  email: data.email,
                                )));
                          }
                        },
                        child: Text(
                          "Create Account",
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
