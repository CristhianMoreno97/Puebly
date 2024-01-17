import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class FilterListExpansion extends StatefulWidget {
  final String title;
  const FilterListExpansion({super.key, required this.title});

  @override
  State<FilterListExpansion> createState() => _FilterListExpansionState();
}

class _FilterListExpansionState extends State<FilterListExpansion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: ColorManager.magentaGradient,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Material(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: ExpansionTile(
          title: _TitleText(widget.title),
          backgroundColor: Colors.transparent,
          shape: _expansionTileShape(),
          collapsedShape: _expansionTileShape(),
          leading: const Icon(
            Icons.filter_alt,
            color: Colors.white,
          ),
          trailing: Icon(
            _isExpanded
                ? Icons.arrow_drop_up_rounded
                : Icons.arrow_drop_down_rounded,
            color: Colors.white,
          ),
          onExpansionChanged: (isExpanded) {
            setState(() {
              _isExpanded = isExpanded;
            });
          },
          children: const [
            _FilterList(),
          ],
        ),
      ),
    );
  }

  RoundedRectangleBorder _expansionTileShape() {
    return RoundedRectangleBorder(
      //side: const BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(16),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String title;
  const _TitleText(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class _FilterList extends StatelessWidget {
  const _FilterList();

  @override
  Widget build(BuildContext context) {
    List<User> userList = [
      User(name: "Abigail", avatar: "user.png"),
      User(name: "Audrey", avatar: "user.png"),
      User(name: "Ava", avatar: "user.png"),
      User(name: "Bella", avatar: "user.png"),
      User(name: "Bernadette", avatar: "user.png"),
      User(name: "Carol", avatar: "user.png"),
      User(name: "Claire", avatar: "user.png"),
      User(name: "Deirdre", avatar: "user.png"),
      User(name: "Donna", avatar: "user.png"),
      User(name: "Dorothy", avatar: "user.png"),
      User(name: "Faith", avatar: "user.png"),
      User(name: "Gabrielle", avatar: "user.png"),
      User(name: "Grace", avatar: "user.png"),
      User(name: "Hannah", avatar: "user.png"),
      User(name: "Heather", avatar: "user.png"),
      User(name: "Irene", avatar: "user.png"),
      User(name: "Jan", avatar: "user.png"),
      User(name: "Jane", avatar: "user.png"),
      User(name: "Julia", avatar: "user.png"),
      User(name: "Kylie", avatar: "user.png"),
      User(name: "Lauren", avatar: "user.png"),
      User(name: "Leah", avatar: "user.png"),
      User(name: "Lisa", avatar: "user.png"),
      User(name: "Melanie", avatar: "user.png"),
      User(name: "Natalie", avatar: "user.png"),
      User(name: "Olivia", avatar: "user.png"),
      User(name: "Penelope", avatar: "user.png"),
      User(name: "Rachel", avatar: "user.png"),
      User(name: "Ruth", avatar: "user.png"),
      User(name: "Sally", avatar: "user.png"),
      User(name: "Samantha", avatar: "user.png"),
      User(name: "Sarah", avatar: "user.png"),
      User(name: "Theresa", avatar: "user.png"),
      User(name: "Una", avatar: "user.png"),
      User(name: "Vanessa", avatar: "user.png"),
      User(name: "Victoria", avatar: "user.png"),
      User(name: "Wanda", avatar: "user.png"),
      User(name: "Wendy", avatar: "user.png"),
      User(name: "Yvonne", avatar: "user.png"),
      User(name: "Zoe", avatar: "user.png"),
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      child: Container(
        height: 160,
        color: Colors.grey[200],
        child: FilterListWidget(
          listData: userList,
          hideSelectedTextCount: true,
          hideHeader: true,
          allButtonText: "Todos",
          resetButtonText: "Ninguno",
          applyButtonText: "Buscar",
          themeData: _filterListThemeData(context),
          validateSelectedItem: (list, item) {
            if (list == null || list.isEmpty) return false;
            return list.contains(item);
          },
          choiceChipLabel: (item) {
            return item!.name;
          },
          onItemSearch: (item, query) {
            return item.name!.toLowerCase().contains(query.toLowerCase());
          },
          choiceChipBuilder: (context, item, isSelected) =>
              _ChoiceChip(item: item, isSelected: isSelected),
        ),
      ),
    );
  }

  _filterListThemeData(BuildContext context) {
    return FilterListThemeData.raw(
      borderRadius: 0,
      wrapAlignment: WrapAlignment.start,
      wrapCrossAxisAlignment: WrapCrossAlignment.start,
      wrapSpacing: -8,
      backgroundColor: Colors.transparent,
      headerTheme: const HeaderThemeData(),
      choiceChipTheme: const ChoiceChipThemeData(),
      controlBarButtonTheme: ControlButtonBarThemeData.raw(
        height: 40,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.only(bottom: 16),
        controlButtonTheme: ControlButtonThemeData(
          borderRadius: 8,
          textStyle: Theme.of(context).textTheme.bodyMedium,
          primaryButtonBackgroundColor: ColorManager.magenta,
        ),
        controlContainerDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -2,
              blurRadius: 10,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  final User? item;
  final bool? isSelected;
  const _ChoiceChip({
    this.item,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: ChoiceChip(
        iconTheme: null,
        avatar: null,
        showCheckmark: false,
        selectedColor: ColorManager.magentaTint2,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: ColorManager.magentaTint1, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        label: Text(
          item!.name!,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        selected: isSelected ?? false,
        onSelected: (selected) {
          print(selected);
        },
      ),
    );
  }
}

class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}
