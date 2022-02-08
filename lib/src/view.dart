import 'package:ball_demo/src/model.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ball Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyAnimatedView(),
    );
  }
}

class MyAnimatedView extends StatefulWidget {
  const MyAnimatedView({Key? key}) : super(key: key);

  @override
  _MyAnimatedViewState createState() => _MyAnimatedViewState();
}

class _MyAnimatedViewState extends State<MyAnimatedView> {
  final balls = [Ball.random()];

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (int i = 0; i < balls.length; i++) {
      children.add(BallWidget(
        key: ValueKey(i),
        ball: balls[i],
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Ball Animation Demo'),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              balls.clear();
            }),
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Stack(
        children: children,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          balls.add(Ball.random());
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}

class BallWidget extends StatefulWidget {
  final Ball ball;
  const BallWidget({Key? key, required this.ball}) : super(key: key);

  @override
  _BallWidgetState createState() => _BallWidgetState();
}

class _BallWidgetState extends State<BallWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(
      () => setState(() {
        widget.ball.current = _animation.value;
      }),
    );
    _controller.addStatusListener(
      (status) {
        final ball = widget.ball;
        if (status == AnimationStatus.completed) {
          ball.bouncing();
          _runAnimation();
        }
      },
    );
    _runAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ball = widget.ball;
    return Align(
      alignment: ball.current,
      child: Container(
        width: ball.radius * 2,
        height: ball.radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ball.color,
        ),
      ),
    );
  }

  void _runAnimation() {
    final ball = widget.ball;
    _animation = _controller.drive(
      AlignmentTween(
        begin: ball.current,
        end: ball.target,
      ),
    );
    _controller.reset();
    _controller.duration =
        Duration(milliseconds: (ball.velocity * 1000).toInt());
    _controller.forward();
  }
}
