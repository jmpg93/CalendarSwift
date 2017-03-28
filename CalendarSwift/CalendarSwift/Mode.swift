import Foundation

public enum Mode {
    case weekly
    case monthly
    
    var numberOfDays: Int {
        switch self {
        case .weekly:
            return 14
        case .monthly:
            return 7
        }
    }
}
