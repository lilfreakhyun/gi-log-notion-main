import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:gilog_notion_ver1/main.dart';
import 'package:gilog_notion_ver1/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.yellow, backgroundColor: Colors.white),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //비로그인 상태일때
          if (!snapshot.hasData) {
            return SignInScreen(
              // showAuthActionSwitch: false,
              headerBuilder: (context, constraints, _) {
                return Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset("assets/penswhite.png"),
                ),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? '기-록에 온걸 환영합니다! \n\n이메일로 가입을 원하시면 Register을\n핸드폰으로 가입을 원하시면 Sign in with phone을\n선택하여 회원가입 해주세요!'
                        : '이메일을 입력하고, 비밀번호 확인을 하여 회원가입을 마무리해주세요!',
                  ),
                );
              },
              providerConfigs: [
                EmailProviderConfiguration(),
                PhoneProviderConfiguration(),
              ],
            );
            //로그인 상태일때
          } else {
            return MyCustomForm();
          }
        });
  }
}