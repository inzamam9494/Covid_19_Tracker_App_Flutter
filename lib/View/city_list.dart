import 'package:covid_19_tracker_app/Model/world_state_model.dart';
import 'package:covid_19_tracker_app/Services/Utilites/states_services.dart';
import 'package:covid_19_tracker_app/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      suffixIcon: const Icon(Icons.search),
                      hintText: 'Search The CITY',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: stateServices.cityListApi(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index){
                          return Shimmer.fromColors(
                               baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [ListTile(
                                title: Container(height: 10, width: 89, color: Colors.white),
                                subtitle: Container(height: 12, width: 89, color: Colors.white),
                              ),
                              ],
                            )
                          );
                        });
                  }
                  else{
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                        String city = snapshot.data![index]['loc'];

                        if(searchController.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    city: snapshot.data![index]['loc'],
                                    total: snapshot.data![index]['totalConfirmed'],
                                    recovered: snapshot.data![index]['discharged'],
                                    death: snapshot.data![index]['deaths'],
                                  )));
                                },
                                child: ListTile(
                                title: Text(snapshot.data![index]['loc'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text(snapshot.data![index]['totalConfirmed'].toString()),
                                                            ),
                              ),
                            ],
                          );
                        }
                        else if(city.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    city: snapshot.data![index]['loc'],
                                    total: snapshot.data![index]['totalConfirmed'],
                                    recovered: snapshot.data![index]['discharged'],
                                    death: snapshot.data![index]['deaths'],
                                  )));
                                },
                              child: ListTile(
                                title: Text(snapshot.data![index]['loc'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text(snapshot.data![index]['totalConfirmed'].toString()),
                              ),
                            ),
                            ],
                          );
                        }
                        else{
                          return Container();
                        }


                        });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
