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
              showAuthActionSwitch: false,
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
                  child: Text('처음 오신 기로기 환영해요 :) \nSign in with phone 을 눌러 로그인 해주세요!\n\n단계1. Sign in with phone 클릭\n단계2. Code를 +1 에서 +82로 바꾸어 줍니다'
                      '\n단계3. 핸드폰 번호를 입력하고 NEXT 클릭\n단계4. 문자로 오는 코드를 입력\n단계5. 회원가입 성공!'),
                );
              },
              providerConfigs: [
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