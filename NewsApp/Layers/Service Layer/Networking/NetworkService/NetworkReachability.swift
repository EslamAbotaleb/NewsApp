import Foundation
import Alamofire
import Reachability

class NetworkReachability: NSObject {
    
    static let shared: NetworkReachability = { return NetworkReachability() }()

    var reach: Reachability!
  
    override init() {
        super.init()
        reach = try! Reachability()

        
        do {
            try reach.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    
    func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkReachability.shared.reach).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (NetworkReachability) -> Void) {
        if (NetworkReachability.shared.reach).connection != .unavailable {
            completed(NetworkReachability.shared)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkReachability) -> Void) {
        if (NetworkReachability.shared.reach).connection == .unavailable {
            completed(NetworkReachability.shared)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkReachability) -> Void) {
        if (NetworkReachability.shared.reach).connection == .cellular {
            completed(NetworkReachability.shared)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkReachability) -> Void) {
        if (NetworkReachability.shared.reach).connection == .wifi {
            completed(NetworkReachability.shared)
        }
    }
    
}
