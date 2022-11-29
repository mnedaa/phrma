import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_selected_card.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_form_field.dart';
import 'login.dart';

class SignUp extends GetWidget<AuthController> {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Sign Up',
          fontSize: 30,
          alignment: Alignment.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.signUpForm,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                CustomText(
                  text: "Welcome,",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  padding: EdgeInsets.only(left: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  labelText: 'Name',
                  hintText: 'example',
                  icon: const Icon(Icons.person),
                  onChanged: (value) {
                    controller.name.value = value!.trim();
                  },
                  validator: (String? value) =>
                      value!.isEmpty ? 'Enter Name' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelText: 'Phone',
                  hintText: 'phone number',
                  prefixText: '+05 | ',
                  textInputType: TextInputType.number,
                  icon: const Icon(Icons.phone),
                  onChanged: (value) {
                    controller.phone.value = value!.trim();
                  },
                  validator: (String? value) =>
                      value!.isEmpty ? 'Enter Phone Number' : value.length != 8 ? 'Wrong Number' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelText: 'Age',
                  hintText: 'Your Age',
                  textInputType: TextInputType.number,
                  icon: const Icon(Icons.date_range),
                  onChanged: (value) {
                    controller.age.value = value!.trim();
                  },
                  validator: (String? value) =>
                      value!.isEmpty ? 'Enter Your Age' : value.length != 2 || int.parse(value) <= 10 ? 'Wrong Age' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelText: 'Email',
                  hintText: "example@gmail.com",
                  icon: const Icon(Icons.email),
                  onChanged: (value) {
                    controller.email.value = value!.trim();
                  },
                  validator: (String? value) =>
                      value!.isEmpty || value.contains('@gmail.com') == false
                          ? 'Enter Valid Email'
                          : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => CustomTextFormField(
                      labelText: 'Password',
                      hintText: "********",
                      icon: IconButton(
                          icon: controller.obscureText.value == false
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            controller.obscureText.value == true
                                ? controller.obscureText.value = false
                                : controller.obscureText.value = true;
                          }),
                      onChanged: (value) {
                        controller.password.value = value!.trim();
                      },
                      validator: (String? value) =>
                          value!.isEmpty ? 'Enter Password' : value.length < 8 ? 'At least enter 8 digits' : null,
                      obscure: controller.obscureText.value,
                    )),
                const SizedBox(
                  height: 30,
                ),
                CustomSelectedCard(gender: controller.genderSelected,),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    text: 'Sign Up',
                    fontSize: 22,
                    onPressed: () {
                      if (controller.signUpForm.currentState?.validate() ==
                          true) {
                        controller.emailPasswordSignUPMethod();
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: "Have account ? ",
                  fontSize: 22,
                  alignment: Alignment.center,
                ),
                TextButton(
                    onPressed: () {
                      Get.offAll(() => const LogIn());
                    },
                    child: const CustomText(
                      text: 'Log In',
                      fontSize: 22,
                      color: Colors.blue,
                      alignment: Alignment.center,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
