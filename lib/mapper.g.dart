// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated and consumed by 'simple_json' 

import 'package:simple_json_mapper/simple_json_mapper.dart';
import 'package:liquid_ui/liquid_device.dart';

final _liquiddeviceMapper = JsonObjectMapper(
  (CustomJsonMapper mapper, Map<String, dynamic> json) => LiquidDevice(
    vendorId: mapper.applyFromJsonConverter(json['vendor_id']),
    productId: mapper.applyFromJsonConverter(json['product_id']),
    releaseNumber: mapper.applyFromJsonConverter(json['release_number']),
    serialNumber: mapper.applyFromJsonConverter(json['serial_number']),
    bus: mapper.applyFromJsonConverter(json['bus']),
    address: mapper.applyFromJsonConverter(json['address']),
    port: mapper.applyFromJsonConverter(json['port']),
    driver: mapper.applyFromJsonConverter(json['driver']),
    description: mapper.applyFromJsonConverter(json['description']),
  ),
  (CustomJsonMapper mapper, LiquidDevice instance) => <String, dynamic>{
    'vendor_id': mapper.applyFromInstanceConverter(instance.vendorId),
    'product_id': mapper.applyFromInstanceConverter(instance.productId),
    'release_number': mapper.applyFromInstanceConverter(instance.releaseNumber),
    'serial_number': mapper.applyFromInstanceConverter(instance.serialNumber),
    'bus': mapper.applyFromInstanceConverter(instance.bus),
    'address': mapper.applyFromInstanceConverter(instance.address),
    'port': mapper.applyFromInstanceConverter(instance.port),
    'driver': mapper.applyFromInstanceConverter(instance.driver),
    'description': mapper.applyFromInstanceConverter(instance.description),
  },
);

void init() {
  JsonMapper.register(_liquiddeviceMapper); 

  

  JsonMapper.registerListCast((value) => value?.cast<LiquidDevice>()?.toList());
}
    