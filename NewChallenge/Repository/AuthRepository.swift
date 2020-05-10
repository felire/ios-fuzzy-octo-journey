import UIKit

class AuthRepository {
    enum Key: String, CaseIterable {
        case token
        func make() -> String {
            return "token"
        }
    }
    let userDefaults: UserDefaults
    // MARK: - Lifecycle
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    // MARK: - API
    func storeInfo(token: String) {
        saveValue(forKey: .token, value: token)
    }
    
    func getToken() -> String? {
        return readValue(forKey: .token)
    }
    
    // MARK: - Private
    private func saveValue(forKey key: Key, value: Any) {
        userDefaults.set(value, forKey: key.make())
    }
    private func readValue<T>(forKey key: Key) -> T? {
        return userDefaults.value(forKey: key.make()) as? T
    }
}
