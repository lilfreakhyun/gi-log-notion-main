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
                  padding: const EdgeInsets.only(top: 30),
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
                        ? '처음 오신 기로기 환영해요 :) \nRegister을 눌러 회원가입 해주세요!\n'
                        : '1. 이메일 형식으로 입력 (ex: gilog1234@naver.com) \n2. 비밀번호를 입력\n3. 비밀번호 재확인하여 모든 칸을 채우고\n4. Register을 눌러 회원가입을 마무리 해주세요!',
                  ),
                );
              },

              providerConfigs: [
                EmailProviderConfiguration(),
              ],
            );
            //로그인 상태일때
          } else {
            return MyCustomForm();
          }
        });
  }
}

/* class MainPage extends StatefulWidget {
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
              providerConfigs: [
                EmailProviderConfiguration(),
              ],
            );
            //로그인 상태일때
          } else {
            return MyCustomForm();
          }
        });
  }
} */