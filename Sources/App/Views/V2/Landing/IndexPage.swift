//
//  IndexPageView.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//

import HTMLKit

enum IndexPageV2 {
    struct IndexView: View {
        var body: Content {
            BaseContaiterView {
                NavBarView()
                HeaderView()
                AboutUsView()
                FaqsView()
                ContactUsView()
                FooterView()
            }
        }
    }
    
    
    
}

