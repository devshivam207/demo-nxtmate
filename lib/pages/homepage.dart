import 'package:flutter/material.dart';
import 'package:nxtmate/models/model.dart';
import 'package:nxtmate/repo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Repository repository = Repository();
  late List<Student> nameData;
  late List<Student> classNumberData;

  final int initialItemCount = 15;
  int currItemCount = 0;
  int totalItemCount = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    nameData = [];
    classNumberData = [];
    _loadData();
  }

  Future<void> _loadData() async {
    // Simulate a delay for loading data
    await Future.delayed(Duration(seconds: 1));

    List<Student> allData = await repository.getlist();
    totalItemCount = allData.length;
    currItemCount += initialItemCount;
    setState(() {
      nameData = List.from(allData.take(initialItemCount));
      classNumberData = List.from(allData.take(initialItemCount));
    });
  }

  Future<void> _loadMoreData(String tabType) async {
    // Simulate a delay for loading more data
    await Future.delayed(Duration(seconds: 1));

    List<Student> allData = await repository.getlist();
    currItemCount += initialItemCount;
    setState(() {
      if (tabType == 'name') {
        nameData = List.from(allData.take(nameData.length + initialItemCount));
      } else {
        classNumberData =
            List.from(allData.take(classNumberData.length + initialItemCount));
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NXTMATE",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          // About section
          Container(
            height: 134,
            width: double.maxFinite,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo, width: 4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to NXTMATE",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Explore a virtual space where students and teachers connect seamlessly, fostering a dynamic and engaging educational journey.....",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Tab section
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.maxFinite,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Class Number",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.indigo,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildTabContent(context, 'name', nameData),
                        _buildTabContent(
                            context, 'classNumber', classNumberData),
                      ],
                    ),
                  ),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(
      BuildContext context, String tabType, List<Student> data) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          // Load more data when the user reaches the end
          if (!isLoading) {
            setState(() {
              isLoading = true;
            });
            _loadMoreData(tabType);
          }
        }
        return true;
      },
      child: ListView.builder(
        itemCount: data.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == data.length) {
            return SizedBox
                .shrink(); // Empty widget to reserve space for the loading indicator
          }
          return Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 35,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                (tabType == 'name')
                    ? data[index].name ?? ""
                    : data[index].className ?? "",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
