//
//  ContentView.swift
//  PropertyWrappersApp
//
//  Created by Enrico Sousa Gollner on 14/10/23.
//

import SwiftUI

// MARK: Property wrappers

// Property wrappers são como "atalhos" que você coloca antes das propriedades no Swift para adicionar regras especiais. Eles ajudam a economizar tempo e manter o código organizado. Cada atalho (@) tem uma função específica, como controlar quando as propriedades mudam ou limitar os valores que elas podem ter

// EXEMPLOS MAIS UTILIZADOS:

// @State -> Utilizado para criar uma propriedade mutável dentro de uma view. Ele permite que a view observe mudanças nessa propriedade e atualize automaticamente a interface quando ela muda. Usado principalmente para controlar o estado interno de uma view.

// @Binding -> Utilizado para criar uma ligação entre uma propriedade de uma view pai e uma view filho. Isso permite que a view filho leia e atualize a propriedade original da view pai, mantendo-as sincronizadas. É útil quando você deseja que as mudanças em uma view filho afetem a view pai.

// @ObservedObject -> Utilizado para conectar uma instância de uma classe observável (geralmente conformando o protocolo ObservableObject) a uma view. Isso permite que a view observe as mudanças de propriedades nessa classe e atualize quando ocorrerem alterações.

// @Enviroment -> Utilizado para acessar valores ambientais (tamanhos de fonte, cores, etc...) fornecidos pelo ambiente de execução do aplicativo. Isso permite que as views acessem configurações globais sem passar esses valores manualmente.

// @FetchRequest -> Utilizado com o Core Data para buscar dados no banco de dados. Ele aceita uma consulta e fornece os resultados como uma lista de objetos observáveis (ObservableObjects). Usado para exibir dados do banco de dados na interface.

// @AppStorage e @SceneStorage -> Ambos são usados para armazenar dados de forma persistente entre sessóes do aplicativo ou entre diferentes cenas em um aplicativo de várias janelas/telas. O @AppStorage é para armazenar valores simples como números ou strings, enquanto o @SceneStorage é utilizado para armazenar dados específicos de uma cena.


struct ContentView: View {
    @State var showMessage = false
    @State var typedText = ""
    
    @State var isSheetPresented = false
    @State var isFullCoverPresented = false

    
    var body: some View {
        VStack {
            VStack {
                Text(showMessage ? "World!" : "Hello,")
                    .font(.system(size: 27, weight: .bold))
                
                Button("Alternate message") {
                    showMessage.toggle()
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack {
                Text(typedText)
                    .font(.system(size: 20, weight: .bold))
                
                TextField("Type a text to show", text: $typedText)
                    .textFieldStyle(.roundedBorder)
                    
            }
            .padding()
            
            VStack(spacing: 10){
                // Sheet (modal)
                Button("Show sheet") {
                    isSheetPresented.toggle()
                }
                .sheet(isPresented: $isSheetPresented, content: {
                    ChangeValue()
                })
                
                // Fullscreen cover
                Button("Show fullscreen sheet") {
                    isFullCoverPresented.toggle()
                }
                .fullScreenCover(isPresented: $isFullCoverPresented) {
                    ChangeValue()
                }
                
            }
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//#Preview {
//    ContentView()
//}
