//
//  ContentView.swift
//  MatrixMasters
//
//  Created by Christopher Hall on 12/5/20.
//

import SwiftUI




struct ContentView: View {
    @State var rows = 2.0
    @State var cols = 2.0
    @State var arr = [["0","0","0","0","0"],
                      ["0","0","0","0","0"],
                      ["0","0","0","0","0"],
                      ["0","0","0","0","0"],
                      ["0","0","0","0","0"]]
    @State var good = false
    @State var generatedQuestion = false
    @State var correct = false
    @State var incorrect = false
    
    @State var difficulty = 1...4
    
    @State var m1 = [[Double]]()
    @State var m2 = [[Double]]()
    @State var ans = [[Double]]()
    
    @State var m1r = 3
    @State var m1c = 2
    
    @State var m2r = 2
    @State var m2c = 3

    func generateMatrix(rows: Int, cols: Int)->[[Double]]{
        var ret = [[Double]]()
        for _ in 0..<rows{
            var rowTemp = [Double]()
            for _ in 0..<cols{
                rowTemp.append(Double(Int.random(in: 0...9)))
            }
            ret.append(rowTemp)
        }
        return ret
    }

    func getNthCol(_ a: [[Double]], n: Int)->[Double]{
        var ret = [Double]()
        for element in 0..<a.count{
            ret.append(a[element][n])
        }
        return ret
    }

    func dotProduct(_ a:[Double], _ b:[Double])->Double{
        var ret = 0.0
        
        for num in 0..<a.count{
            ret += (a[num] * b[num])
        }
        
        return ret
    }

    func matrixMul(_ a: [[Double]], _ b: [[Double]]) -> [[Double]]{
        var ret = [[Double]]()
        
        for row in a{
            var retRow = [Double]()
            for num in 0..<b[0].count{
                retRow.append(dotProduct(row, getNthCol(b, n: num)))
            }
            ret.append(retRow)
        }
        
        return ret
    }
    
    func matrixEqual(_ a:[[Double]], _ b:[[Double]])->Bool{
        if a.count != b.count {return false}
        if a[0].count != b[0].count {return false}
        for row in 0..<a.count{
            for col in 0..<a[0].count{
                if a[row][col] != b[row][col]{
                    return false
                }
            }
        }
        return true
    }
    
    func extractAnswer(rows: Int, cols: Int, data: [[String]])->[[Double]]{
        var ret = [[Double]]()
        
        for r in 0..<rows{
            var tempRow = [Double]()
            for c in 0..<cols{
                tempRow.append(Double(data[r][c]) ?? 9999999999)
            }
            ret.append(tempRow)
        }
        return ret
    }
    
    var body: some View {
        VStack {
            Button(generatedQuestion ? "Set up new question" :"Generate Question"){
                self.correct = false
                self.incorrect = false
                
                self.generatedQuestion = !self.generatedQuestion
                self.m1r = Int.random(in: difficulty)
                self.m1c = Int.random(in: difficulty)
                self.m2r = self.m1c
                self.m2c = Int.random(in: difficulty)
                
                self.m1 = generateMatrix(rows: m1r, cols: m1c)
                self.m2 = generateMatrix(rows: m2r, cols: m2c)
            }
            .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if generatedQuestion{
                HStack{
                    Matrix(data: m1)
                    Matrix(data: m2)
                }
            }
            
        
            
            HStack{
                VStack{
                    Stepper(value: $rows, in: 1...5, step: 1){
                        Text("Rows: \(rows, specifier: "%g")")
                    }
                    Stepper(value: $cols, in: 1...5, step: 1){
                        Text("Columns: \(cols, specifier: "%g")")
                    }
                }
                .padding(.leading)
                Button(good ? "Change Size" : "Make grid"){
                    self.good = !good
                }
                .frame(width: 120, height: 72, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            
            if good {
                matrixEntry(rows: rows, cols: cols, arr: $arr)
            }
            
            Spacer()
            
            
            if correct{
                Text("Congratulations! You are correct!")
                    .padding()
            }
            
            if incorrect{
                Text("That's not quite it.")
                    .padding()
            }
            
            Button("Check Answer"){
                if self.matrixEqual(self.extractAnswer(rows: Int(self.rows), cols: Int(self.cols), data: self.arr), self.matrixMul(self.m1, self.m2)){
                    self.correct = true
                } else {
                    self.incorrect = true
                }
            }
            .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct matrixEntry: View {
    @State var rows: Double
    @State var cols: Double
    @State var arr: Binding<[[String]]>
    
    var body: some View{
        ForEach(0 ..< Int(rows)) {numberr in
            HStack{
                ForEach(0 ..< Int(cols)) {numberc in
                    entry(data: arr[numberr][numberc])
                }
            }
        }
    }
}

struct entry: View {
    @State var data: Binding<String>
    var body: some View{
        TextField("num", text: data)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(maxWidth: 50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
