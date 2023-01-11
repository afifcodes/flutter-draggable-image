import 'package:flutter/material.dart';
import 'package:flutter_draggable_image/utils/system_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String them_url =
      'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=689&q=80';
  String me_url =
      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80';

  bool isDrag = false;
  double PADDING_SIDE = 24;
  double PADDING_TOP = 96;
  double HEIGHT = 144;
  double WIDTH = 96;
  Map<String, double> pos = {'top': 96, 'left': 24};

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'End-to-End Encrypted',
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  //
  // @afifcodes
  // afifcodes.vercel.app/flutter
  //

  @override
  Widget build(BuildContext context) {
    systemUi();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: appBar(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(them_url), fit: BoxFit.cover)),
          ),
          AnimatedPositioned(
            top: pos['top'],
            left: pos['left'],
            duration: Duration(milliseconds: isDrag ? 0 : 300),
            child: Draggable(
              onDragStarted: () {
                setState(() {
                  isDrag = true;
                });
              },
              onDragUpdate: (details) {
                setState(() {
                  pos = {
                    'left': pos['left']! + details.delta.dx,
                    'top': pos['top']! + details.delta.dy,
                  };
                });
              },
              onDragEnd: ((details) {
                double width = MediaQuery.of(context).size.width;
                double height = MediaQuery.of(context).size.height;
                setState(() {
                  isDrag = false;
                  pos = {
                    'left': pos['left']! <
                            (width - (WIDTH / 2) - (PADDING_SIDE * 2)) / 2
                        ? PADDING_SIDE
                        : width - WIDTH - PADDING_SIDE,
                    'top': pos['top']! <
                            (height - (HEIGHT / 2) - (PADDING_SIDE * 2)) / 2
                        ? PADDING_TOP
                        : height - HEIGHT - PADDING_SIDE
                  };
                });
              }),
              feedback: callView(url: me_url),
              child: isDrag ? SizedBox() : callView(url: me_url),
            ),
          ),
        ],
      ),
    );
  }
}

Widget callView({url}) {
  return Container(
    height: 144,
    width: 96,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 24,
          )
        ]),
  );
}
