import 'package:flutter/material.dart';
import 'data.dart';
import 'package:confetti/confetti.dart';

class teamtwoontwo extends StatefulWidget {
  String img1url;
  String img2url;
  String img3url;
  String img4url;
   teamtwoontwo({required this.img1url,required this.img2url, required this.img3url, required this.img4url});

  @override
  teamtwoontwoState createState() => teamtwoontwoState();
}

class teamtwoontwoState extends State<teamtwoontwo> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _sizeController;
  late AnimationController _fadeController;
  late Animation<double> _leftBoxAnimation;
  late Animation<double> _rightBoxAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _fadeAnimation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    // Initialize the main animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _sizeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation =Tween<double>(begin: 3, end: 1).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _leftBoxAnimation = Tween<double>(begin: -150, end: 0).animate(_controller);
    _rightBoxAnimation = Tween<double>(begin: -150, end: 0).animate(_controller);
    _sizeAnimation = Tween<double>(begin: 950, end: 750).animate(
        CurvedAnimation(parent: _sizeController, curve: Curves.easeInOutBack));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.forward();

      }
    });
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _confettiController.play();
      }
    });


    // Delay the size animation

    Future.delayed(const Duration(milliseconds: 1000), () {
      _controller.forward();
    });

    _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: AnimatedBuilder(
        animation: Listenable.merge([_controller, _fadeController]),
        builder: (context, child) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: _leftBoxAnimation.value,
                  child: Container(
                    width: 150,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade50.withOpacity(0.7),
                          Colors.purple.shade400.withOpacity(0.5)
                        ],
                        begin: Alignment.topLeft,
                        end: const Alignment(0.5, 0.1),
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(360)
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    widget.img1url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20,),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(360)
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    widget.img2url,
                                    fit: BoxFit.cover,
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
                Positioned(
                  right: _rightBoxAnimation.value,
                  child: Container(
                    width: 150,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade300.withOpacity(0.7),
                          Colors.green.shade100.withOpacity(0.5)
                        ],
                        begin: Alignment.center,
                        end: const Alignment(0.5, 0.1),
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(360)
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    widget.img3url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20,),
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(360)
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    widget.img4url,
                                    fit: BoxFit.cover,
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
                ScaleTransition(
                  scale: _fadeAnimation,
                  child: Align(
                    alignment: Alignment.center,
                    child: _controller.isCompleted
                        ?Image(
                      image: MemoryImage(v_bytes),
                      height: _sizeAnimation.value,
                    ):Container(),
                  ),
                ),
                ScaleTransition(
                  scale: _fadeAnimation,
                  child: Align(
                    alignment: const Alignment(0.01, 0),
                    child: _controller.isCompleted
                        ?Image(
                      image: MemoryImage(s_bytes),
                      height: _sizeAnimation.value,
                    ): Container(),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    numberOfParticles: 60,
                    maxBlastForce: 30,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple,
                      Colors.yellow
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _sizeController.dispose();
    _confettiController.dispose();
    super.dispose();
  }
}
