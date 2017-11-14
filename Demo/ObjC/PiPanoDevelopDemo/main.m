//
//  main.m
//  TestPiPanoSDK
//
//  Created by forest on 2017/6/2.
//  Copyright © 2017年 pisoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//添加PiPanoSDK头文件
#import <PiPanoSDKComplete/PiPanoSDK.h>
const char* AppControllerClassName = "AppDelegate";

int main(int argc, char* argv[])
{
    @autoreleasepool
    {
        //PiPanoSDK需要的代码
        [PiPano startPiPanoSDK:argc argv:argv];
        
        UIApplicationMain(argc, argv, nil, [NSString stringWithUTF8String:AppControllerClassName]);
    }
    
    return 0;
}
