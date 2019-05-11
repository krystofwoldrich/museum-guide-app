import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/model/SearchResult.dart';
import 'package:museum_guide_app/theme/theme.dart';
import 'package:museum_guide_app/widgets/Section.dart';
import 'package:museum_guide_app/widgets/cards/ExhibitionCard.dart';

import '../../actions/search.dart' show getSearchResults;

import 'package:museum_guide_app/characterStyles/ScreenTitle.dart';
import 'package:museum_guide_app/screens/search/SearchResults.dart';

class Search extends StatefulWidget {

  Search({Key key}): super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: ListView(
        children: <Widget>[
          ScreenTitle('Search'),
          SearchField(),
          SearchByQrCodeButton(
            onPressed: (String qrCode) {
              this._onQrCodeScan(context, qrCode);
            },
          ),
          this._getLastResults(context),
        ],
      ),
    );
  }

  void _onQrCodeScan(BuildContext context, String codeData) {
    if (codeData == null || codeData == "") {
      return;
    }

    StoreProvider.of<AppState>(context).dispatch(getSearchResults(codeData));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchResults(),
    ));
  }

  Widget _getLastResults(BuildContext context) {
    return StoreConnector<AppState, List<SearchResult>>(
      converter: (store) => store.state.search.results,
      builder: (_, List<SearchResult> searchResults) {
        return Section(
          title: 'Last results',
          content: searchResults.map((SearchResult result) => ExhibitionCard(
            id: result.id,
            title: result.title,
            description: result.description,
          )).toList(),
        );
      },
    );
  }
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onSubmitted: (String searchValue) => this._onSubmittedTextField(context, searchValue),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      margin: EdgeInsets.only(left: layoutMarginLeft, right: layoutMarginRight),
    );
  }

  void _onSubmittedTextField(BuildContext context, String value) {
    if (value == "") {
      return;
    }

    StoreProvider.of<AppState>(context).dispatch(getSearchResults(value));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchResults(),
    ));
  }
}

class SearchByQrCodeButton extends StatelessWidget {
  final Function onPressed;

  SearchByQrCodeButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('Scan QR code'),
        onPressed: () => this._scanQrCode(context),
      ),
      margin: EdgeInsets.only(left: layoutMarginLeft, right: layoutMarginRight),
    );
  }

  Future _scanQrCode(BuildContext context)  async {
    try {
      String barcode = await BarcodeScanner.scan();
      print(barcode);
      this.onPressed(barcode);
    } catch (e) {
      print(e);
      this.onPressed(null);
    }
  }
}
