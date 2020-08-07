/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view used to update the application settings.
*/

import Foundation
import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    var presenter: Presenter?
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Simple Push Server")) {
                    textField("Server Address", text: $viewModel.settings.host)
                        .keyboardType(.numbersAndPunctuation)
                }
                Section(header: Text("Local Push Connectivity"), footer: Text("The NEAppPushProvider will remain active and receive incoming calls and messages while this device stays on the specified SSID.")) {
                    textField("SSID", text: $viewModel.settings.ssid)
                        .keyboardType(.numbersAndPunctuation)
                    HStack {
                        Text("Active")
                        Spacer()
                        Text(viewModel.isAppPushManagerActive ? "Yes" : "No")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .environment(\.defaultMinListRowHeight, 50.0)
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                viewModel.commit()
                presenter?.dismiss()
            }, label: {
                Text("Done")
                    .fontWeight(.medium)
            }))
        }
    }
    
    private func textField(_ title: String, text: Binding<String>) -> some View {
        TextField(title, text: text, onCommit: { [self] in
            viewModel.commit()
        })
    }
}
