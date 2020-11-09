//
//  NSObject+PerformObjects.m
//  SXMutableParamsTransmit
//
//  Created by Sunny on 2019/5/29.
//  Copyright © 2019 Sunny. All rights reserved.
//

#import "NSObject+PerformObjects.h"

@implementation NSObject (PerformObjects)


- (id)sx_performSelector:(SEL)selector withObjects:(id)object,...NS_REQUIRES_NIL_TERMINATION {
    
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        //实例方法nil，继续查找类方法
        signature = [self methodSignatureForSelector:selector];
        if (signature == nil) {
            return nil;
        }
    }
    
    // 设置参数 除self、_cmd以外的参数个数
    NSInteger paramsCount = signature.numberOfArguments - 2;
    
    NSMutableArray *params = [NSMutableArray array];
    // 添加第一个参数
    if (object == nil) {
        object = [NSNull null];
    }
    [params addObject:object];
    
    
    va_list args;
    va_start(args, object);
    for (int i = 0; i < paramsCount; i++) {
        id arg = va_arg(args, id);
        if (arg == nil) {
            arg = [NSNull null];
        }
        [params addObject:arg];
    }
    va_end(args);
    
    
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    
    paramsCount = MIN(paramsCount, params.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = params[i];
        if ([object isKindOfClass:[NSNull class]]) {
            object = nil;
        }
        // 从index2开始、
        [invocation setArgument:&object atIndex:(i + 2)];
    }
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    // 有返回值类型，才去获得返回值
    if (signature.methodReturnLength) {
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
}


/**
- (id)sx_performSelector:(SEL)selector withObjects:(id)object,...NS_REQUIRES_NIL_TERMINATION
{
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        //实例方法nil，继续查找类方法
        signature = [self methodSignatureForSelector:selector];
        if (signature == nil)
        {
            return nil;
        }
    }
    
    
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    NSMutableArray * params = [NSMutableArray array];
    if (object)
    {
        [params addObject:object];
        
        va_list args;
        va_start(args, object);
        
        id arg = nil;
        while ((arg = va_arg(args, id)))
        {
            [params addObject:arg];
        }
        va_end(args);
    }
    
    // 设置参数 除self、_cmd以外的参数个数
    NSInteger paramsCount = signature.numberOfArguments - 2;
    paramsCount = MIN(paramsCount, params.count);
    
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = params[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        // 从index2开始、
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
}
 */

@end
