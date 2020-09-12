import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class MainCollapsingToolbar extends StatefulWidget {
  String header = '';
  double expandleHeight = 180.0;

  Image imageHeader = Image.asset("assets/teamwin.jpg",
      fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter);
 Widget body;
  String titleMain = "Название";
  Widget leadingWidget;

  bool centerTitile = true;
  bool ligthTitlemode = false;
  int initialPageIndex;

  MainCollapsingToolbar(
      {Key key,
      this.header,
      this.body,
      this.titleMain,
      this.imageHeader,
      this.expandleHeight = 180.0,
      this.leadingWidget,
      this.centerTitile = true,
      this.ligthTitlemode = false, this.initialPageIndex = 0})
      : super(key: key);

  @override
  _MainCollapsingToolbarState createState() => _MainCollapsingToolbarState();
}

class _MainCollapsingToolbarState extends State<MainCollapsingToolbar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          new SliverOverlapAbsorber(
            handle:
            NestedScrollView.sliverOverlapAbsorberHandleFor(context),
               sliver:           SliverAppBar(
        leading: widget.leadingWidget,
        expandedHeight: widget.expandleHeight,
        floating: true,
        pinned: false,
        flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        centerTitle: widget.centerTitile,
        title: Container(

        ),
        background: widget.imageHeader),
        ),
          ),

          SliverPersistentHeader(
            delegate: _SliverSingleTabDelegate(),
            pinned: true,
          )

        ];
      },
      body:
//      (widget.pages.length > 1)? TabBarView(
//        controller: widget.tabcontroller,
//        children: widget.pages.map(
//              (page) => SafeArea(
//            top: false,
//            bottom: false,
//            child: new Builder(
//              builder: (context) {
//                return _buildTabBarView(context, page);
//              },
//            ),
//          ),
//        )
//            .toList(),
//      ) :
      widget.body,
    )
    ,);
  }

  Widget _buildTabBarView(BuildContext context, Widget page) {
    List<Widget> slivers = new List<Widget>();

    slivers.add(new SliverObstructionInjector(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)));
    slivers.add(page);

    return page;

//      CustomScrollView(
//      key: PageStorageKey<Widget>(page),
//      slivers: slivers,
//    );
  }


  List<Tab> stringToTabs(List<String> _headers) {
    List<Tab> list = List<Tab>();
    for (var n in _headers) {
      list.add(Tab(text: n));
    }
    return list;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _SliverSingleTabDelegate extends SliverPersistentHeaderDelegate {
  _SliverSingleTabDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: null,
    );
  }

  @override
  bool shouldRebuild(_SliverSingleTabDelegate oldDelegate) {
    return false;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 0;

  @override
  // TODO: implement minExtent
  double get minExtent => 0;
}
class SliverObstructionInjector extends SliverOverlapInjector {
  /// Creates a sliver that is as tall as the value of the given [handle]'s
  /// layout extent.
  ///
  /// The [handle] must not be null.
  const SliverObstructionInjector({
    Key key,
    @required SliverOverlapAbsorberHandle handle,
    Widget child,
  })  : assert(handle != null),
        super(key: key, handle: handle, sliver: child);

  @override
  RenderSliverObstructionInjector createRenderObject(BuildContext context) {
    return new RenderSliverObstructionInjector(
      handle: handle,
    );
  }
}
class RenderSliverObstructionInjector extends RenderSliverOverlapInjector {
  /// Creates a sliver that is as tall as the value of the given [handle]'s extent.
  ///
  /// The [handle] must not be null.
  RenderSliverObstructionInjector({
    @required SliverOverlapAbsorberHandle handle,
    RenderSliver child,
  })  : assert(handle != null),
        _handle = handle,
        super(handle: handle);

  double _currentLayoutExtent;
  double _currentMaxExtent;

  /// The object that specifies how wide to make the gap injected by this render
  /// object.
  ///
  /// This should be a handle owned by a [RenderSliverOverlapAbsorber] and a
  /// [RenderNestedScrollViewViewport].
  SliverOverlapAbsorberHandle get handle => _handle;
  SliverOverlapAbsorberHandle _handle;

  set handle(SliverOverlapAbsorberHandle value) {
    assert(value != null);
    if (handle == value) return;
    if (attached) {
      handle.removeListener(markNeedsLayout);
    }
    _handle = value;
    if (attached) {
      handle.addListener(markNeedsLayout);
      if (handle.layoutExtent != _currentLayoutExtent ||
          handle.scrollExtent != _currentMaxExtent) markNeedsLayout();
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    handle.addListener(markNeedsLayout);
    if (handle.layoutExtent != _currentLayoutExtent ||
        handle.scrollExtent != _currentMaxExtent) markNeedsLayout();
  }

  @override
  void performLayout() {
    _currentLayoutExtent = handle.layoutExtent;
    _currentMaxExtent = handle.layoutExtent;
    geometry = new SliverGeometry(
      scrollExtent: 0.0,
      paintExtent: _currentLayoutExtent,
      maxPaintExtent: _currentMaxExtent,
    );
  }
}
