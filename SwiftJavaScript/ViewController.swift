//
//  ViewController.swift
//  SwiftJavaScript
//
//  Created by JJ Guo on 2/23/18.
//  Copyright © 2018 JJ Guo. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {

    var jsContext: JSContext!
    var jsSourceContents: [String: String] = [:]
    var stringNames: [String] = []
    var intNames: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jsContext = JSContext()
        intNames.append("getNum")
        initializeJSFile(filename: "getNum", jsContext: jsContext)
        stringNames.append("getName")
        initializeJSFile(filename: "getName", jsContext: jsContext)
//        let num = sampleIntDemo()
//        print(num)
        sampleStringDemo(name: "Harden", num: 2)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initializeJSFile(filename: String, jsContext: JSContext) {
        // Specify the path to the jssource.js file.
        print(filename)
        var jsFunction = ""
        if let jsSourcePath = Bundle.main.path(forResource: filename, ofType: "js") {
            do {
                jsFunction = try String(contentsOfFile: jsSourcePath) // Load its contents to a String variable.
                jsSourceContents[filename] = jsFunction // load function name to actual function text
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func sampleIntDemo() -> Int {
        let num = 2
        var realNum = 0
//        for i in 0..<intNames.count {
            let methodName = intNames[0]
            print(methodName)
            jsContext.evaluateScript(jsSourceContents[methodName])
            if let functionFullname = jsContext.objectForKeyedSubscript(methodName) {
                // Call the function that composes the fullname.
                print(self.jsContext.objectForKeyedSubscript(methodName))
                if let fullname = functionFullname.call(withArguments: [num]) {
                    realNum = fullname.toNumber() as! Int
                }
            }
//        }
        return realNum
    }
    
    func sampleStringDemo(name: String, num: Int) {
        var realString = ""
//        for i in 0..<stringNames.count {
        let methodName = stringNames[0]
        print(methodName)
        print(jsSourceContents[methodName])
        jsContext.evaluateScript(jsSourceContents[methodName])
        if let functionFullname = jsContext.objectForKeyedSubscript(methodName) {
            // Call the function that composes the fullname.
            print(self.jsContext.objectForKeyedSubscript("getName"))
            if let fullname = functionFullname.call(withArguments: [name, num]) {
                realString = (fullname.toString())!
                print(realString)
            }
        }
//        }
    }
        
//        if let functionFullname = jsContext1.objectForKeyedSubscript("getNum") {
//            // Call the function that composes the fullname.
//            print(self.jsContext1.objectForKeyedSubscript("getNum"))
//            if let fullname = functionFullname.call(withArguments: [num]) {
//                realNum = fullname.toNumber() as! Int
//            }
//        }
//        print(realNum)
//        if let functionFullname = jsContext2.objectForKeyedSubscript("getName") {
//            print(self.jsContext2.objectForKeyedSubscript("getName"))
//            if let fullname = functionFullname.call(withArguments: [name, realNum]) {
//                realName = fullname.toString()
//            }
//        }
//        print("RealName: \(realName)")
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

