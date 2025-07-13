import 'package:flutter/material.dart';

class ClipCircleImg extends StatefulWidget {
  final double? size;
  final Color? color;
  final double? radius;
  final String? imgNet; // If this is provided, use img.network
  final String? imgPath; // If this is provided, use img.asset
  final double? imgSize; // Size of the image inside the circle

  const ClipCircleImg({
    super.key, 
    this.size, 
    this.color, 
    this.radius, 
    this.imgNet, 
    this.imgSize, 
    this.imgPath,
  });

  @override
  State<ClipCircleImg> createState() => _ClipCircleImgState();
}

class _ClipCircleImgState extends State<ClipCircleImg> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: widget.size,
        height: widget.size,
        color: widget.color ?? Colors.blue,  // Default color if no color is provided
        child: Center(
          child: SizedBox(
            width: widget.imgSize ?? widget.size,  // Use imgSize if provided, else fallback to size
            height: widget.imgSize ?? widget.size,
            child: CircleAvatar(
              radius: widget.radius, // Radius for the circle avatar
              backgroundImage: widget.imgNet != null 
                  ? NetworkImage(widget.imgNet!)  // If imgNet is provided, use NetworkImage
                  : widget.imgPath != null 
                      ? AssetImage(widget.imgPath!)  // If imgPath is provided, use AssetImage
                      : null,  // If neither is provided, no image is displayed
            ),
          ),
        ),
      ),
    );
  }
}
