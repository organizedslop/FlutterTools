import "package:flutter/material.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:flutter_tools/utilities/print_utilities.dart";

/**
 *  Debug Utilities
 *  Blake Davis
 *  v1.0.0
 *  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 */




/** ====================================================================================================================
 *  MARK: Debug Utilities
 *  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 */
class DebugUtilitiesUI extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return GestureDetector(
      onTap: () { logPrint("test dfgh sdfg sdfg sdfg dfg dfg fgh "); },
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        height: 100.0, 
        width: double.infinity,
        child: Text("tesert6687tuyghjkiyutrydfghjt", style: TextStyle(fontSize: 12, color: Colors.green))
      )
    );
  }
}

class DebugUtilities {

}


class CustomScaffoldWrapper extends Scaffold {
  final Widget child;

  const CustomScaffoldWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          child: DebugUtilitiesUI(),
        ),
      ],
    );
  }
}