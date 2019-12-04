//
//  DeliveryDetail.swift
//  deliveryApp
//
//  Created by Nowal E Salam on 04/12/19.
//  Copyright © 2019 Nowal E Salam. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit
import SDWebImageSwiftUI

struct DeliveryDetail: View {
    var delivery: Delivery
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: delivery.location.lat,
            longitude: delivery.location.lng
        )
    }
    var body: some View {
        NavigationView {
            VStack {
                MapView(coordinate: locationCoordinate)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 300)
                DeliveryDetailsView(delivery: delivery)
                Spacer()
            }
        }
    }
}


struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Delivery Location"
        view.addAnnotation(annotation)
    }
}


struct DeliveryDetailsView : View {
    let delivery: Delivery
    
    var body: some View {
        
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
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(80)
            
            VStack(alignment: .leading) {
                Text(delivery.description)
                Text(delivery.location.address)
            }
        }
    }
}
