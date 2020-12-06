//
//  Matrix.swift
//  MatrixMasters
//
//  Created by Christopher Hall on 12/5/20.
//

import SwiftUI

struct Matrix: View {
    var data: [[Double]]
    
    var body: some View {
        HStack{
            if data[0].count == 0 {
                Image("LBracket").padding()
                Image("RBracket").padding()
            } else {
                Image("LBracket").padding(.trailing, -20)
                VStack{
                    ForEach(0 ..< Int(data.count)) {numberr in
                        HStack{
                            ForEach(0 ..< Int(data[0].count)) {numberc in
                                Text("\(Int(data[numberr][numberc]))")
                                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                }
                Image("RBracket").padding(.leading, -20)
            }
        }
    }
}

struct Matrix_Previews: PreviewProvider {
    static var previews: some View {
        Matrix(data: [[]])
    }
}
