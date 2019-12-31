import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class CardSwiper extends StatelessWidget {

  final List<Movie> peliculas;

  CardSwiper({ @required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //width: double.infinity,
      //height: 300.0,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight:_screenSize.height * 0.5,
        //itemWidth: 200.0,
        itemBuilder: (BuildContext context,int index){

          peliculas[index].uniqueId = '${peliculas[index].id}-card';

          return Hero(

            tag: peliculas[index].uniqueId,
            child: ClipRRect(

              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: ()=>Navigator.pushNamed(context, 'detail', arguments: peliculas[index]),
                child: FadeInImage(
                    placeholder: AssetImage('asset/img/no-image.jpg'),
                    image: NetworkImage(peliculas[index].getPosterImg()),
                  fit: BoxFit.cover,
                ),
              ),

            ),
          );

        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),

      ),
    );
  }
}
