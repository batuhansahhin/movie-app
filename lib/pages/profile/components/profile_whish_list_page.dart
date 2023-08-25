import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/data_provider.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/components/home_page_components/custom_stack_widget.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late DataProvider wishlistProvider;
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  Future<void> initPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveWishlist(List<String> wishlist) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('wishlist', wishlist);
  }

  Future<List<String>> loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('wishlist') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    wishlistProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: customAppbar(context, projectName),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: wishlistProvider.wishlist.length,
        itemBuilder: (context, index) {
          String movieInfo = wishlistProvider.wishlist[index];
          List<String> movieInfoParts = movieInfo.split('|');

          if (movieInfoParts.length >= 2) {
            String movieTitle = movieInfoParts[0];
            String posterPath = movieInfoParts[1];

            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  wishlistProvider.removeFromWishlist(index);
                });
                saveWishlist(wishlistProvider.wishlist);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
              child: Card(
                elevation: 2,
                color: const Color.fromARGB(255, 236, 236, 236),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w200/$posterPath',
                        fit: BoxFit.cover,
                        height: 65,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                movieTitle,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Text(
                  "Geçersiz film bilgisi",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
