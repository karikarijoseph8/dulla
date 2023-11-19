import 'package:flutter/material.dart';
import 'package:orbit/components/customfont/customFonts.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/trash/devclass/pagetwo.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.mainBlack, // Change this to your desired color
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Page One",
          style: CustomFonts.urbanist(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainBlack,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.mainWhite,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Setup your",
                style: CustomFonts.urbanist(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Account",
                style: CustomFonts.urbanist(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter username here",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        hintText: "Enter password here",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.mainBlack,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: AppColors.mainBlack,
                        )),
                  ),

                  SizedBox(
                    height: 150,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      minimumSize: Size.fromHeight(40),
                      backgroundColor: Color(0xFFFFBF08),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageTwo(),
                        ),
                      );
                    },
                    child: Text(
                      "Next Page",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: SubmitButton(
                  //     onPressed: () {
                  //       // Navigator.pushReplacement(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //       builder: (context) => HomeScreen()),
                  //       // );
                  //     },
                  //     buttonText: 'Continue',
                  //     btnColor: AppColors.mainYellow,
                  //   ),
                  // ),

                  ///
                  SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: AuthTextFormField(
                  //     controller: firstNameController,
                  //     hint: 'First Name',
                  //     validator: (val) => val!.length > 30
                  //         ? 'More than 30 characters'
                  //         : val.length < 2
                  //             ? 'Too short'
                  //             : null,
                  //     textCapitalization: TextCapitalization.words,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: AuthTextFormField(
                  //     controller: lastNameController,
                  //     hint: 'Last Name',
                  //     validator: (val) => val!.length > 30
                  //         ? 'More than 30 characters'
                  //         : val.length < 2
                  //             ? 'Too short'
                  //             : null,
                  //     textCapitalization: TextCapitalization.words,
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: SubmitButton(
                  //     onPressed: () {
                  //       showDialog(
                  //         barrierDismissible: false,
                  //         context: context,
                  //         builder: (BuildContext context) => ProgressDialog(
                  //           status: 'Fetching details',
                  //         ),
                  //       );

                  //       Future.delayed(Duration(seconds: 5), () {
                  //         Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => HomeScreen()),
                  //         );
                  //       });

                  //       // Navigator.pushReplacement(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //       builder: (context) => HomeScreen()),
                  //       // );
                  //     },
                  //     buttonText: 'Continue',
                  //     btnColor: AppColors.mainYellow,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
