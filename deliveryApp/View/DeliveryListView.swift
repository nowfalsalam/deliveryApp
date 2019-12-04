//
//  ContentView.swift
//  deliveryApp
//
//  Created by Nowal E Salam on 03/12/19.
//  Copyright © 2019 Nowal E Salam. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DeliveryListView: View {
    @ObservedObject var viewModel = DeliveryListViewModel()
    
    var body: some View {
        NavigationView {
            List(){
                ForEach(viewModel.deliveryList) { delivery in
                    DeliveryCell(delivery: delivery)
                }
                if(viewModel.hasNextPage && !viewModel.isLoading){
                    LoadingRow(isLoading: true).onAppear {
                        self.viewModel.fetchDelivery()
                    }
                }
            }
            .navigationBarTitle(Text("Delivery List"))
            .listStyle(GroupedListStyle())
            
        }
        
    }
}
#if DEBUG

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryListView()
    }
}
#endif

struct DeliveryCell : View {
    let delivery: Delivery
    
    var body: some View {
        
        return NavigationLink(destination: DeliveryDetail(delivery: delivery)) {
            HStack {
                WebImage(url: URL(string: delivery.imageUrl))
                    .onSuccess { image, cacheType in
                        // Success
                }
                    .resizable() // Resizable like SwiftUI.Image
                    .placeholder(Image(systemName: "photo")) // Placeholder Image
                    // Supports ViewBuilder as well
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                }
                    .animated() // Supports Animated Image
                    //.indicator(.activity) // Activity Indicator
                    .animation(.easeInOut(duration: 0.5)) // Animation Duration
                    .transition(.fade) // Fade Transition
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(40)
                
                VStack(alignment: .leading) {
                    Text(delivery.description)
                }
            }
        }.frame(height: 64)
    }
}



import SwiftUI

struct LoadingRow : View {
    @State var isLoading: Bool

    var body: some View {
        HStack {
            Spacer()
            LoadingView(isLoading: isLoading)
            Spacer()
        }
    }
}

#if DEBUG
struct LoadingRow_Previews : PreviewProvider {
    static var previews: some View {
        LoadingRow(isLoading: true)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
#endif


struct LoadingView: UIViewRepresentable {

    var isLoading: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.style = .large
        indicator.hidesWhenStopped = true
        return indicator
    }

    func updateUIView(_ view: UIActivityIndicatorView, context: Context) {
        if self.isLoading {
            view.startAnimating()
        } else {
            view.stopAnimating()
        }
    }
}

#if DEBUG
struct LoadingView_Previews : PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true)
    }
}
#endif
