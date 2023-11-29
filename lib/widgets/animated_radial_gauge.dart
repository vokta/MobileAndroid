import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AnimatedRadialGauge extends StatefulWidget {
  final double levelInPercents;

  const AnimatedRadialGauge({required this.levelInPercents});

  @override
  _AnimatedRadialGaugeState createState() => _AnimatedRadialGaugeState();
}

class _AnimatedRadialGaugeState extends State<AnimatedRadialGauge> {
  double _currentLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _currentLevel = widget.levelInPercents;
  }

  @override
  void didUpdateWidget(covariant AnimatedRadialGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.levelInPercents != _currentLevel) {
      setState(() {
        _currentLevel = widget.levelInPercents;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(enableLoadingAnimation: true, axes: <RadialAxis>[
      RadialAxis(
          interval: 20,
          minimum: 0,
          maximum: 100.01,
          startAngle: 160,
          endAngle: 20,
          minorTicksPerInterval: 3,
          minorTickStyle: MinorTickStyle(length: 20),
          majorTickStyle:
              MajorTickStyle(length: 20, thickness: 2, color: Colors.black),
          ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 10,
                color: Color(0xFFEE5555),
                startWidth: 20,
                endWidth: 20),
            GaugeRange(
                startValue: 10,
                endValue: 100,
                color: const Color(0xFF5DCCFC),
                gradient: SweepGradient(
                  colors: [
                    Color.fromARGB(255, 167, 227, 252),
                    Color(0xFF5DCCFC)
                  ],
                ),
                startWidth: 20,
                endWidth: 20)
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: _currentLevel,
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child: Text('$_currentLevel%',
                        style: TextStyle(
                            fontSize: 36.sp, fontWeight: FontWeight.bold))),
                angle: 90,
                positionFactor: 0.5)
          ])
    ]);
  }
}
