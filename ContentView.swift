import SwiftUI

struct ContentView: View {
    @StateObject private var store = ProductStore()
    @State private var searchText = ""
    
    // 1. 시트를 띄우기 위한 상태 변수
    @State private var isShowingAddProductSheet = false

    var filteredAndSortedProducts: [Product] {
        let filtered = store.products.filter { product in
            searchText.isEmpty || product.name.localizedCaseInsensitiveContains(searchText)
        }
        return filtered.sorted { $0.isFavorite && !$1.isFavorite }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredAndSortedProducts) { product in
                    NavigationLink(destination: ProductDetailView(product: binding(for: product))) {
                        ProductRowView(product: product)
                    }
                    .contextMenu {
                        Button {
                            toggleFavorite(for: product)
                        } label: {
                            Text(product.isFavorite ? "관심 등록 해제" : "관심 상품 등록")
                            Image(systemName: product.isFavorite ? "star.slash" : "star")
                        }
                    }
                }
            }
            .navigationTitle("핫딜 파인더")
            // 2. 툴바에 '+' 버튼 추가 및 시트 연결
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddProductSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddProductSheet) {
                // isShowingAddProductSheet가 true가 되면 이 시트가 나타남
                // ProductStore의 products 배열과 isPresented 상태를 바인딩하여 전달
                AddProductView(products: $store.products, isPresented: $isShowingAddProductSheet)
            }
        }
        .environmentObject(store)
    }

    private func binding(for product: Product) -> Binding<Product> {
        guard let index = store.products.firstIndex(where: { $0.id == product.id }) else {
            fatalError("Product not found")
        }
        return $store.products[index]
    }

    private func toggleFavorite(for product: Product) {
        guard let index = store.products.firstIndex(where: { $0.id == product.id }) else { return }
        store.products[index].isFavorite.toggle()
    }
}
