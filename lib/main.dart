import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3D Futuristic Login',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090B10),
      ),
      home: const Login3DScreen(),
    );
  }
}

class Login3DScreen extends StatefulWidget {
  const Login3DScreen({super.key});

  @override
  State<Login3DScreen> createState() => _Login3DScreenState();
}

class _Login3DScreenState extends State<Login3DScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;
  bool isLogin = true;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // الخلفية ثلاثية الأبعاد التفاعلية
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return CustomPaint(
                size: size,
                painter: Background3DPainter(_bgController.value),
              );
            },
          ),

          // المحتوى والبطاقة الزجاجية 3D Tilt
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Tilt(
                borderRadius: BorderRadius.circular(25),
                tiltConfig: const TiltConfig(
                  angle: 15,
                  enableRevert: true,
                ),
                child: GlassmorphicContainer(
                  width: size.width > 450 ? 400 : size.width * 0.9,
                  height: 580,
                  borderRadius: 25,
                  blur: 20,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF6366F1).withOpacity(0.8),
                      const Color(0xFFA855F7).withOpacity(0.3),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withOpacity(0.5),
                                blurRadius: 25,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_outline_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        )
                            .animate(onPlay: (controller) => controller.repeat(reverse: true))
                            .scale(
                              duration: 2.seconds,
                              begin: const Offset(1, 1),
                              end: const Offset(1.1, 1.1),
                            ),

                        const SizedBox(height: 20),

                        Text(
                          isLogin ? 'مرحباً بك مجدداً' : 'حساب جديد',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).animate().fadeIn(duration: 600.ms).moveY(begin: 20, end: 0),

                        const SizedBox(height: 8),

                        Text(
                          isLogin ? 'قم بتسجيل الدخول للمتابعة' : 'أنشئ حسابك للبدء معنا',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),

                        const SizedBox(height: 30),

                        _buildTextField(
                          hint: 'البريد الإلكتروني',
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 16),

                        _buildTextField(
                          hint: 'كلمة المرور',
                          icon: Icons.lock_clock_outlined,
                          isPassword: true,
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 10,
                              shadowColor: const Color(0xFF6366F1).withOpacity(0.5),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  isLogin ? 'تسجيل الدخول' : 'إنشاء الحساب',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: RichText(
                            text: TextSpan(
                              text: isLogin ? 'ليس لديك حساب؟ ' : 'لديك حساب بالفعل؟ ',
                              style: TextStyle(color: Colors.white.withOpacity(0.7)),
                              children: [
                                TextSpan(
                                  text: isLogin ? 'إنشاء حساب' : 'تسجيل الدخول',
                                  style: const TextStyle(
                                    color: Color(0xFFA855F7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: TextField(
        obscureText: isPassword,
        textAlign: TextAlign.right,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          prefixIcon: Icon(icon, color: const Color(0xFFA855F7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}

class Background3DPainter extends CustomPainter {
  final double animationValue;

  Background3DPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final offset1 = Offset(
      size.width * 0.2 + math.sin(animationValue * 2 * math.pi) * 30,
      size.height * 0.25 + math.cos(animationValue * 2 * math.pi) * 30,
    );
    paint.shader = const RadialGradient(
      colors: [Color(0xFF6366F1), Colors.transparent],
    ).createShader(Rect.fromCircle(center: offset1, radius: 180));
    canvas.drawCircle(offset1, 180, paint);

    final offset2 = Offset(
      size.width * 0.8 + math.cos(animationValue * 2 * math.pi) * 40,
      size.height * 0.75 + math.sin(animationValue * 2 * math.pi) * 40,
    );
    paint.shader = const RadialGradient(
      colors: [Color(0xFFA855F7), Colors.transparent],
    ).createShader(Rect.fromCircle(center: offset2, radius: 220));
    canvas.drawCircle(offset2, 220, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}