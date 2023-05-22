import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_list/controllers/movie_data_controller.dart';
import 'package:movie_list/model/movie_model.dart';

class MovieDetails extends StatefulWidget {
  final Movie? movie;
  final bool isNew;
  const MovieDetails({Key? key, required this.isNew, this.movie,}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  final movieNameController = TextEditingController();
  final movieDirectorController = TextEditingController();
  final movieYearController = TextEditingController();

  var controller = Get.put(MovieDataController());

  @override
  void initState() {
    super.initState();

    if(!widget.isNew){
      movieNameController.text = widget.movie!.title;
      movieDirectorController.text = widget.movie!.director;
      movieYearController.text = widget.movie!.year;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 48,
                ),
                const Text('Movie details', style: TextStyle(color: Colors.black, fontSize: 28),),
                const SizedBox(
                  height: 32,
                ),
                const SizedBox(
                  height: 12,
                ),
                buildTextField(title: 'Enter movie name', textController: movieNameController, isNumber: false),
                const SizedBox(
                  height: 12,
                ),
                buildTextField(title: 'Enter director name', textController: movieDirectorController, isNumber: false),
                const SizedBox(
                  height: 12,
                ),
                buildTextField(title: 'Enter releasing year', textController: movieYearController, isNumber: true),
                const SizedBox(
                  height: 12,
                ),
                Container(
                    height: 46,
                    width: double.infinity,
                    margin: const EdgeInsets.all(12),
                    child: ElevatedButton(
                      onPressed: () async {
                        if(widget.isNew){
                         controller.insertData(
                           movieNameController.text,
                           movieDirectorController.text,
                           movieYearController.text,
                         context);
                        }else{
                          controller.updateData(widget.movie!.id.toString(),
                              movieNameController.text,
                              movieDirectorController.text,
                              movieYearController.text, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        widget.isNew ? 'Add' : 'Update',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      {required title, required TextEditingController textController, required bool isNumber}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 8,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            )
          ]),
      child: TextField(
        controller: textController,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: 1,
        maxLength: isNumber ? 4 : null,
        decoration: InputDecoration(
          hintText: title,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

