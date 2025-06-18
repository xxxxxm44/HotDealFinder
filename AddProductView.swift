import SwiftUI

struct AddProductView: View {
    // ContentView로부터 데이터를 넘겨받기 위한 변수들
    @Binding var products: [Product]
    @Binding var isPresented: Bool

    // 이 View 안에서만 사용할 상태 변수들
    @State private var name: String = ""
    @State private var priceString: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("새 상품 정보")) {
                    TextField("상품 이름", text: $name)
                    TextField("초기 가격", text: $priceString)
                        .keyboardType(.numberPad) // 숫자 키패드
                }
            }
            .navigationTitle("관심 상품 추가")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        isPresented = false // 창 닫기
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        saveProduct()
                    }
                    // 이름과 가격이 모두 입력되어야 저장 버튼 활성화
                    .disabled(name.isEmpty || priceString.isEmpty)
                }
            }
        }
    }
    
    // 상품 저장 로직을 별도 함수로 분리
    private func saveProduct() {
        // 가격을 Int로 변환 (실패하면 0)
        let price = Int(priceString) ?? 0
        
        // 새로운 Product 모델에 맞춰 상품 생성
        let newProduct = Product(
            id: UUID(),
            name: name,
            imageName: "giftcard.fill", // 새 상품을 위한 기본 아이콘
            priceHistory: [(date: Date(), price: price)], // 입력한 초기 가격을 첫 번째 이력으로 저장
            isFavorite: true // 새로 추가한 상품은 바로 관심 상품으로 등록
        )
        
        // ContentView의 products 배열에 새 상품 추가
        products.append(newProduct)
        
        // 창 닫기
        isPresented = false
    }
}
