import 'package:flutter/material.dart';
import '../EXPORTS/exports.files.dart';

class UserSignin extends StatefulWidget {
  const UserSignin({Key? key}) : super(key: key);
  @override
  State<UserSignin> createState() => _UserSigninState();
}

class _UserSigninState extends State<UserSignin> {
  TextEditingController userPhone = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  bool isObscur = true;

  _onConnexion() => signin(context, userPhone.text, userPassword.text);

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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: paddingTop(context),
                                  ),
                                  SizedBox(
                                    height: fullHeight(context) * 0.04,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Cre',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 44,
                                            color: greencolor),
                                      ),
                                      Text(
                                        'do',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 44,
                                            color: greencolor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: fullHeight(context) * 0.06,
                                  ),
                                  const Text(
                                    'Connectez-vous',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    'Complèter vos identifiants pour accéder au compte',
                                    style: TextStyle(
                                        color: greencolor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: fullHeight(context) * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  inputField(context, userPhone, 'Téléphone',
                                      Icons.phone,TextInputType.number),
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
                                    height: fullHeight(context) * 0.06,
                                  ),
                                  button(context, _onConnexion, 'Connexion')
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
                                        context, '/user/signup'),
                                    child: const Text(
                                      'Créer un compte ! ',
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
