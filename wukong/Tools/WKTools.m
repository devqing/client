//
//  WKTools.m
//  wukong
//
//  Created by liuweiqing on 16/4/7.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WKTools

+ (NSString *)md5:(NSString *)password
{
    const char *cStr = [password UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
