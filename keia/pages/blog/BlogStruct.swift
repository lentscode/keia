import Foundation

//Struct to define which values ​​BlogItems accepts
struct BlogItems: Identifiable{
    var title:String
    var file:String
    var id = UUID()
}
