//
//  NSObject+PPExtension.m
//  PPCategories
//
//  Created by zedxpp on 2016/10/31.
//  Copyright © 2016年 zedxpp. All rights reserved.
//

#import "NSObject+PPExtension.h"
#import <objc/runtime.h>

@implementation NSObject (PPExtension)

- (NSString *)logAllIvarAndValue
{
    unsigned int outCount = 0;
    Ivar *ivarList = class_copyIvarList([self class], &outCount);
    
    NSString *tmp = [NSString stringWithFormat:@"===== %@ IvarList =====\n", NSStringFromClass(self.class)];
    NSMutableString *strM = [NSMutableString stringWithString:tmp];
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivarList[i];
        const char *name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:ivarName];
        
        [strM appendString:[NSString stringWithFormat:@"%@ = %@", ivarName, value]];
        
        if (i != (outCount - 1)) {
            [strM appendString:@"\n"];
        }
        //        NSLog(@"%s = %@", name, value);
        //        [dictM setValue:value forKey:ivarName];
    }
    
    [strM insertString:@"\n" atIndex:0];
    
    [strM appendString:@"\n==============="];
    
    free(ivarList);
    
    return strM;
}

/* 例子
 ===== Person IvarList =====
 age = 0
 _name = jack
 _color = UIDeviceRGBColorSpace 0 0 1 1
 ===============
 */



//- (void)clearAllPropertyValue
//{
//    unsigned int outCount = 0;
//    Ivar *ivarList = class_copyIvarList([self class], &outCount);
//    
//    for (int i = 0; i < outCount; i++) {
//        Ivar ivar = ivarList[i];
//        const char *name = ivar_getName(ivar);
//        NSString *ivarName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
//        id value = [self valueForKey:ivarName];
//        if ([value isKindOfClass:[NSString class]]) {
//            [self setValue:@"" forKey:ivarName];
//        } else {
//            [self setValue:@0 forKey:ivarName];
//        }
//        
//        //        PPLog(@"%@", [value class])
//        
//        //        PPLog(@"%s = %@", name, value);
//        //        NSLog(@"%d", [value isKindOfClass:[NSString class]]);
//    }
//    free(ivarList);
//}


@end
