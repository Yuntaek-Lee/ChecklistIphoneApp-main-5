//
//  MasterListRowView.swift
//  Checklist
//
//  Created by JUN SEOK LEE on 17/6/2024.
//

import SwiftUI

/// Sub view to contain row content for the main checklist list
struct MasterListRowView: View {
    /// Subscribes to an observable object checklist
    @ObservedObject var checklist: Checklist
    var body: some View {
        HStack {
            Text(checklist.title)
                .font(.custom("Futura", size: 17)) // 폰트 설정
        }
    }
}
