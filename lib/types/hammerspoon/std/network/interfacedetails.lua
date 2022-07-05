---@class InterfaceDetails
---@field AirPort AirPortDetails|nil
---@field CaptiveNetwork CaptiveNetworkDetails|nil
---@field IPv4 IPv4Details|nil
---@field IPv6 IPv6Details|nil
---@field Link LinkDetails|nil
---@field LinkQuality LinkQualityDetails|nil
---@field SleepProxyServers SleepProxyServersDetails[]|nil

---@class AirPortDetails
---@field AWDLRealTimeMode boolean
---@field AutoJoinTimestamp number
---@field BSSID string
---@field BluetoothAudioInUse boolean
---@field ["BluetoothPagingInProgress "] boolean
---@field Busy boolean
---@field BusyUI boolean
---@field CHANNEL number
---@field CachedScanRecord string
---@field ["Power Status"] boolean
---@field ProfileID string
---@field SSID string
---@field SSID_STR string
---@field SmartCCADesenseSupported boolean
---@field SmartCCADesenseUSBPresence boolean
---@field UserMode8021X boolean
---@field WEP40 boolean
---@field WEPOPENSYSTEM boolean

---@class CaptiveNetworkDetails
---@field Stage string
---@field WaitingOnUI boolean

---@class IPv4Details
---@field Addresses string[]
---@field BroadcastAddresses string[]
---@field SubnetMasks string[]

---@class IPv6Details
---@field Addresses string[]
---@field DestAddresses string[]|nil
---@field Flags number[]
---@field PrefixLength number[]

---@class LinkDetails
---@field Active boolean

---@class LinkQualityDetails
---@field LinkQuality number

---@class SleepProxyServersDetails
---@field FullName string
---@field MarginalPower number
---@field Metric number
---@field Portability number
---@field PrettyName string
---@field TotalPower number
---@field Type number
