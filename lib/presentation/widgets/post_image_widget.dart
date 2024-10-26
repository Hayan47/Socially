import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socially/presentation/themes/app_colors.dart';
import 'package:socially/presentation/widgets/photo_view.dart';

class PostImage extends StatelessWidget {
  final List<String> imagesUrls;
  final _controller = PageController();

  PostImage({super.key, required this.imagesUrls});

  @override
  Widget build(BuildContext context) {
    final isBigWidth = MediaQuery.sizeOf(context).width > 600;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = width * 0.7;
        //! No Pictures
        if (imagesUrls.isEmpty) {
          return Container();
        } else {
          //! 2 Or More Pictures
          if (imagesUrls.length > 1) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: width,
                height: height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(23),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView(
                        controller: _controller,
                        children: List.generate(
                          imagesUrls.length,
                          (index) => GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return PhotoViewPage(
                                    imagesUrl: imagesUrls,
                                    initialIndex: index,
                                  );
                                },
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: imagesUrls[index],
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: const Alignment(0, 0.95),
                        child: SmoothPageIndicator(
                          effect: const ExpandingDotsEffect(
                            activeDotColor: AppColors.white,
                            dotColor: Colors.white,
                            dotHeight: 5,
                            dotWidth: 5,
                          ),
                          count: imagesUrls.length,
                          controller: _controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            //! 1 Pictures
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PhotoViewPage(
                          imagesUrl: imagesUrls,
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: CachedNetworkImage(
                      imageUrl: imagesUrls.first,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
