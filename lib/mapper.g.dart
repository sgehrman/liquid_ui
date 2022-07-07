// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated and consumed by 'simple_json' 

import 'package:simple_json_mapper/simple_json_mapper.dart';
import 'package:liquid_ui/liquid_device.dart';

final _liquiddeviceMapper = JsonObjectMapper(
  (CustomJsonMapper mapper, Map<String, dynamic> json) => LiquidDevice(
    vendorId: mapper.applyDynamicFromJsonConverter(json['vendor_id']) ?? 0,
    productId: mapper.applyDynamicFromJsonConverter(json['product_id']) ?? 0,
    releaseNumber: mapper.applyDynamicFromJsonConverter(json['release_number']) ?? 0,
    serialNumber: mapper.applyDynamicFromJsonConverter(json['serial_number']) ?? '',
    bus: mapper.applyDynamicFromJsonConverter(json['bus']) ?? '',
    address: mapper.applyDynamicFromJsonConverter(json['address']) ?? '',
    port: mapper.applyDynamicFromJsonConverter(json['port']) ?? 0,
    driver: mapper.applyDynamicFromJsonConverter(json['driver']) ?? '',
    description: mapper.applyDynamicFromJsonConverter(json['description']) ?? '',
  ),
  (CustomJsonMapper mapper, LiquidDevice instance) => <String, dynamic>{
    'vendor_id': mapper.applyDynamicFromInstanceConverter(instance.vendorId),
    'product_id': mapper.applyDynamicFromInstanceConverter(instance.productId),
    'release_number': mapper.applyDynamicFromInstanceConverter(instance.releaseNumber),
    'serial_number': mapper.applyDynamicFromInstanceConverter(instance.serialNumber),
    'bus': mapper.applyDynamicFromInstanceConverter(instance.bus),
    'address': mapper.applyDynamicFromInstanceConverter(instance.address),
    'port': mapper.applyDynamicFromInstanceConverter(instance.port),
    'driver': mapper.applyDynamicFromInstanceConverter(instance.driver),
    'description': mapper.applyDynamicFromInstanceConverter(instance.description),
  },
);

void init() {
  JsonMapper.register(_liquiddeviceMapper); 

  

  JsonMapper.registerListCast((value) => value?.cast<LiquidDevice>().toList());
}
    