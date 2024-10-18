import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kijani_branch/app/modules/auth/controllers/auth_controller.dart';
import 'package:kijani_branch/global/enums/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fitWidth,
            opacity: 0.3,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 24,
              left: 24,
              right: 24,
            ),
            child: Center(
              child: Form(
                //key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Image(
                        image: const AssetImage("assets/kijani_logo.png"),
                        color: kfBlue,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Kijani Forestry",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: kfBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "We plant trees to break the cycle of climate-induced poverty in Africa",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kfBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        // autofocus: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kfBlue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kfBlue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(),
                          counterText: '',
                          hintStyle: TextStyle(
                            color: kfBlue,
                            fontSize: 16.0,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        controller: usernameController,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        // autofocus: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "Enter Code",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kfBlue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kfBlue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(),
                          counterText: '',
                          hintStyle: TextStyle(
                            color: kfBlue,
                            fontSize: 16.0,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Pin';
                          }
                          return null;
                        },
                        controller: passwordController,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    EasyButton(
                      height: 65,
                      borderRadius: 16.0,
                      buttonColor: kfBlue,
                      idleStateWidget: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      loadingStateWidget:
                          LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.white, size: 30),
                      onPressed: () async {
                        String username = usernameController.text.trim();
                        String password = passwordController.text.trim();

                        // Call the login method from AuthController
                        await authController.login(username, password);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "© ${DateTime.now().year} Kijani Forestry. All rights reserved.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 22, 78, 26),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
