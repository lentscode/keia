import Foundation

//Struct to define which values ​​BlogItems accepts
struct Article: Identifiable {
    var id = UUID()
    let title: String
    let category: String
    let file: String
}
