import 'package:simple_json_mapper/simple_json_mapper.dart';

@JObj()
class LiquidDevice {
  @JsonProperty(name: 'vendor_id')
  int vendorId;

  @JsonProperty(name: 'product_id')
  int productId;

  @JsonProperty(name: 'release_number')
  int releaseNumber;

  @JsonProperty(name: 'serial_number')
  String serialNumber;

  String bus;
  String address;
  int port;
  String driver;
  String description;

  LiquidDevice({
    this.vendorId = 0,
    this.productId = 0,
    this.releaseNumber = 0,
    this.serialNumber = '',
    this.bus = '',
    this.address = '',
    this.port = 0,
    this.driver = '',
    this.description = '',
  });

  bool get isNZXTSmartDeviceV1 {
    return description.contains('NZXT Smart Device (V1)');
  }

  bool get isNZXTSmartDeviceV2 {
    return description.contains('NZXT Smart Device V2');
  }

  bool get isNZXTKraken {
    return description.contains('NZXT Kraken');
  }

  Map<String, dynamic> toMap() {
    return JsonMapper.serializeToMap(this) ?? <String, dynamic>{};
  }

  factory LiquidDevice.fromMap(Map<String, dynamic> map) {
    return JsonMapper.deserializeFromMap<LiquidDevice>(map)!;
  }

  @override
  String toString() {
    return 'LiquidDevice(vendorId: $vendorId, productId: $productId, releaseNumber: $releaseNumber, serialNumber: $serialNumber, bus: $bus, address: $address, port: $port, driver: $driver, description: $description)';
  }
}
