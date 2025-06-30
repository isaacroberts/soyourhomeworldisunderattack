import 'package:flutter/material.dart';
import 'package:soyourhomeworld/frontend/elements/holders/textholders.dart';
import 'package:soyourhomeworld/frontend/elements/scaffold.dart';

import '../base_text_theme.dart';
import '../icons.dart';
import '../styles.dart';

class ShopItem {
  final String itemName;
  final IconData icon;
  final String? extraText;
  final bool greenMsg;
  final double price;
  //TODO: bool biodegradable, item has green asterisk or some shit
  const ShopItem(this.itemName, this.icon, this.price,
      {this.extraText, this.greenMsg = false});
}

const List<ShopItem> shopItems = [
  ShopItem('Printed Copy', RpgAwesome.book, 20),
  ShopItem('Burned Copy', RpgAwesome.burning_book, 15, greenMsg: true),
  ShopItem('Harvey\'s Mug', RpgAwesome.coffee_mug, 15),

  ShopItem('Rachel Shirt', RpgAwesome.crowned_heart, 15),
  ShopItem('McKinsey Plan Shirt', RpgAwesome.spider_face, 15),
  ShopItem('Baller Shirt', RpgAwesome.suits, 15),
  ShopItem('Eco-Warrior Shirt', RpgAwesome.sprout_emblem, 15),
  ShopItem('Spare Packaging', RpgAwesome.sprout, 5, greenMsg: true),

  ShopItem('Napkin', RpgAwesome.tic_tac_toe, 5, greenMsg: false),

  ShopItem('Bad Gator Sign', RpgAwesome.wooden_sign, 3, greenMsg: false),

  // ShopItem('Loose Wrapping', RpgAwesome.circular_saw, 10, greenMsg: true),
  // ShopItem('Acorn (Biodegradable)', RpgAwesome.acorn, 3, greenMsg: false),
  ShopItem('Hawk (Biodegradable)', RpgAwesome.bird_claw, 250, greenMsg: true),
  ShopItem('Crab (Biodegradable)', RpgAwesome.crab_claw, 10, greenMsg: true),
  ShopItem('Toxaa Plasmosis', RpgAwesome.biohazard, 30, greenMsg: true),

  // ShopItem('Trash', RpgAwesome.all_for_one, 15, greenMsg: true),
];

class ShopItemThumbnail extends StatelessWidget {
  final ShopItem item;
  const ShopItemThumbnail(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialButton(
            onPressed: () {},
            child: SizedBox(
                width: 250,
                height: 225,
                // constraints: const BoxConstraints(
                //     maxHeight: 300, maxWidth: 250, minHeight: 150, minWidth: 150),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: colorScheme.primary, width: 3)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: Color(0x88000000), width: 3)),
                                  gradient: RadialGradient(colors: [
                                    // Color(0xff555555),
                                    Color(0xff777777),
                                    Color(0xffbbbbbb)
                                  ]),
                                  shape: BoxShape.circle),
                              child: Icon(item.icon,
                                  color: const Color(0xaa000000), size: 50),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.itemName,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              style: bodyFont,
                            ),
                            if (item.greenMsg)
                              Text(
                                'Read about our commitment to ecological stewardship.',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: bodyFont.copyWith(
                                    fontSize: 6,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xff008800)),
                              ),
                            const Expanded(child: SizedBox.shrink()),
                            FilledButton(
                                statesController: WidgetStatesController(
                                    {WidgetState.disabled}),
                                onPressed: () {},
                                child: Text(
                                  'Coming Soon!',
                                  // '${item.price.toStringAsFixed(2)} \$',
                                  style: bodyFont.copyWith(
                                      color: Colors.grey.shade700),
                                )),
                          ],
                        ))))));
  }
}

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // final ScrollController _controller = ScrollController();

  Widget? itemBuilder(context, index) {
    if (index < shopItems.length) {
      return ShopItemThumbnail(shopItems[index]);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return McScaffold(
    //     child: Container(
    //         color: Colors.white,
    //         child: ListView.builder(
    //             itemCount: shopItems.length, itemBuilder: itemBuilder)));

    const HeaderOfText header = HeaderOfText(text: 'Shop');

    return McScaffold(
        source: 'shop',
        child: Container(
          // color: Colors.white,
          alignment: Alignment.center,
          child: CustomScrollView(
              // controller: _controller,
              slivers: [
                SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: header.element(context))),
                // const SizedBox(height: 12),
                const SliverPadding(padding: EdgeInsets.only(top: 12)),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(itemBuilder),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                      // maxCrossAxisExtent: 250,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      crossAxisCount: 3,
                      childAspectRatio: 250 / 225),
                ),
              ]),
        ));
  }
}
