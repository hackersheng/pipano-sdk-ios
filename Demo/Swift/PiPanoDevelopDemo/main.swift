//
//  main.swift
//  TestSwift
//
//  Created by forty Lin on 2017/10/31.
//  Copyright © 2017年 forty. All rights reserved.
//

import Foundation
import UIKit

let argc = CommandLine.argc
let argv = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(
                                                                    to: UnsafeMutablePointer<Int8>.self,
                                                                    capacity: Int(CommandLine.argc))
//启动PiPanoSDK
PiPano.startSDK(argc, argv: argv)

UIApplicationMain(argc,argv,nil,NSStringFromClass(AppDelegate.self))
