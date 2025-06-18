
import SwiftUI

struct ProductRowView: View {
    let product: Product

    var body: some View {
        // 1. 딜 Classifier를 통해 상품의 상태를 판단.
        let classification = DealClassifier.classify(product: product)
        
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                
                Text("\(product.currentPrice ?? 0)원")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // 2. 판단 근거 텍스트를 작은 글씨로 표시
                Text(classification.reason)
                    .font(.caption)
                    .foregroundColor(statusColor(for: classification.status))
            }
            
            Spacer()
            
            // 3. 상태에 따라 아이콘과 텍스트 표시
            VStack {
                Image(systemName: statusIcon(for: classification.status))
                    .font(.title2)
                Text(classification.status.rawValue)
                    .font(.caption)
            }
            .foregroundColor(statusColor(for: classification.status))
            .frame(width: 80)
        }
        .padding(.vertical, 8)
    }
    
    // 상태에 따른 색상을 반환
    private func statusColor(for status: DealStatus) -> Color {
        switch status {
        case .hotdeal: return .red
        case .normal: return .blue
        case .dontbuy: return .gray
        }
    }
    
    // 상태에 따른 아이콘 이름을 반환
    private func statusIcon(for status: DealStatus) -> String {
        switch status {
        case .hotdeal: return "flame.fill"
        case .normal: return "tag.fill"
        case .dontbuy: return "hand.thumbsdown.fill"
        }
    }
}
