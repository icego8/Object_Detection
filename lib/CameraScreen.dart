import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart' as img;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> cameras;
  late Interpreter interpreter;
  bool _isDetecting = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadModel();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );

    await _cameraController.initialize();
    setState(() {});
    _cameraController.startImageStream((image) => _processCameraImage(image));
  }


  Future<void> _loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/model.tflite');
  }

  Future<void> _processCameraImage(CameraImage cameraImage) async {
    if (_isDetecting) return;

    _isDetecting = true;


    img.Image image = _convertCameraImageToImage(cameraImage);

    // Preprocess the image (resize to model input size)
    var input = imageToByteListFloat32(image, 224, 224);  //
    var output = List.filled(10, 0);
    interpreter.run(input, output);

    setState(() {
      _isDetecting = false;
    });
  }

  // Convert the camera image into an Image object (used for processing)
  img.Image _convertCameraImageToImage(CameraImage cameraImage) {
    // Convert the YUV420 image format to RGB
    return img.Image.fromBytes(cameraImage.planes[0].bytes, width: cameraImage.width, height: cameraImage.height);
  }

  // Convert image to a byte list for TensorFlow Lite
  List<int> imageToByteListFloat32(img.Image image, int inputSize, int inputSize2) {
    var convertedBytes = Float32List(inputSize * inputSize2 * 3);
    int pixelIndex = 0;

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize2; x++) {
        var pixel = image.getPixel(x, y);
        convertedBytes[pixelIndex++] = (img.getRed(pixel) / 255.0);
        convertedBytes[pixelIndex++] = (img.getGreen(pixel) / 255.0);
        convertedBytes[pixelIndex++] = (img.getBlue(pixel) / 255.0);
      }
    }
    return convertedBytes;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text('Real-time Object Detection')),
      body: Stack(
        children: [
          CameraPreview(_cameraController),
          // You can add a widget here to show object detection results, like bounding boxes
        ],
      ),
    );
  }
}
