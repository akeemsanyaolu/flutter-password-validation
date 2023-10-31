import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_password_validation/custom_shake_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _isPasswordValid = false;

  //late GlobalKey<FormState> _formKey;
  late GlobalKey<CustomShakeWidgetState> _passwordState;
  //late TextEditingController _passwordEditingController;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;

      if (password.length >= 8 && numericRegex.hasMatch(password)) {
        _isPasswordValid = true;
      } else {
        _isPasswordValid = false;
      }
    });
  }

  @override
  void initState() {
    //_formKey = GlobalKey();
    _passwordState = GlobalKey();
    //_passwordEditingController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Create Your Account",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Set a password",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Please create a secure password including the following criteria below.",
              style: TextStyle(
                  fontSize: 16, height: 1.5, color: Colors.grey.shade600),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomShakeWidget(
              key: _passwordState,
              duration: const Duration(milliseconds: 800),
              shakeCount: 4,
              shakeOffset: 10,
              child: TextField(
                onChanged: (password) => onPasswordChanged(password),
                obscureText: !_isVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  hintText: "Password",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: _isPasswordEightCharacters
                          ? Colors.green
                          : Colors.transparent,
                      border: _isPasswordEightCharacters
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Contains at least 8 characters")
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: _hasPasswordOneNumber
                          ? Colors.green
                          : Colors.transparent,
                      border: _hasPasswordOneNumber
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Contains at least 1 number")
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  color: _isPasswordValid ? Colors.black : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 2, offset: Offset(0, 2))
                  ]),
              child: MaterialButton(
                height: 50,
                minWidth: double.infinity,
                onPressed: _isPasswordValid
                    ? () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccessfulPage()));
                      }
                    : () {
                        _passwordState.currentState?.shake();
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({super.key});

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  final confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    confettiController.play();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Account Created\nSuccessfully',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MaterialButton(
                  height: 50,
                  minWidth: double.infinity,
                  color: Colors.black,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "GET STARTED",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      ConfettiWidget(
        confettiController: confettiController,
        shouldLoop: true,
        blastDirectionality: BlastDirectionality.explosive,
      )
    ]);
  }
}
