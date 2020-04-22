/*
Example code for article: https://lostmoa.com/blog/MappingSwiftUIStateToViewBindingTypes/

How to modify the value of the binding before assigning it to the state 
and modify the state to match the binding type of the view, 
if we have a model that doesn't exactly match the binding that a view accepts.
*/


import SwiftUI

enum PaymentMethod {
    case creditCard
    case bankTransfer
    case cheque
    case noSelection
}

struct ContentView: View {

    @State var paymentMethod: PaymentMethod = .noSelection
    
    var body: some View {
        
        let creditCardBinding = Binding<Bool>(
            get: {
                switch self.paymentMethod {
                case .creditCard: return true
                default: return false
                }
            },
            set: { value in
                self.paymentMethod = value ? .creditCard : .noSelection
            }
        )
        
        let bankTransferBinding = Binding<Bool>(
            get: {
                switch self.paymentMethod {
                case .bankTransfer: return true
                default: return false
                }
            },
            set: { value in
                self.paymentMethod = value ? .bankTransfer : .noSelection
            }
        )
        
        let chequeBinding = Binding<Bool>(
            get: {
                switch self.paymentMethod {
                case .cheque: return true
                default: return false
                }
            },
            set: { value in
                self.paymentMethod = value ? .cheque : .noSelection
            }
        )
        
        
        return VStack(spacing: 10) {
            Spacer()
            
            Text("How would you like to pay?")
            
            Spacer()
            
            Toggle(isOn: creditCardBinding) {
                Text("Credit Card")
            }
            
            Toggle(isOn: bankTransferBinding) {
                Text("Bank Transfer")
            }
            
            Toggle(isOn: chequeBinding) {
                Text("Cheque")
            }
            
            Spacer()
        }
        .padding()
    }
}
