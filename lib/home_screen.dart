import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';

import 'camera.dart';
import 'bound_box.dart';
import 'models.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;

  HomeScreen(this.cameras);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  double opacityLevel = 1.0;
  String _model = "";
  static const _colors = [
    Colors.yellow,
    Colors.purple,
    Colors.blue,
    Colors.red,
    Colors.pink,
    Colors.yellow,
  ];
  static const _textstyle = TextStyle(
      fontSize: 30,
      //fontWeight: FontWeight.bold,
      fontFamily: 'Horizon');

  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    String result;
    switch (_model) {
      case ssd:
        result = (await Tflite.loadModel(
          model: "assets/ssd_mobilenet.tflite",
          labels: "assets/ssd_mobilenet.txt",
        ))!;
        break;
      case yolo:
        result = (await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        ))!;
        break;
      case mobilenet:
        result = (await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt"))!;
        break;
      default:
        result = (await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite"))!;
        break;
    }
    print(result);
  }

  onSelectModel(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.25);
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Realtime Object Detector"),
      ),
      body: _model == ""
          ? Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Background3.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width / 1.2,
                            color: Colors.greenAccent.withOpacity(0.3),
                            child: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'SSD MobileNet',
                                    textStyle: _textstyle,
                                    speed: Duration(milliseconds: 200),
                                    textAlign: TextAlign.center,
                                    colors: _colors,
                                  )
                                ],
                                repeatForever: true,
                                isRepeatingAnimation: true,
                                onTap: () => onSelectModel(ssd),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width / 1.2,
                            color: Colors.greenAccent.withOpacity(0.3),
                            child: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Tiny YOLOv2',
                                    textStyle: _textstyle,
                                    speed: Duration(milliseconds: 300),
                                    textAlign: TextAlign.center,
                                    colors: _colors,
                                  )
                                ],
                                repeatForever: true,
                                isRepeatingAnimation: true,
                                onTap: () => onSelectModel(yolo),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width / 1.2,
                            color: Colors.greenAccent.withOpacity(0.3),
                            child: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'MobileNet',
                                    textStyle: _textstyle,
                                    speed: Duration(milliseconds: 400),
                                    textAlign: TextAlign.center,
                                    colors: _colors,
                                  )
                                ],
                                repeatForever: true,
                                isRepeatingAnimation: true,
                                onTap: () => onSelectModel(mobilenet),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width / 1.2,
                            color: Colors.greenAccent.withOpacity(0.3),
                            child: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Posenet',
                                    textStyle: _textstyle,
                                    speed: Duration(milliseconds: 500),
                                    textAlign: TextAlign.center,
                                    colors: _colors,
                                  )
                                ],
                                repeatForever: true,
                                isRepeatingAnimation: true,
                                onTap: () => onSelectModel(posenet),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BoundBox(
                  _recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                  _model,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: FloatingActionButton(
                      onPressed: () {
                        _model = "";
                      },
                      child: const Icon(Icons.exit_to_app),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
