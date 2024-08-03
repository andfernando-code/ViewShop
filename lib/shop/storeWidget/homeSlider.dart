import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlider;
  final List<String> imagePaths;
  const HomeSlider({super.key, required this.onChange, required this.currentSlider, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: PageView.builder(
                      onPageChanged: onChange,
                      itemCount: 3,
                      itemBuilder: (context, index){
                      return Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(imagePaths[index]),
                          ),
                        ),
                      );
                    }),
                  ),

                  Positioned.fill(
                    bottom: 10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4, 
                          (index) => AnimatedContainer(
                            duration: const Duration(microseconds: 3000,),
                            width: currentSlider==index?15:8,
                            height: 8,
                            margin: EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentSlider==index? Colors.black : Colors.white,
                              border: Border.all(color: Colors.black)
                            ), 
                            ),
                          ),
                      ),
                    )
                    ),
                ],
              );
  }
}