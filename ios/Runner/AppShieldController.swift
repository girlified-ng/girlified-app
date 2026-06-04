import Foundation
import FamilyControls
import ManagedSettings

class AppShieldController {
    static let shared = AppShieldController()
    let store = ManagedSettingsStore()
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        if #available(iOS 16.0, *) {
            Task {
                do {
                    try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                    completion(true)
                } catch {
                    print("Failed to authorize Family Controls: \(error)")
                    completion(false)
                }
            }
        } else if #available(iOS 15.0, *) {
            AuthorizationCenter.shared.requestAuthorization { result in
                switch result {
                case .success:
                    completion(true)
                case .failure(let error):
                    print("Failed to authorize Family Controls: \(error)")
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    func enableShield() {
        if #available(iOS 15.0, *) {
            // In a real application, the tokens would be populated by the user selecting apps via FamilyActivityPicker.
            // store.shield.applications = Set(appTokens)
            print("App Shield Enabled")
        }
    }
    
    func disableShield() {
        if #available(iOS 15.0, *) {
            store.shield.applications = nil
            print("App Shield Disabled")
        }
    }
}
