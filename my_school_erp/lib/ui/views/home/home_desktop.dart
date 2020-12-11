part of home_view;
class _HomeDesktop extends StatelessWidget {
  final HomeViewModel viewModel;
  _HomeDesktop(this.viewModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desktop'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
       
      ),
      
    );
  }
}