import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Model.dart';
import 'package:movie_app/Services/services.dart';

class Homescereen extends StatefulWidget {
  const Homescereen({super.key});

  @override
  State<Homescereen> createState() => _HomescereenState();
}

class _HomescereenState extends State<Homescereen> {
  late Future<List<Movie>> nowShowing;
  late Future<List<Movie>> upComing;
  late Future<List<Movie>> popularMovies;

  @override
  void initState() {
    // TODO: implement initState
    nowShowing = ApiServices().getNowShowing();
    upComing = ApiServices().getUpComing();
    popularMovies = ApiServices().getPopular();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Movie app",
            style: GoogleFonts.oswald(
                textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          
          centerTitle: true,
          leading: Icon(Icons.menu),
          actions: [Row(children: [
            Icon(Icons.search),
            SizedBox(width: 12,),
            Icon(Icons.notifications),
          ],)
            
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Now Showing",
                  style: GoogleFonts.aclonica(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: nowShowing,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final movies = snapshot.data!;
                      return CarouselSlider.builder(
                          itemCount: movies.length,
                          itemBuilder: (context, index, movieIndex) {
                            final movie = movies[index];
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                        fit: BoxFit.cover,
                                      ),
                                      ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    movie.title,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: GoogleFonts.abel(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 1.7,
                            autoPlayInterval: Duration(seconds: 4),
                          ));
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                    "Up Coming",
                      style: GoogleFonts.aclonica(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                    height: 10,
                    ),
                    Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 250,
                    child: FutureBuilder(
                      future: upComing,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final movies = snapshot.data!;
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return Stack(
                                children: [
                                  Container(
                                    width: 180,
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                   Positioned(
                                    bottom: 15,
                                    left: 0,
                                    right: 0,
                                    child: Text(
                                      movie.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                   const SizedBox(height: 10),
                  Text(
                  "Popular",
                  style: GoogleFonts.aclonica(
                      textStyle:
                          TextStyle(fontSize: 18, 
                          fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 250,
                    child: FutureBuilder(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final movies = snapshot.data!;
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return Stack(
                                children: [
                                  Container(
                                    width: 180,
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 0,
                                    right: 0,
                                    child: Text(
                                      movie.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                            );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
