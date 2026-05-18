import NetworkExtension
import Foundation

class DNSBlockingService {
    static let shared = DNSBlockingService()
    
    func enableDNS() {
        let manager = NEDNSSettingsManager.shared()
        manager.loadFromPreferences { error in
            if let error = error {
                print("Failed to load preferences: \(error)")
                return
            }
            
            let dohSettings = NEDNSOverHTTPSSettings(servers: ["doh.safesurfer.io"])
            dohSettings.serverURL = URL(string: "https://doh.safesurfer.io/dns-query")
            
            manager.dnsSettings = dohSettings
            
            let disconnectRule = NEOnDemandRuleDisconnect()
            disconnectRule.interfaceTypeMatch = .any
            manager.onDemandRules = [disconnectRule]
            manager.localizedDescription = "SaifeAI Secure DNS"
            manager.isEnabled = true
            
            manager.saveToPreferences { error in
                if let error = error {
                    print("Failed to save DNS settings: \(error)")
                } else {
                    print("DNS settings saved successfully")
                }
            }
        }
    }
    
    func disableDNS() {
        let manager = NEDNSSettingsManager.shared()
        manager.loadFromPreferences { _ in
            manager.isEnabled = false
            manager.saveToPreferences { _ in }
        }
    }
}
