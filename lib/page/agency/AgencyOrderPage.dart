import 'package:house/importLib.dart';

class AgencyOrderPage extends BaseStatefulWidget {
  @override
  _AgencyOrderPageState createState() => _AgencyOrderPageState();
}

class _AgencyOrderPageState extends BaseAppBarAndBodyState<AgencyOrderPage> {
  bool _isShowPop = false;
  TypeStatus _curTypeStatus = TypeStatus.orderWaiting;

  @override
  BaseAppBar appBar(BuildContext context) {
    return TitleAppBar(
      context: context,
      title: TitleAppBar.appBarTitle(
        HouseValue.of(context).orders,
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTypeStatus(context),
        Expanded(
          child: Stack(
            children: <Widget>[
              OrdersHome(status: _curTypeStatus.value),
              _buildPop(),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildTypeStatus(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: HouseColor.lightGray,
        onPressed: () {
          _isShowPop = !_isShowPop;
          setState(() {});
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  _curTypeStatus.descEn,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: createTextStyle(fontFamily: fontFamilySemiBold),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Transform.rotate(
              angle: _isShowPop ? pi : pi + pi / 2,
              child: Icon(
                HouseIcons.backIcon,
                color: HouseColor.gray,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPop() {
    if (_isShowPop) {
      return GestureDetector(
        child: Container(
          color: Color(0x30000000),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return Container(
                      height: 48,
                      decoration: BoxDecoration(
                          color: HouseColor.white,
                          border: Border(
                            bottom: BorderSide(
                              color: HouseColor.divider,
                              width: 0.5,
                            ),
                          )),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        onPressed: () {
                          _curTypeStatus = TypeStatus.orderStatus[index];
                          _isShowPop = false;
                          setState(() {});
                        },
                        child: Text(
                          TypeStatus.orderStatus[index].descEn,
                          style: createTextStyle(
                            color:
                                _curTypeStatus == TypeStatus.orderStatus[index]
                                    ? HouseColor.green
                                    : HouseColor.black,
                            fontSize: 15,
                            fontFamily: fontFamilySemiBold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  childCount: TypeStatus.orderStatus.length,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          _isShowPop = false;
          setState(() {});
        },
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
