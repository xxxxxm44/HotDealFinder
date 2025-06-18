import Foundation

class DealClassifier {
    
    static func classify(product: Product) -> (status: DealStatus, reason: String) {
        
        // 둘 중 하나라도 없으면 비교가 불가능하므로, '정보 부족' 반환.
        guard let currentPrice = product.currentPrice,
              let averagePrice = product.averagePrice else {
            return (.normal, "가격 이력 부족")
        }

        let currentPriceDouble = Double(currentPrice)

        // 10% 더 저렴한 기준값
        let hotdealThreshold = averagePrice * 0.9
        // 10% 더 비싼 기준값
        let dontbuyThreshold = averagePrice * 1.1

        if currentPriceDouble <= hotdealThreshold {
            return (.hotdeal, "핫딜! 당장 구매하세요!")
        } else if currentPriceDouble >= dontbuyThreshold {
            return (.dontbuy, "쿨딜... 절대 사지 마세요.")
        } else {
            return (.normal, "평소와 비슷한 가격이에요.")
        }
    }
}
