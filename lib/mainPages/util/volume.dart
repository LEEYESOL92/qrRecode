import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Volume extends StatefulWidget {
  Volume({Key? key}) : super(key: key);

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  double currentvol = 40;

  @override
  void initState() {
    PerfectVolumeControl.hideUI = true;
    // false; //set if system UI is hided or not on volume up/down
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
    });

    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentvol = volume;
      });
    });
    super.initState();
  }

  Future<void> initVolumeState() async {
    PerfectVolumeControl.hideUI = false;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 100.0,
          height: 150.0,
          child: SfSlider.vertical(
            onChanged: (newvol) {
              currentvol = newvol;
              PerfectVolumeControl.setVolume(newvol);
              setState(() {});
            },
            min: 0.0,
            max: 1.0,
            value: currentvol,
            interval: 20,
          ),
        ));
  }
}
