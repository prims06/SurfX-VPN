class VpnInfo {
  late final String hostname;
  late final String ip;
  late final String ping;
  late final int speed;
  late final String countryLongName;
  late final String countryShortName;
  late final int vpnSessionsNum;
  late final String base64OpenVPNConfigurationData;
  VpnInfo(
      {required this.hostname,
      required this.ip,
      required this.ping,
      required this.speed,
      required this.countryLongName,
      required this.countryShortName,
      required this.vpnSessionsNum,
      required this.base64OpenVPNConfigurationData});
  VpnInfo.fromJson(Map<String, dynamic> jsonData) {
    hostname = jsonData['HostName'] ?? '';
    ip = jsonData['IP'] ?? '';
    ping = jsonData['Ping'].toString();
    speed = jsonData['Speed'] ?? 0;
    countryLongName = jsonData['CountryLong'] ?? '';
    countryShortName = jsonData['CountryShort'] ?? '';
    vpnSessionsNum = jsonData['NumVpnSessions'] ?? 0;
    base64OpenVPNConfigurationData =
        jsonData['OpenVPN_configData_Base64'] ?? '';
  }

  Map<String, dynamic> toJoson() {
    return {
      'HostName': hostname,
      'IP': ip,
      'Ping': ping,
      'Speed': speed,
      'CountryLong': countryLongName,
      'CountryShort': countryShortName,
      'NumVpnSessions': vpnSessionsNum,
      'OpenVPN_configData_Base64': base64OpenVPNConfigurationData
    };
  }
}
