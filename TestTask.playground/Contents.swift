import UIKit
import Foundation
import XCTest

// Протокол для фигур
protocol Figure {
    func area() -> Double
}

// Структура для круга
struct Circle: Figure {
    let radius: Double
    
    init?(radius: Double) {
        guard radius > 0 else { return nil }

        self.radius = radius
    }
    
    func area() -> Double {
        return Double.pi * radius * radius
    }
}

// Структура для треугольника
struct Triangle: Figure {
    let sideA: Double
    let sideB: Double
    let sideC: Double
    
    init?(sideA: Double, sideB: Double, sideC: Double) {
        guard
            sideA > 0 ,
            sideB > 0,
            sideC > 0,
            sideA + sideB > sideC,
            sideA + sideC > sideB,
            sideB + sideC > sideA
        else { return nil }

        self.sideA = sideA
        self.sideB = sideA
        self.sideC = sideA
    }
    
    func area() -> Double {
        let halfPerimeter = (sideA + sideB + sideC) / 2
        return sqrt(halfPerimeter * (halfPerimeter - sideA) * (halfPerimeter - sideB) * (halfPerimeter - sideC))
    }
    
    func isRightTriangle() -> Bool {
        let sides = [sideA, sideB, sideC].sorted()
        return pow(sides[0], 2) + pow(sides[1], 2) == pow(sides[2], 2)
    }
}



let circle = Circle(radius: 5)
let triangle = Triangle(sideA: 3, sideB: 4, sideC: 5)
print("Площадь круга:", circle?.area())
print("Площадь треугольника:", triangle?.area())
print("Является ли треугольник прямоугольным:", triangle?.isRightTriangle())

class FigureTests: XCTestCase {
    
    func testCircleArea() {
        let circle = Circle(radius: 5)!
        XCTAssertEqual(circle.area(), 78.53981633974483, accuracy: 0.0001)
    }
    
    func testTriangleArea() {
        let triangle = Triangle(sideA: 3, sideB: 4, sideC: 5)!
        XCTAssertEqual(triangle.area(), 6.0, accuracy: 0.0001)
    }
    
    func testRightTriangle() {
        let rightTriangle = Triangle(sideA: 3, sideB: 4, sideC: 5)!
        XCTAssertTrue(rightTriangle.isRightTriangle())
        
        let notRightTriangle = Triangle(sideA: 3, sideB: 4, sideC: 6)!
        XCTAssertFalse(notRightTriangle.isRightTriangle())
    }
    
    func testNegativeOrZeroSides() {
        let triangle = Triangle(sideA: -3, sideB: -4, sideC: -5)
        XCTAssertNil(triangle)
        
        let circle = Circle(radius: 0)
        XCTAssertNil(circle)
    }
    
    func testTriangleExist() {
        let triangle = Triangle(sideA: 5, sideB: 100, sideC: 5)
        XCTAssertNil(triangle)
    }
}

FigureTests.defaultTestSuite.run()
