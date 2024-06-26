//
//  ExcelTests.swift
//  
//
//  Created by Sietse Guijt on 25/06/2024.
//

import XCTest
import SGShared
import CoreXLSX

final class ExcelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testExcelUserRead() throws {
        /* setup file */
        let file: String = "users.xlsm"
        let fileManager = FileManager.default
        let rootPath = fileManager.currentDirectoryPath
        let path: String = rootPath        
        print("processing file: \(path)")
        
        /* process file */
        //let obj: SGExcel = SGExcel()
        //obj.readExcelDocument(filepath: "\(path+"/Public/assets/basware/"+file)")
        
        readExcelDocument(filepath: "\(path+"/Public/assets/basware/"+file)")
    }
    
    public func readExcelDocument(filepath: String) {

        guard let file = XLSXFile(filepath: filepath) else {
            fatalError("XLSX file at \(filepath) is corrupted or does not exist")
        }

        for wbk in try! file.parseWorkbooks() {
            
            for sheet in wbk.sheets.items {
                print("sheet: \(String(describing: sheet.name))")
                switch sheet.name?.lowercased() {
                case "users":
                    break
                case "groups":
                    break
                case "advancedpermissions":
                    break
                case "groupcodeslookup":
                    break
                default:
                    print("logic not yet implemented for current sheet")
                    break
                }
            }
            
            do {
                for path in try file.parseWorksheetPaths() {
                    let ws = try file.parseWorksheet(at: path)
                    for row in ws.data!.rows {
                        for c in row.cells {
                            print(c)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
            
            /*
            let alphaArr = ["A", "B", "C"]
            do {
                let docPath = try file.parseDocumentPaths()
                let workSheet = try file.parseWorksheet(at: docPath.first ?? "")
                let sharedStrings = try file.parseSharedStrings()
                
                if let sharedStrings = try file.parseSharedStrings() {
                    
                    let columnCStrings = workSheet.cells(atColumns: [ColumnReference("C")!])
                        .compactMap { $0.stringValue(sharedStrings) }
                    print("columnCStrings: \(columnCStrings)")
                    
                    let columnCDates = workSheet.cells(atColumns: [ColumnReference("C")!])
                        .compactMap { $0.dateValue }
                    print("columnCDates: \(columnCDates)")
                    
                    if let richStrings = try file.parseSharedStrings() {
                        let columnCRichStrings = workSheet.cells(atColumns: [ColumnReference("C")!])
                            .compactMap { $0.richStringValue(sharedStrings) }
                        print("columnCRichStrings: \(columnCRichStrings)")
                    }
                }
            } catch {
                    print(error.localizedDescription)
                }
             */
            
            
            
            /*
            for (name, path) in try! file.parseWorksheetPathsAndNames(workbook: wbk) {
                if let worksheetName = name {
                    print("This worksheet has a name: \(worksheetName)")
                }
                let worksheet = try! file.parseWorksheet(at: path)
                for row in worksheet.data?.rows ?? [] {
                    for cell in row.cells {
                        print(cell)
                    }
                }
            }
            */
        }
    }

}

