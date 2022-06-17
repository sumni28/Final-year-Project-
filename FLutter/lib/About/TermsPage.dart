import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                          Icons.keyboard_arrow_left_outlined
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Terms and Conditions",
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),

                Container(
                  child: Text(
                      "sdxgfcghjhkjlouiyukyjfthdgxcjko;ljkhgjf"
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
