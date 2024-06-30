import 'package:flutter/material.dart';
class CustomDropdownButton extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onItemSelected;
  final Color color;

  CustomDropdownButton({required this.color, required this.items, required this.onItemSelected});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> with SingleTickerProviderStateMixin {
  late OverlayEntry _overlayEntry;
  bool _isDropdownOpened = false;
  String _selectedItem = 'Select';
  final LayerLink _layerLink = LayerLink();

  late AnimationController _animationController;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _heightFactor = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (_isDropdownOpened) {
            _toggleDropdown();
          }
        },
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height),
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 20,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          color: widget.color.withOpacity(0.25)
                        ),
                        child: SizeTransition(
                          sizeFactor: _heightFactor,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 180, // محدودیت ارتفاع برای منو
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: widget.items.map((String item) {
                                  return Container(
                                    height: 50,
                                    child: ListTile(
                                    title: Text(item),
                                    onTap: () {
                                      setState(() {
                                        _selectedItem = item;
                                        widget.onItemSelected(item);
                                        _toggleDropdown();
                                      });
                                    },
                                                                ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleDropdown() {
    if (_isDropdownOpened) {
      _animationController.reverse().then((value) {
        _overlayEntry.remove();
        _isDropdownOpened = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      _animationController.forward();
      _isDropdownOpened = true;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: (){
          _toggleDropdown();
          },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_selectedItem),
                const Spacer(),
                const Icon(Icons.arrow_drop_down,size: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}