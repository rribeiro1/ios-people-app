//
//  CheckmarkPopoverView.swift
//  HomeTestProject
//
//  Created by Rafael Ribeiro on 05.11.22.
//

import SwiftUI

struct CheckmarkPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .padding()
            .font(.system(.largeTitle, design: .rounded).bold())
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CheckmarkPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkPopoverView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.blue)
    }
}
