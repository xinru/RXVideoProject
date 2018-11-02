//
//  MHLogDefine.h
//  PerfectProject
//
//  Created by Andy on 14/11/27.
//  Copyright (c) 2014年 Andy. All rights reserved.
//

#ifndef PerfectProject_MHLogDefine_h
#define PerfectProject_MHLogDefine_h


//#ifdef DEBUG
//// DEBUG模式下进行调试打印
//
//// 输出结果标记出所在类方法与行数
//#define DEF_DEBUG(fmt, ...)   NSLog((@"%s[Line: %d]™ " fmt), strrchr(__FUNCTION__,'['), __LINE__, ##__VA_ARGS__)
//
//#else
//
//#define DEF_DEBUG(...)   {}
//
//#endif



#if DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define DEF_DEBUG(...) printf("%s %s(%d): %s\n\n",[[NSDate fullTimeString] UTF8String], [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define DEF_DEBUG(...) do {} while (0)

#endif








#endif
