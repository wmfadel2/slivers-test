import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MultiSliver(children: [
            MultiSliver(
              pushPinnedChildren: false,
              children: <Widget>[
                SliverPinnedHeader(
                  child: Container(color: Colors.green, height: 100),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: SliverPersistantContainerHeaderDelegate(
                    child: Container(color: Colors.blue, height: 100),
                    maxExtent: 132,
                  ),
                ),
                SliverPinnedHeader(
                  child: Container(color: Colors.yellow, height: 52),
                ),
                SliverStack(
                  insetOnOverlap: true,

                  children: [
                    SliverPositioned.fill(
                      child: Container(
                        margin: const EdgeInsets.only(top: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 10,
                              spreadRadius: 4,
                              color: Colors.black26,
                            )
                          ],
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    MultiSliver(
                      children: [
                        SliverPinnedHeader(
                          child: Container(
                            height: 52,
                            margin: const EdgeInsets.only(top: 24),
                          )
                        ),
                        SliverClip(
                          clipOverlap: true,
                          child: SliverAnimatedPaintExtent(
                            duration: const Duration(seconds: 3),
                            child: SliverList(
                              delegate: SliverChildListDelegate(
                                List.generate(
                                  100,
                                      (index) => Container(
                                    height: 100,
                                    margin: const EdgeInsets.all(16),
                                    color:
                                    Colors.primaries[index % Colors.primaries.length],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ])
        ],
      ),
    );
  }
}

class SliverPersistantContainerHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final Widget child;
  @override
  final double maxExtent;
  @override
  final double minExtent;

  SliverPersistantContainerHeaderDelegate({
    required this.child,
    required this.maxExtent,
    this.minExtent = 0.0,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedOverflowBox(
      size: Size.fromHeight(
          (maxExtent - shrinkOffset).clamp(minExtent, maxExtent).toDouble()),
      child: child,
    );
  }

  @override
  bool shouldRebuild(SliverPersistantContainerHeaderDelegate oldDelegate) {
    return child != oldDelegate.child ||
        maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent;
  }
}
