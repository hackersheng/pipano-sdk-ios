//
//  PiPanoSDK.h
//  Unity-iPhone
//
//  Created by forest on 2017/5/18.
//
//

#ifndef PiPano_Specific_h
#define PiPano_Specific_h

#import "PiPano.h"

@interface PiPano (Specific)

+(PiViewMode) defaultViewMode;

+(PiSourceMode) defaultSourceMode;

+(PiCameraDirection) defaultCameraDir;

/**
 解码 H264视频流的一帧，解码成功后等待被渲染。
 如果你的产品没有视频解码功能，请在获取到视频流后调用这个方法解码。
 
 @param nalu_data 一帧h264格式的视频流数据
 @param nalu_size 数据大小
 @return 解码结果的错误码
 */
+(int) decodeH264VideoFrame:(unsigned char*) nalu_data dataSize:(int) nalu_size;

/**
 获取PiPanoSDK版本号

 @return 一串数字的版本号
 */
+(NSString*) getVersion;


/**
 获取PiPanoSDK build版本号

 @return 带有version key的版本号
 */
+(NSString*) getBuildVersionString;


/**
 获取版次名
 
 @return 版次名，比如：PiPanoSDKBasic
 */
+(NSString*) getEditionName;


@end

#endif /* PiPano_Specific_h */
