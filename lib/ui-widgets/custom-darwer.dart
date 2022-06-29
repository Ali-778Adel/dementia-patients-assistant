import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/auth_cubit/auth-states.dart';
import 'package:untitled/bloc/auth_cubit/auth_cubit.dart';
import 'package:untitled/ui-screens/home-screen-demo.dart';
import 'package:untitled/ui-screens/login-screen.dart';

import '../constants/constants.dart';

class CustomDrawer extends StatelessWidget {
 const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final user=FirebaseAuth.instance.currentUser;
    return
       Stack(
        children: [
          Container(
            width:MediaQuery.of(context).size.width*.60,
            decoration: const BoxDecoration(
              color:scaffoldMainColor,
                gradient: LinearGradient(
              colors: [Colors.orange, Colors.blue, Colors.blue],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
            )
            ),
          ),
          SafeArea(
              child: SizedBox(
                width:MediaQuery.of(context).size.width*.60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: DrawerHeader(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      BlocBuilder<AuthCubit,AuthStates>(
                        builder: (context, snapshot) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user!.photoURL??''),
                          );
                        }
                      ),
                    const  SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<AuthCubit,AuthStates>(
                        builder: (context, snapshot) {
                          return Text(
                            user!.displayName??'wait...',
                            style:const TextStyle(fontSize: 18, color: Colors.white),
                          );
                        }
                      ),
                      const  SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<AuthCubit,AuthStates>(
                          builder: (context, snapshot) {
                            return Text(
                              user!.email!,
                              style:const TextStyle(fontSize: 18, color: Colors.white),
                            );
                          }
                      ),
                      BlocBuilder<AuthCubit,AuthStates>(
                          builder: (context, snapshot) {
                            return Text(
                              user!.phoneNumber!,
                              style:const TextStyle(fontSize: 18, color: Colors.white),
                            );
                          }
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0.8),
                    children:  [
                      BlocBuilder<AuthCubit,AuthStates>(

                        builder: (context, snapshot) {
                          return ListTile(
                            onTap: (){
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreenDemo()));
                            },
                            leading:const Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 18,
                            ),
                            title:const Text(
                              'Home',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            subtitle:const Text(
                              'go to home page',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          );
                        }
                      ),
                      const Divider(
                        indent: 12,
                        endIndent: 12,
                        color: Colors.black,
                        thickness: .1,
                      ),
                      ListTile(
                        onTap: (){},
                        leading:const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 18,
                        ),
                        title:const Text(
                          'account',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        subtitle:const Text(
                          'go to your account form',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      const Divider(
                        indent: 12,
                        endIndent: 12,
                        color: Colors.black,
                        thickness: .1,
                      ),
                      ListTile(
                        onTap: (){},
                        leading:const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        title:const Text(
                          'Settings',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        subtitle:const Text(
                          'adjust your settings',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      const Divider(
                        indent: 12,
                        endIndent: 12,
                        color: Colors.black,
                        thickness: .1,
                      ),
                      BlocBuilder<AuthCubit,AuthStates>(
                        builder: (context, snapshot) {
                          return ListTile(
                            onTap: (){
                              context.read<AuthCubit>().logoutGoogleAccount();
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(
                                  builder: (context)=>const LoginScreen()), (route) => false);

                            },
                            leading:const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 18,
                            ),
                            title:const Text(
                              'log out',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            subtitle:const Text(
                              'log out from current account ',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      );

  }
}
