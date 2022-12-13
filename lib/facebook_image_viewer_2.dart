library facebook_image_viewer_2;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_image_viewer_2/arrow_back_widget.dart';
import 'package:facebook_image_viewer_2/busy_overlay_widget.dart';
import 'package:facebook_image_viewer_2/facebook_image_viewer_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// facebook image viewer till now works only with network images
/// it required image link as a parameter
///
/// This package gives the ability of double taping to zoom in image
/// traditional image zooming
/// swipe top or down to close the screen
class FacebookImageView extends StatefulWidget {
  final String image;

  const FacebookImageView({Key? key, required this.image}) : super(key: key);

  @override
  State<FacebookImageView> createState() => _FacebookImageViewState();
}

class _FacebookImageViewState extends State<FacebookImageView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<facebookImagerViewModel>.reactive(
      viewModelBuilder: () => facebookImagerViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) => WillPopScope(
        onWillPop: () => model.popRouteName(context),
        child: BusyOverlay(
            show: model.isBusy,
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                leading: LeftArrow(
                  onTap: () => {
                    model.returnToPreviousPage(context),
                  },
                ),
              ),
              body: Stack(
                children: [
                  InteractiveViewer(
                    transformationController: model.controller,
                    //panEnabled: false,
                    //scaleEnabled: false,
                    clipBehavior: Clip.none,
                    //constrained: false,
                    onInteractionUpdate: (update) {
                      model.setBoxFit(
                          model.controller.value.getMaxScaleOnAxis());
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onDoubleTapDown: (detail) {
                        model.tapLocation(detail);
                      },
                      onDoubleTap: () {
                        model.userStartZooming();
                      },
                      child: IgnorePointer(
                        ignoring: model.isscaling,
                        child: GestureDetector(
                          onVerticalDragEnd: (drag) =>
                              model.returnToPreviousPage(context),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: CachedNetworkImage(
                              imageUrl: widget.image,
                              fit: model.isscaling
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                              placeholder: (context, url) => Container(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
