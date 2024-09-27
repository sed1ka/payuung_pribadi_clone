import 'package:flutter/material.dart';

ValueNotifier<Size> _deviceSize = ValueNotifier<Size>(const Size(0, 0));

set setDeviceSize(Size value) => _deviceSize.value = value;

Size get kDeviceSize => _deviceSize.value;

// Size in logical pixels
ValueNotifier<double> _deviceLogicalWidth = ValueNotifier<double>(0);
ValueNotifier<double> _deviceLogicalHeight = ValueNotifier<double>(0);

set setDeviceLogicalWidth(double value) => _deviceLogicalWidth.value = value;

set setDeviceLogicalHeight(double value) => _deviceLogicalHeight.value = value;

double get kDeviceLogicalWidth => _deviceLogicalWidth.value;

double get kDeviceLogicalHeight => _deviceLogicalHeight.value;

// Size in physical pixels
ValueNotifier<double> _devicePhysicalWidth = ValueNotifier<double>(0);
ValueNotifier<double> _devicePhysicalHeight = ValueNotifier<double>(0);

set setDevicePhysicalWidth(double value) => _devicePhysicalWidth.value = value;

set setDevicePhysicalHeight(double value) =>
    _devicePhysicalHeight.value = value;

double get kDevicePhysicalWidth => _devicePhysicalWidth.value;

double get kDevicePhysicalHeight => _devicePhysicalHeight.value;

// Size of Text in screen ratio;
ValueNotifier<double> _devicePixelRatio = ValueNotifier<double>(0);

set setDevicePixelRatio(double value) => _devicePixelRatio.value = value;

double get kDevicePixelRatio => _devicePixelRatio.value;

// Toolbar / navigation system padding
ValueNotifier<EdgeInsets> _devicePadding =
ValueNotifier<EdgeInsets>(EdgeInsets.zero);

set setDevicePadding(EdgeInsets value) => _devicePadding.value = value;

EdgeInsets get kDevicePadding => _devicePadding.value;