part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel viewModel;
  _HomeMobile(this.viewModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: RaisedButton(
          child: Text("SI ZEBI WIN TASKON ?"),
          onPressed: () async {
            final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

            var confirmationResponse = await _bottomSheetService.showBottomSheet(
              title: 'Confirm this action with one of the options below',
              description:
                  'The result from this call will return a SheetResponse object with confirmed set to true. See the logs where we print out the confirmed value for you.',
              confirmButtonTitle: 'I confirm',
              cancelButtonTitle: 'I DONT confirm',
            );

            print('confirmationResponse confirmed: ${confirmationResponse?.confirmed}');
            var logger = Logger();
            logger.wtf("Verbose log");
          },
        ),
      ),
    );
  }
}
