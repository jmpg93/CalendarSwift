import Foundation

public enum Mode {
    case weekly
    case monthly
    
    var numberOfRows: Int {
        switch self {
        case .weekly:
            return 1
        case .monthly:
            return 6
        }
    }
}
