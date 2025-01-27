//
//  HardwareView.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import SwiftUI
import SwiftData

struct HardwareListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isAddingHardware = false
    @Query var hardware: [Hardware]
    @State private var path = [Hardware]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(hardware) { hardware in
                    NavigationLink(value: hardware) {
                        VStack(alignment: .leading) {
                            Text(hardware.name)
                                .font(.headline)
                            Text(hardware.model)
                            if let employee = hardware.employee {
                                VStack(alignment: .leading) {
                                    Text(employee.name)
                                        .font(.headline)
                                    Text(employee.position)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                           
                        }
                    }
                }
            }
            .navigationTitle("Hardware")
            .navigationDestination(for: Hardware.self, destination: HardwareDetailView.init)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddingHardware.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingHardware) {
               // AddHardwareView()
                  //  .presentationDetents([.large])
            }
        }
    }
}

#Preview {
    HardwareListView()
}
