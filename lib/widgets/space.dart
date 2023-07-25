import 'package:flutter/material.dart';

///  Created by bruno on 15/02/2023.
class Space extends StatelessWidget {
  final double space;
  const Space({Key? key, this.space = 0.03}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * space);
  }
}
