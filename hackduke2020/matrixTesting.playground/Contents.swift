import UIKit

var str = "Hello, playground"

var a: [[Double]] = [[1]]
var b: [[Double]] = [[3]]

var oneXone: [[Double]] = [[1]]
var oneXtwo: [[Double]] = [[1, 1]]
var twoXone: [[Double]] = [[1],
                           [1]]
var twoXtwo: [[Double]] = [[1, 1],
                           [1, 1]]

var ex: [[Double]] = [[1,2,3],
                      [4,5,6],
                      [7,8,9]]

var id3: [[Double]] = [[1,0,0],
                       [0,1,0],
                       [0,0,1]]

var two = [[1,2],
           [3,4]]

var four = [[1,2,3,4],
            [5,6,7,8],
            [9,10,11,12],
            [13,14,15,16]]

func safeForMul(_ a: [[Double]], _ b: [[Double]]) -> Bool{
    if a[0].count != b.count {
        return false
    }
    else {
        return true
    }
}

func getNthRow(_ a: [[Double]], n: Int)->[Double]{
    return a[n]
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

func strArrToDouArr(_ a: [String])->[Double]{
    var ret = [Double]()
    for element in a{
        ret.append(Double(element) ?? -99999999999)
    }
    return ret
}

func strArrToDouArr2D(_ a:[[String]])->[[Double]]{
    var ret = [[Double]]()
    for arr in a{
        ret.append(strArrToDouArr(arr))
    }
    return ret
}

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

safeForMul(oneXtwo, oneXtwo)
safeForMul(twoXone, oneXtwo)
var test1 = getNthRow(ex, n: 0)
getNthRow(ex, n: 1)
getNthRow(ex, n: 2)
getNthCol(ex, n: 0)
getNthCol(ex, n: 1)
getNthCol(ex, n: 2)

dotProduct(test1, test1)
matrixMul(ex, id3)

generateMatrix(rows: 2,cols: 4)
[[]].count


var range = 1...5


var arr = [["1","2","0","0","0"],
           ["4","3","0","0","0"],
           ["0","0","0","0","0"],
           ["0","0","0","0","0"],
           ["0","0","0","0","0"]]

extractAnswer(rows: 2, cols: 2, data: arr)

