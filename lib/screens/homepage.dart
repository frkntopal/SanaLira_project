import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sanalira_project/screens/mainpage.dart';

import '../provider/provider.dart';
import '../utility/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _textVisible = true;

  final GlobalKey<FormState> _email = GlobalKey<FormState>();
  final GlobalKey<FormState> _password = GlobalKey<FormState>();
  final GlobalKey<FormState> _name = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneNumber = GlobalKey<FormState>();
  final _countryCodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String telephoneCode = "+90";
  String defaultCountrySvgValue = "assets/images/turkey.png";
  bool formErrorCheck = false;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  List<String> countryCodeList = [];

  bool _contractCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    "assets/images/login_background.png",
                  ),
                  fit: BoxFit.fill,
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    randomBackground1.withOpacity(0.8),
                    randomBackground2.withOpacity(0.8),
                  ],
                )),
              ),
              Column(
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                          child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.height * 0.1,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                  "assets/images/sanalira_logo.png",
                                )),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text("SanaLira",
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ))),
                  Flexible(
                      flex: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: homepagebackground.withOpacity(0.75)),
                        child: viewLogin(_contractCheck),
                      )),
                ],
              ),
            ]),
          ),
        ));
  }

  Column viewLogin(bool _contractCheck) {
    final passwordField = Form(
      key: _password,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _textVisible,
            style: TextStyle(color: Colors.white),
            controller: _passwordController,
            autofocus: false,
            validator: (value) {
              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
              if (value == null || value.trim().isEmpty) {
                return 'Lütfen bir şifre belirleyin';
              } else if (!regex.hasMatch(value)) {
                return "Şifreniz küçük harf, büyük harf, sayı ve özel karakter içermelidir.";
              } else if (value.trim().length < 6) {
                return 'Şifreniz en az 6 karakter uzunluğunda olmalıdır.';
              }
              if (value.trim().length > 20) {
                return 'Şifreniz en fazla 20 karakter uzunluğunda olmalıdır.';
              } else
                return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                hintText: "Lütfen şifre belirleyin",
                suffixIcon: IconButton(
                  icon: Icon(
                      _textVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _textVisible = !_textVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)))),
      ),
    );
    final emailField = Form(
      key: _email,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            style: TextStyle(color: Colors.white),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailController,
            autofocus: false,
            validator: (value) {
              if (value != null) {
                if (value.contains('@') && value.endsWith('.com')) {
                  return null;
                }
                return 'Lütfen doğru bir e-posta adresi kullanın.';
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              hintText: "esrefyasa@monegon.com",
            )),
      ),
    );

    final nameField = Form(
      key: _name,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            style: TextStyle(color: Colors.white),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _nameController,
            autofocus: false,
            validator: (value) {
              if (value != null) {
                if (value.length > 3 && value.length < 50) {
                  return null;
                }
                return 'İsminiz ve soyadınız en az 3 karakter olmalıdır!';
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              hintText: "Eşref Yasa",
            )),
      ),
    );

    final phoneNumberfield = Form(
      key: _phoneNumber,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            style: TextStyle(color: Colors.white),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            autofocus: false,
            maxLength: 10,
            validator: (value) {
              if (value != null) {
                if (value.length == 10) {
                  return null;
                }
                return 'Geçerli bir numara giriniz';
              }
            },
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              hintText: "(555) 555 55 55",
            )),
      ),
    );

    final countryCodeField = SizedBox(
      height: 60,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _countryCodeController,
        keyboardType: TextInputType.phone,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.length > 3) {
              return null;
            }
            return 'Hatalı Ülke Kodu!';
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          hintText: "+90",
          prefixIcon: Padding(
            padding: const EdgeInsets.all(7.0),
            child: SvgPicture.asset("assets/images/turkey.png"),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "SanaLira'ya ",
                              style: TextStyle(
                                  color: logogreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "Yeni Üyelik",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16))
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text("Bilgilerinizi girip sözleşmeyi onaylayın.",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14))
                    ]),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Ad ve Soyad",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12),
                          ),
                        ),
                      ),
                      Form(child: nameField),
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                    ),
                  ),
                ),
                emailField,
              ],
            ),
          )),
        ),
        Flexible(
          flex: 3,
          child: Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Şifre",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                    ),
                  ),
                ),
                passwordField,
              ],
            ),
          )),
        ),
        Flexible(
          flex: 3,
          child: Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Cep Telefonu Numaranız",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                  ),
                                  builder: (BuildContext context) {
                                    return Card();
                                  });
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: SvgPicture.asset(
                                        defaultCountrySvgValue,
                                        width: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      telephoneCode,
                                      style: const TextStyle(
                                        color: randomGrey,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        )),
                    const Spacer(flex: 2),
                    Expanded(flex: 20, child: phoneNumberfield),
                  ],
                ),
              ],
            ),
          )),
        ),
        Flexible(
          flex: 4,
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        value: this._contractCheck,
                        onChanged: (bool? value) {
                          setState(() {
                            this._contractCheck = value!;
                          });
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        child: RichText(
                          text: const TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Hesabınızı oluştururken",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            TextSpan(
                                text: " sözleşme ve koşulları ",
                                style: TextStyle(
                                    color: logogreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "kabul etmeniz gerekir.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14))
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  final provider =
                      Provider.of<FireBaseProvider>(context, listen: false);

                  if (_password.currentState!.validate() &&
                      _email.currentState!.validate() &&
                      _name.currentState!.validate() &&
                      _phoneNumber.currentState!.validate() == true) {}
                  provider
                      .registerMail(
                        email: _emailController.text.toString(),
                        password: _passwordController.text.toString(),
                      )
                      .whenComplete(() => provider.userDetail(
                            userId: FirebaseAuth.instance.currentUser!.uid
                                .toString(),
                            email: _emailController.text.toString(),
                            creationDate: DateTime.now().toString(),
                            name: _nameController.text.toString(),
                            country: telephoneCode.toString(),
                            phoneNumber: _phoneNumberController.text.toString(),
                          ));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: logogreen,
                    textStyle: const TextStyle(fontSize: 18)),
                child: const Text(
                  'Giriş Yap',
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
