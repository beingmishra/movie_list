import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_list/controllers/movie_data_controller.dart';
import 'package:movie_list/screens/movie_details.dart';

class Homepage extends StatelessWidget {

  final movieDataController = Get.put(MovieDataController());

  Homepage({super.key});

  // creating widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Movies',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<MovieDataController>(
          init: movieDataController,
          builder: (controller) => Column(
        children: [
          controller.data.isEmpty ? Expanded(
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Center(
                    child: Column(
                      children: [
                        Image.asset('images/empty.png'),
                        const Text(
                          'No data found',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    )),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ) : Expanded(
            // Using Gridview builder to build widget as per index basis on demand
            child: ListView.separated(
              itemBuilder: (context, i) => GestureDetector(
                onTap: () {
                  // navigate to next screen to read note in full length
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return MovieDetails(isNew: false, movie: controller.data[i],);
                      }));
                },
                child: Dismissible(
                  key: Key(controller.data[i].id.toString()),
                  background: const SizedBox(),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(Icons.delete, color: Colors.white,),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      controller.deleteItem(controller.data[i].id.toString());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleted ${controller.data[i].title}'),
                        ),
                      );
                      return true;
                    }
                    return null;
                  },
                  onDismissed: (_) {
                    controller.data.removeAt(i);
                  },
                  child: ListTile(
                    leading: const SizedBox(
                        height: double.infinity,
                        child: Icon(Icons.movie, size: 24,)),
                    title: Text(controller.data[i].title),
                    subtitle: Text('Directed by ${controller.data[i].director}'),
                    trailing: Text(controller.data[i].year),
                  ),
                ),
              ),
              itemCount: controller.data.length,
              shrinkWrap: true, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
            ),
          )
        ],
      )),

      // FAB button to add notes
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MovieDetails(isNew: true)));
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }
  
}

