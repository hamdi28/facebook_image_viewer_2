import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class facebookImagerViewModel extends BaseViewModel {
  ///transform controller for the InteractiveViewer widget
  final TransformationController controller = new TransformationController();

  /// a bool variable which indicate if the user is scaling
  bool _isscaling = false;

  bool get isscaling => _isscaling;

  /// scale percentage [1==100%]
  double _scale = 2;

  double get scale => _scale;

  ///this variable contain the zoom value calculation result
  late Matrix4 zoomed;
  late Matrix4 end;

  /// position where the user has tapped
  late TapDownDetails tapdetail;

  /// animation controller
  late AnimationController animationcontroller;

  /// initialise the animation controller
  void init() {}

  ///when this methode is called if the user is not zooming in it
  /// zoom on the position where the user has tapped on
  /// else it show the image to the original size also
  /// it update scaling state
  void userStartZooming() {
    userScaleState();
    var x = -tapdetail.localPosition.dx * (_scale - 1);
    var y = -tapdetail.localPosition.dy * (_scale - 1);
    zoomed = Matrix4.identity()
      ..translate(x, y)
      ..scale(_scale);

    controller.value =
    controller.value.isIdentity() ? zoomed : Matrix4.identity();

    setBoxFit(controller.value.getMaxScaleOnAxis());

    notifyListeners();
  }

  ///this methode is called to get position
  ///where the user has tapped it take TapDownDetails
  ///as a parameter
  void tapLocation(TapDownDetails detail) {
    tapdetail = detail;
    notifyListeners();
  }

  ///this methode is used to indicate if the user is currently
  ///zooming on the image
  void userScaleState() {
    _isscaling = !_isscaling;
    notifyListeners();
  }

  Future<bool> returnToPreviousPage(BuildContext context) async {
    Navigator.pop(context);
    return true;
  }

  ///same for other apps if the user is already zooming on the image
  ///and he press the system back button the screen will not close but the image
  ///will be resized to the original size a
  Future<bool> popRouteName(BuildContext context) async {
    if (_isscaling == true) {
      _isscaling = false;
      controller.value = Matrix4.identity();
      notifyListeners();
      return false;
    } else {
      Navigator.pop(context);
      return true;
    }
  }

  ///this method is called to update Boxfit value
  ///
  ///
  /// it take a [scale] and by testing on the scale value we can detect if the user is currently
  /// scaling or not and depending on this value we toggle Boxfit between cover and contain also
  /// in case if user zoom out we reset the value of the controller
  void setBoxFit(double scale) {
    if (scale > 1.0) {
      _isscaling = true;
    } else {
      _isscaling = false;
      controller.value = Matrix4.identity();
    }
    notifyListeners();
  }
}