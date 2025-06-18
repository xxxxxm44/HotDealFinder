import Foundation

enum DealStatus: String, Codable {
    case hotdeal = "핫딜"
    case normal = "보통"
    case dontbuy = "사지마"
}


// 상품 데이터 설계도
struct Product: Identifiable {
    let id: UUID  // 각 항목 구분 위한 고유ID
    var name: String  // 상품명
    var imageName: String  // 상품 이미지 파일 이름 속성
    
    var priceHistory: [(date: Date, price: Int)] = []
    
    var isFavorite: Bool = false
    
    var currentPrice: Int? {
        priceHistory.last?.price
    }
    
    // 평균 가격을 계산하는 계산 속성
    var averagePrice: Double? {
        // 가격 이력이 없으면 평균을 계산할 수 없으므로 nil 반환
        guard !priceHistory.isEmpty else { return nil }
        
        // 모든 가격의 합계를 구함
        let sum = priceHistory.map { $0.price }.reduce(0, +)
        
        // 합계를 개수로 나누어 평균을 계산 (소수점 계산을 위해 Double로 변환)
        return Double(sum) / Double(priceHistory.count)
    }
}
