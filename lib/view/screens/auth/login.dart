import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/view/screens/auth/sign_up.dart';

import '../../../controller/auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_form_field.dart';


class LogIn extends GetWidget<AuthController> {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Log In',
          fontSize: 30,
          alignment: Alignment.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.logInForm,
          child: Column(
            children: [
              Column(
                children: const [
                  SizedBox(height: 40,),
                  CustomText(
                    text: "Welcome,",
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    padding: EdgeInsets.only(left: 20),
                  ),
                  CustomText(
                    text: "Sign In to continue",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'Email',
                      hintText: "example@gmail.com",
                      icon: const Icon(Icons.email),
                      onChanged: (value) {
                        controller.email.value = value!.trim();
                      },
                      validator: (String? value) => value!.isEmpty ? 'Enter Email' : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => CustomTextFormField(
                      labelText: 'Password',
                      hintText: "********",
                      icon: IconButton(
                          icon: controller.obscureText.value == false ?  const Icon(Icons.visibility_off) :  const Icon(Icons.visibility),
                          onPressed: () {
                            controller.obscureText.value == true ?
                            controller.obscureText.value = false : controller.obscureText.value = true ;
                          }),
                      onChanged: (value) {
                        controller.password.value = value!.trim();
                      },
                      validator: (String? value) =>
                      value!.isEmpty ? 'Enter Password' : null,
                      obscure: controller.obscureText.value,
                    )),
                    const SizedBox(
                      height: 60,
                    ),
                    CustomButton(text: 'Log In', fontSize: 22, onPressed: () {
                      if(controller.logInForm.currentState!.validate()){
                        controller.emailPasswordSignInMethod();
                      }
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      text: "Don't have account ? ",
                      fontSize: 22,
                      alignment: Alignment.center,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.offAll(() => const SignUp());
                        },
                        child: const CustomText(
                          text: 'Sign Up',
                          fontSize: 22,
                          color: Colors.blue,
                          alignment: Alignment.center,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
