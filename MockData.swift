import Foundation

class ProductStore: ObservableObject {
    @Published var products: [Product]
    
    init() {
        self.products = [
            Product(id: UUID(), name: "아이폰 14 Pro", imageName: "iphone14.pro", priceHistory: [(Date(), 1450000)]),
            Product(id: UUID(), name: "에어팟 프로 2세대", imageName: "airpodspro.gen2", priceHistory: [(Date(), 320000)], isFavorite: true),
            Product(id: UUID(), name: "애플워치 울트라", imageName: "applewatch.ultra", priceHistory: [(Date(), 1190000)]),
            Product(id: UUID(), name: "M2 맥북 에어", imageName: "macbook.air.m2", priceHistory: [(Date(), 1690000)]),
            Product(id: UUID(), name: "홈팟 미니", imageName: "homepodmini", priceHistory: [(Date(), 129000)], isFavorite: true),
            Product(id: UUID(), name: "매직 키보드", imageName: "magickeyboard", priceHistory: [(Date(), 149000)]),
            Product(id: UUID(), name: "신라면 20개입", imageName: "신라면20개입", priceHistory: [(Date(), 18000)]),
            Product(id: UUID(), name: "햇반 24개입", imageName: "햇반24개입", priceHistory: [(Date(), 24000)])
        ]
    }
}
