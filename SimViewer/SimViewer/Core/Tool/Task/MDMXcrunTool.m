//
//  MDMXcrunTool.m
//  SimViewer
//
//  Created by 马德茂 on 2018/6/29.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import "MDMXcrunTool.h"
#import "MDMTaskTool.h"
#import "MDMStringFormatTool.h"

#pragma mark - 一些参数

///xcrun命令所在位置
static NSString * const kMDMXcrunCommandPath = @"/usr/bin/xcrun";

///simctl参数
static NSString * const kMDMXcrunSimctlArgument = @"simctl";


#pragma mark - MDMXcrunTool

@implementation MDMXcrunTool

///获取所有模拟器信息
+ (NSDictionary<NSString *, NSArray<NSString *> *> *)getAllSimulatorInfo {
    
    //xcrun simctl list 列出所有设备（同时会列出支持的机型和系统），devices代表只展示设备
    NSString *taskResult = [MDMTaskTool excute:kMDMXcrunCommandPath arguments:@[kMDMXcrunSimctlArgument, @"list", @"devices"]];
    
    //解析字符串
    NSDictionary *analyzeResult = [MDMStringFormatTool analyzeSimulatorInfoString:taskResult];
    
    return analyzeResult;
}

///获取App沙盒路径
+ (NSDictionary<NSString *, NSString *> *)getSandboxPathWithSimulatorIdentifier:(NSString *)simulatorIdentifier appIdentifier:(NSString *)appIdentifier {
    if (simulatorIdentifier == nil || [simulatorIdentifier isEqualToString:@""] ||
        appIdentifier == nil || [appIdentifier isEqualToString:@""]) {
        return nil;
    }
    
    //xcrun simctl appinfo simidentifier appidentifier
    NSString *taskResult = [MDMTaskTool excute:kMDMXcrunCommandPath arguments:@[kMDMXcrunSimctlArgument, @"appinfo", simulatorIdentifier, appIdentifier]];
    
    //解析字符串
    NSDictionary *analyzeResult = [MDMStringFormatTool analyzeAppInfoString:taskResult];
    
    return analyzeResult;
}

@end
