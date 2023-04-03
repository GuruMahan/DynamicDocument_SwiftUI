//
//  ContentView.swift
//  DynamicDocumentUI
//
//  Created by Guru Mahan on 09/01/23.
//

import SwiftUI

struct ContentView: View {
    
   @ObservedObject var viewModel = DocumentViewModel()
  @State var isSelected = false
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.gray.opacity(0.2)], startPoint: .leading, endPoint: .trailing)
                VStack {
                    headerView
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                    ScrollView{
                        frontView
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                            .padding([.top,.bottom],3)
                            .padding(.horizontal,7)
                    }
                     bottomView
                        .frame(width: UIScreen.main.bounds.width)
                        .background(Color.white)
                }
            }
        }
        .fileImporter(isPresented: $isSelected, allowedContentTypes: [.image,.audio,.data]) { result in
            do {
                let furl = try result.get()
                print("")
                viewModel.documentModel[viewModel.selectedIndex].url = furl.lastPathComponent
                viewModel.documentModel[viewModel.selectedIndex].pathExtension = furl.pathExtension
                print("file Ext \(furl.pathExtension)")
            } catch {
                print("error: \(error)") // todo
            }
        }
    }
    
    @ViewBuilder var headerView: some View {
        HStack {
            Button {
            } label: {
                HStack{
                    Image(systemName: "chevron.backward")
                        .font(Font.system(size: 25))
                    Text("Back")
                        .foregroundColor(.blue)
                        .font(.headline)
                }
            }.padding(.leading,10)
            Spacer()
                .overlay( Text("Document")
                    .padding(.horizontal,-99) , alignment: .center )
                .font(Font.system(size: 30))
        }
        .padding(10)
    }
   
    @ViewBuilder var bottomView: some View {
        HStack(spacing: 30){
            Button {
            } label: {
                Text("Back")
                    .frame(maxWidth: .infinity )
                    .frame(height: 40)
                    .foregroundColor(.blue)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.blue, lineWidth: 2))
            }
            Button {
            } label: {
                Text("Submit")
                    .frame(height: 40)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 2))
            }
        }
        .padding()
    }
    
    @ViewBuilder var frontView: some View{
        
        //MARK: ->ID Proof Stack
        VStack(alignment: .leading,spacing: 10){
            Text("Accepted Formats(JPG,PNG) - Upload File Max Size (6mb)")
                .font(Font.system(size: 12))
            ForEach(0..<viewModel.documentModel.count, id:\.self){ index in
                let doc = viewModel.documentModel[index]
                if doc.url.isEmpty {
                    emptyListView(list: doc,index: index)
                } else {
                    listView(list: doc, index: index)
                }
            }
        }
        .padding(10)
    }
    
    @ViewBuilder func emptyListView(list: DocumentModel?,index: Int) -> some View{
        Text(list?.title ?? "")
            .font(.headline)
        VStack{
        HStack{
            Text(list?.subtile ?? "")
                .font(Font.system(size: 12))
                .fontWeight(.light)
            Spacer()
            Text(list?.maxMb ?? "")
                .font(Font.system(size: 12))
                .fontWeight(.light)
        }
        HStack{
            Text(list?.placeHolder ?? "")
            Spacer()
            Button {
                viewModel.selectedIndex = index
                isSelected = true
            } label: {
                Image(systemName: "arrow.up.to.line")
                    .font(Font.system(size: 25))
            }
        } .padding()
            .fontWeight(.light)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5.0]))
                    .foregroundColor(.gray.opacity(0.3)) )
    }
        Divider()
    }
    
    @ViewBuilder func listView(list: DocumentModel,index: Int) -> some View{
        Text(list.title )
            .font(.headline)
        HStack{
            Text(list.subtile)
                .font(Font.system(size: 12))
                .fontWeight(.light)
            Spacer()
            Text(list.maxMb)
                .font(Font.system(size: 12))
                .fontWeight(.light)
        }
        HStack(spacing: 15){
            Button {
            } label: {
                Text(list.pathExtension).font(Font.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            } .frame(width: 50)
                .frame(maxHeight: .infinity)
                .background(Color.gray.opacity(0.3))
            VStack(alignment:.leading,spacing: 3){
                Text(list.url)
                    .padding(.vertical,8)
            }
            Spacer()
            Button {
                viewModel.documentModel[index].url  = ""
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(Font.system(size: 20))
            }
            .padding()
        }.frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.09))
            .cornerRadius(5)
    }
}
            
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
