import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({Key? key}) : super(key: key);

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userMail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  bool isObscur = true;
  
  _onSignUp() => signup({
        'name': userName,
        'password': userPassword,
        'email': userMail,
        'phoneNumber': userPhone
      });
      
  _onShowpassword() => setState(() {
        isObscur = !isObscur;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
          height: fullHeight(context),
          width: fullWidth(context),
          child: Padding(
            padding: EdgeInsets.only(top: paddingTop(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: SizedBox(
                        width: fullWidth(context),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Image(
                                    image:
                                        AssetImage('assets/images/credo.png'),
                                    fit: BoxFit.cover,
                                    height: 60,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Créer un compte',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Compèter vos identifiants pour créer un compte',
                                    style: TextStyle(
                                        color: greencolor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: fullHeight(context) * 0.06,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: fullHeight(context) * 0.025,
                                  ),
                                  inputField(context, userName,
                                      'Noms (Joh Doe)', Icons.person),
                                  inputField(context, userPhone, 'Téléphone',
                                      Icons.phone),
                                  inputField(context, userMail, 'Adresse mail',
                                      Icons.email),
                                  inputFieldPass(
                                      context,
                                      userPassword,
                                      'Mot de passe',
                                      Icons.key_rounded,
                                      isObscur,
                                      isObscur
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      _onShowpassword),
                                  SizedBox(
                                    height: fullHeight(context) * 0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                          'En cliquant sur créer compe, vous accépter'),
                                      Text(
                                        "la politiaque de confidentialité et les cnditions d'utilisation",
                                        style: TextStyle(color: greencolor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: fullHeight(context) * 0.02,
                                  ),
                                  button(context, _onSignUp, 'Créer compte')
                                ],
                              ),
                              SizedBox(
                                height: fullHeight(context) * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Avez vous déjà un compte ? '),
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/user/signin'),
                                    child: const Text(
                                      'Connectez-vous ! ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: greencolor),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))),
              ],
            ),
          )),
    ));
  }
}
