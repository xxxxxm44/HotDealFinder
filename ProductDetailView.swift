import SwiftUI

struct ProductDetailView: View {
    @Binding var product: Product
    
    @State private var newPriceString: String = ""

    var body: some View {
        VStack {
            // 1. 상품 이미지
            Image(systemName: product.imageName)
                .font(.system(size: 150))
                .padding()
                .foregroundColor(.accentColor)

            // 2. 상품명
            Text(product.name)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 30)

            // 3. 가격 입력 바
            HStack {
                TextField("새로운 가격 입력", text: $newPriceString)
                    .keyboardType(.numberPad)
                    .frame(width: 200)
                
                Button("저장") {
                    if let newPrice = Int(newPriceString) {
                        product.priceHistory.append((date: Date(), price: newPrice))
                        newPriceString = ""
                    }
                }
            }
            
            // 4. 가격 변동 이력 목록
            List {
                Section(header: Text("가격 변동 이력")) {
                    ForEach(product.priceHistory.reversed(), id: \.date) { history in
                        HStack {
                            Text(history.date, style: .date)
                            Spacer()
                            Text("\(history.price)원")
                        }
                    }
                }
            }
        }
        .navigationTitle("상품 상세 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}
