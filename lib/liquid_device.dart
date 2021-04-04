import 'package:simple_json_mapper/simple_json_mapper.dart';

@JObj()
class LiquidDevice {
  String id;

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
    this.id,
    this.vendorId,
    this.productId,
    this.releaseNumber,
    this.serialNumber,
    this.bus,
    this.address,
    this.port,
    this.driver,
    this.description,
  });

  bool get isNZXTSmartDevice {
    return description.contains('NZXT Smart Device');
  }

  Map<String, dynamic> toMap() {
    return JsonMapper.serializeToMap(this);
  }

  factory LiquidDevice.fromMap(Map<String, dynamic> map) {
    return JsonMapper.deserializeFromMap<LiquidDevice>(map);
  }

  @override
  String toString() {
    return 'LiquidDevice(id: $id, vendorId: $vendorId, productId: $productId, releaseNumber: $releaseNumber, serialNumber: $serialNumber, bus: $bus, address: $address, port: $port, driver: $driver, description: $description)';
  }
}
