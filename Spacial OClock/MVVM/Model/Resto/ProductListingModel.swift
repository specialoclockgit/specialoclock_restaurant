

import Foundation

// MARK: - ProductListingModel
struct ProductListingModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ProductListingModelBody]?
}

// MARK: - Body
struct ProductListingModelBody: Codable {
    var id, menuID, cuisineID, categoryID: Int?
    var productName: String?
    var price, offerpercentage: String?
    var image: String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case menuID = "menu_id"
        case cuisineID = "cuisine_id"
        case categoryID = "category_id"
        case productName = "product_name"
        case price, image, offerpercentage
    }
}
