import 'package:aya_medica/features/password/passwordChangedSuccess_screen.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String emailAddress;

  const EmailVerificationScreen({
    super.key,
    required this.emailAddress,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  final int otpLength = 6;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onKeyboardInput(String value) {
    if (value == '<') {
      _handleBackspace();
    } else {
      _addDigit(value);
    }
  }

  void _addDigit(String digit) {
    for (int i = 0; i < otpLength; i++) {
      if (_otpControllers[i].text.isEmpty) {
        _otpControllers[i].text = digit;
        if (i < otpLength - 1) {
          _focusNodes[i + 1].requestFocus();
        }
        break;
      }
    }
  }

  void _handleBackspace() {
    for (int i = otpLength - 1; i >= 0; i--) {
      if (_otpControllers[i].text.isNotEmpty) {
        _otpControllers[i].text = '';
        if (i > 0) {
          _focusNodes[i - 1].requestFocus();
        }
        break;
      }
    }
  }

  String _getOtpCode() {
    return _otpControllers.map((c) => c.text).join();
  }

  void _handleContinue() {
    String otp = _getOtpCode();
    if (otp.length == otpLength) {
      print('OTP entered: $otp');
      // Navigate to password changed success screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PasswordChangedSuccessScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 6 digits')),
      );
    }
  }

  void _resendCode() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code sent again to your email')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main content - White container
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Confirm your email',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1a1a2e),
                    ),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      text: 'Enter the code we sent over email to ',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF747677),
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: widget.emailAddress,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1a1a2e),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      otpLength,
                      (index) => SizedBox(
                        width: 48,
                        height: 48,
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.none,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '-',
                            hintStyle: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFFd0d5dd),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFd0d5dd),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFd0d5dd),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF4da8ff),
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: const Color(0xFFFAFAFA),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1a1a2e),
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Resend code link
                  Row(
                    children: [
                      const Text(
                        "Didn't get an email?",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF747677),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: _resendCode,
                        child: const Text(
                          'Send again',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF5bb8f5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4da8ff),
                        elevation: 3,
                        shadowColor: const Color(0xFF4da8ff).withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Help link - aligned to the right
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to help/support page
                      },
                      child: const Text(
                        'Need a help?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF595A5B),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF595A5B),
                          decorationThickness: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Numeric Keypad - Gray background
            Container(
              color: const Color(0xFFEBEBEB),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  // Row 1: 1, 2, 3
                  Row(
                    children: [
                      _buildKeypadButton('1', ''),
                      const SizedBox(width: 12),
                      _buildKeypadButton('2', 'ABC'),
                      const SizedBox(width: 12),
                      _buildKeypadButton('3', 'DEF'),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Row 2: 4, 5, 6
                  Row(
                    children: [
                      _buildKeypadButton('4', 'GHI'),
                      const SizedBox(width: 12),
                      _buildKeypadButton('5', 'JKL'),
                      const SizedBox(width: 12),
                      _buildKeypadButton('6', 'MNO'),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Row 3: 7, 8, 9
                  Row(
                    children: [
                      _buildKeypadButton('7', 'PQRS'),
                      const SizedBox(width: 12),
                      _buildKeypadButton('8', 'TUV'),
                      const SizedBox(width: 12),
                      _buildKeypadButton('9', 'WXYZ'),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Row 4: 0, backspace
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildKeypadButton('0', ''),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: _handleBackspace,
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFd0d5dd),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.backspace_outlined,
                              color: Color(0xFF1a1a2e),
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String digit, String letters) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onKeyboardInput(digit),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFd0d5dd),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                digit,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1a1a2e),
                ),
              ),
              if (letters.isNotEmpty)
                Text(
                  letters,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF8a8fa8),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
