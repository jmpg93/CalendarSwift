import Foundation

extension Cal {
    func monthBefore(month: Month) -> Month? {
        guard let index = months.index(where: { $0.startSection == month.startSection }) else {
            return nil
        }
        
        let targetIndex = index - 1
        
        if months.indices.contains(targetIndex) {
            return months[targetIndex]
        } else {
            return nil
        }
    }
    
    func monthAfter(month: Month) -> Month? {
        guard let index = months.index(where: { $0.startSection == month.startSection }) else {
            return nil
        }
        
        let targetIndex = index + 1

        if months.indices.contains(targetIndex) {
            return months[targetIndex]
        } else {
            return nil
        }
    }
}
