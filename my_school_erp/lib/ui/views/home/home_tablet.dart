part of home_view;
class _HomeTablet extends StatelessWidget {
  final HomeViewModel viewModel;
  _HomeTablet(this.viewModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tablet'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        
      ),
      
    );
  }
}
