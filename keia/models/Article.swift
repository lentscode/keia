import Foundation
import SwiftUI

// Struct to define which values ​​BlogItems accepts
struct Article: Identifiable {
    var id = UUID()
    let title: String
    let category: String
    let image: String
    let text: String
    let author: String
    let date: Date
}
