// ignore_for_file: prefer_const_constructors

import 'package:astronacci/feature/dashboard/presentation/bloc/user-bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constanta/constanta_string.dart';
import '../../../core/injection/injection_container.dart';
import '../../profile/presentation/bloc/profile-bloc/profile_bloc.dart';
import '../data/model/user_resp_model.dart';
import 'cubit/count-cubit/count_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<CountCubit>()),
    ], child: const DashboardContent());
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserBloc>().add(FetchUser(1, true));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (context.read<CountCubit>().state < 2) {
          context.read<UserBloc>().add(FetchUser(2, false));
          context.read<CountCubit>().setCount(2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi,",
                            style: GoogleFonts.poppins(
                                fontSize: 24.0, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${state.data.firstName} ${state.data.lastName}",
                            style: GoogleFonts.poppins(
                                fontSize: 24.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteConstanta.profileScreen);
                        },
                        child: const Icon(Icons.person)),
                    const SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text('Apakah anda ingin Keluar?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            RouteConstanta.loginScreen,
                                            (route) => false);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Icon(Icons.logout)),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Temukan Seseorang :",
              style: GoogleFonts.poppins(
                  fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              onChanged: (value) {
                context.read<UserBloc>().add(SearchUser(value));
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10, 5, 4, 5),
                suffixIcon: const Icon(Icons.search),
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
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: const CircularProgressIndicator()));
                  }
                  if (state is UserSuccess) {
                    return GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30.0,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: state.isLoadingMore
                          ? state.data.length + 1
                          : state.data.length,
                      itemBuilder: (context, index) {
                        if (index == state.data.length) {
                          return Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator());
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteConstanta.userDetail,
                                arguments: UserDetail(
                                    firstName: state.data[index].firstName,
                                    lastName: state.data[index].lastName,
                                    imageUrl: state.data[index].avatar,
                                    email: state.data[index].email));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                state.data[index].avatar),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${state.data[index].firstName} ${state.data[index].lastName}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          state.data[index].email,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    );
                  }
                  return Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: const CircularProgressIndicator()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
