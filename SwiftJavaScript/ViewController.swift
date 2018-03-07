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
    var jsSourceContents: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jsContext = JSContext()
        initializeJSFile(filename: "getNum", jsContext: jsContext)
        sampleOneDemo()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initializeJSFile(filename: String, jsContext: JSContext) {
        // Specify the path to the jssource.js file.
        print(filename)
        var jsFunction = ""
        if let jsSourcePath = Bundle.main.path(forResource: filename, ofType: "js") {
            do {
                // Load its contents to a String variable.
                jsFunction = try String(contentsOfFile: jsSourcePath)
                jsSourceContents.append(jsFunction)
                
                // Add the Javascript code that currently exists in the jsSourceContents to the Javascript Runtime through the jsContext object.
                var s = jsContext.evaluateScript("getNum()")
                print(s)
                //                print(jsContext.objectForKeyedSubscript("getName"))
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func sampleOneDemo() {
        let num = 2
        var realNum = 0
        print(jsSourceContents[0])
        jsContext.evaluateScript(jsSourceContents[0])
        if let functionFullname = jsContext.objectForKeyedSubscript("getNum") {
            // Call the function that composes the fullname.
            print(self.jsContext.objectForKeyedSubscript("getNum"))
            if let fullname = functionFullname.call(withArguments: [num]) {
                realNum = fullname.toNumber() as! Int
                print(realNum)
            }
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

