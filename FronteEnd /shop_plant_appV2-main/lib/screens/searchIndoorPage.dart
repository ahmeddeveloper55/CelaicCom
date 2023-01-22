import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Provider/greenProvider.dart';
import '../Provider/indoorProvider.dart';
import '../model/greenModel.dart';
import '../model/indoormodel.dart';
import 'indoor_Details.dart';

class searchIndoorPage extends StatefulWidget {
  const searchIndoorPage({Key? key}) : super(key: key);

  @override
  State<searchIndoorPage> createState() => _searchIndoorPageState();
}

class _searchIndoorPageState extends State<searchIndoorPage> {
  List<indoormodel> _searchList = [];
  List<indoormodel> _userList = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    final providermodel = Provider.of<indoorProvider>(context, listen: false);
    providermodel.getAllIndoorPlants(_userList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      Expanded(
                        child: Container(
                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                  filled: false,
                                ),
                                onChanged: onChangedtext,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  controller.clear();
                                  onChangedtext('');
                                },
                                icon: Icon(Icons.cancel),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _searchList.isNotEmpty || controller.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Center(
                                child: Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => indoor_Details(
                                            plant1: _searchList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Hero(
                                            tag: _searchList[index].title!,
                                            child: Image.network(
                                                _searchList[index].image!),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            _searchList[index].title!,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Text(
                                              _searchList[index].discription!,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "\$${_searchList[index].price}",
                                                style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextButton(
                                                child: Text(
                                                  "+",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                ),
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          // ) :
                          )
                      : Container(
                          child: Center(
                            child: Text('No Items Found'),
                          ),
                        ),
                ),
              ],
            )),
      ),
    );
  }

  onChangedtext(String s) async {
    _searchList.clear();
    if (s.isEmpty) {
      setState(() {});
      return;
    }
    _userList.forEach((user) {
      if (user.title!.contains(s) ||
          user.discription!.contains(s) ||
          user.price!.contains(s)) {
        _searchList.add(user);
      }
    });
    setState(() {});
  }
}
