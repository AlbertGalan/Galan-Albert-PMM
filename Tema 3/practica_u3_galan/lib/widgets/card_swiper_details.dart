import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiperDetails extends StatelessWidget {
  final List<String> imageUrls;

  const CardSwiperDetails({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: 350.0,
      child: Swiper(
        itemCount: imageUrls.length,
        layout: SwiperLayout.DEFAULT,
        itemWidth: MediaQuery.of(context).size.width * 1,
        itemHeight: MediaQuery.of(context).size.height * 1,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 10.0),
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.red,
            color: Colors.grey,
          ),
        ),
        itemBuilder: (BuildContext context, int index) {
          final label = index == 0 ? 'Normal' : 'Shiny';
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                  height: 250.0,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}
