import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Homepage',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        foregroundColor: Colors.white,
        title: const Text(
          'Home',
        ),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
                      return Column(children: [
            Image.asset('assets/touchwonders.jpg'),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Welcome to the homepage.',
                style: TextStyle(
                    color: Color.fromARGB(255, 54, 54, 54), fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
              child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: const Color.fromARGB(255, 255, 101, 124),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 46, 46, 46)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 101, 124))),
                  ),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
              child: TextField(
                controller: _password,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 46, 46, 46),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 101, 124))),
                ),
                textAlign: TextAlign.center,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                cursorColor: const Color.fromARGB(255, 255, 101, 124),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  final userCrededtial = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  print(userCrededtial);
                },
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 46, 46, 46),
                    backgroundColor: const Color.fromARGB(255, 232, 232, 232)),
                child: const Text('Register'),
              ),
            )
          ]);
          default:
          return const Text('loading...');
          }
        },
      ),
    );
  }
}
