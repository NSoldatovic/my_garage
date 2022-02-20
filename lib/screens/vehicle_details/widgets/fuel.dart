import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FuelMeter extends StatelessWidget {
  final int value;
  FuelMeter({Key? key, required this.value}) : super(key: key);

  void _onFirstRangeColorChanged() {
    _color1 = Colors.red;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSecondRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.red;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onThirdRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.red;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onFourthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.red;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onFifthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.red;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSixthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.red;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSeventhRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.red;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onEighthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.red;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onNinethRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.red;
    _color10 = Colors.black;
  }

  void _onTenthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.red;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.red;
  }

  Color _color1 = Colors.red;
  Color _color2 = Colors.black;
  Color _color3 = Colors.black;
  Color _color4 = Colors.black;
  Color _color5 = Colors.black;
  Color _color6 = Colors.black;
  Color _color7 = Colors.black;
  Color _color8 = Colors.black;
  Color _color9 = Colors.black;
  Color _color10 = Colors.black;

  @override
  Widget build(BuildContext context) {
    if (value >= 0 && value <= 10) {
      _onFirstRangeColorChanged();
    } else if (value >= 10 && value <= 20) {
      _onSecondRangeColorChanged();
    } else if (value >= 20 && value <= 30) {
      _onThirdRangeColorChanged();
    } else if (value >= 30 && value <= 40) {
      _onFourthRangeColorChanged();
    } else if (value >= 40 && value <= 50) {
      _onFifthRangeColorChanged();
    } else if (value >= 50 && value <= 60) {
      _onSixthRangeColorChanged();
    } else if (value >= 60 && value <= 70) {
      _onSeventhRangeColorChanged();
    } else if (value >= 70 && value <= 80) {
      _onEighthRangeColorChanged();
    } else if (value >= 80 && value <= 90) {
      _onNinethRangeColorChanged();
    } else if (value >= 90 && value <= 100) {
      _onTenthRangeColorChanged();
    }

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            startAngle: 180,
            endAngle: 0,
            showTicks: false,
            showAxisLine: false,
            showLabels: false,
            canScaleToFit: true,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: 0,
                  endValue: 10,
                  startWidth: 10,
                  endWidth: 12.5,
                  color: _color1),
              GaugeRange(
                  startValue: 12,
                  endValue: 20,
                  startWidth: 12.5,
                  endWidth: 15,
                  color: _color2),
              GaugeRange(
                  startValue: 22,
                  endValue: 30,
                  startWidth: 15,
                  endWidth: 17.5,
                  color: _color3),
              GaugeRange(
                  startValue: 32,
                  endValue: 40,
                  startWidth: 17.5,
                  endWidth: 20,
                  color: _color4),
              GaugeRange(
                  startValue: 42,
                  endValue: 50,
                  startWidth: 20,
                  endWidth: 22.5,
                  color: _color5),
              GaugeRange(
                  startValue: 52,
                  endValue: 60,
                  startWidth: 22.5,
                  endWidth: 25,
                  color: _color6),
              GaugeRange(
                  startValue: 62,
                  endValue: 70,
                  startWidth: 25,
                  endWidth: 27.5,
                  color: _color7),
              GaugeRange(
                  startValue: 72,
                  endValue: 80,
                  startWidth: 27.5,
                  endWidth: 30,
                  color: _color8),
              GaugeRange(
                  startValue: 82,
                  endValue: 90,
                  startWidth: 30,
                  endWidth: 32.5,
                  color: _color9),
              GaugeRange(
                  startValue: 92,
                  endValue: 100,
                  startWidth: 32.5,
                  endWidth: 35,
                  color: _color10)
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                  value: value.toDouble(),
                  needleEndWidth: 7,
                  needleStartWidth: 1,
                  needleColor: Colors.red,
                  needleLength: 0.85,
                  knobStyle: KnobStyle(color: Colors.black, knobRadius: 0.09))
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Container(
                    child: Image.asset('assets/images/fuel.png',
                        width: 20.0, height: 20.0),
                  ),
                  angle: 85,
                  positionFactor: 0.45),
              GaugeAnnotation(
                  widget: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      'E',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times'),
                    ),
                  ),
                  angle: 175,
                  positionFactor: 1),
              GaugeAnnotation(
                  widget: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      'F',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times'),
                    ),
                  ),
                  angle: 5,
                  positionFactor: 0.95),
            ])
      ],
    );
  }
}
