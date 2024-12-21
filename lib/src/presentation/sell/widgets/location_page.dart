import 'package:ecommerce/src/presentation/sell/bloc/sell_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({super.key});

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  @override
  void initState() {
    BlocProvider.of<SellBloc>(context).add(const GetRegionsEvent());
    super.initState();
  }

  String? _region;
  String? _subcity;
  int? _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((_subcity != null && _region != null)
            ? "${_subcity!}, ${_region!}"
            : 'Location Page'),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: (_subcity != null && _region != null)
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop({"region": _region!, "location": _subcity});
                      },
                      child: const Text(
                        'Select',
                        style: TextStyle(color: Colors.white),
                      ))
                  : const SizedBox.shrink())
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<SellBloc, SellState>(
          builder: (context, state) {
            if (state is FetchRegionLoading || state is FetchRegionError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FetchRegionSuccess) {
              var val = state.regionModel.data;

              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: val
                    .map(
                      (e) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ExpansionTile(
                          initiallyExpanded: _selectedIndex == val.indexOf(e),
                          onExpansionChanged: (bool isExpanded) {
                            setState(() {
                              if (isExpanded &&
                                  _selectedIndex != null &&
                                  _selectedIndex != val.indexOf(e)) {
                                _selectedIndex = null;
                              }
                              _selectedIndex =
                                  isExpanded ? val.indexOf(e) : null;
                            });
                          },
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          collapsedBackgroundColor: Colors.grey[300],
                          backgroundColor: Colors.white,
                          title: Text(
                            e.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                          children: e.subCitys
                              .map(
                                (String subCity) => ListTile(
                                  onTap: () {
                                    setState(() {
                                      _region = e.name;
                                      _subcity = subCity;
                                    });
                                  },
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  enabled: true,
                                  selected: _region == subCity,
                                  selectedColor: Colors.teal,
                                  title: Text(
                                    subCity,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                    .toList(),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
