//
//  NSObject+PerformObjects.h
//  SXMutableParamsTransmit
//
//  Created by Sunny on 2019/5/29.
//  Copyright © 2019 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>



/**
 1.调用函数，不定参数
 2.多参数必须写全参数，否则crash
 3.函数不存在会导致crash
 objc_msgSend实现
 #warning 此函数容易崩溃，慎用！！！ 注意是否有返回值
 @param ...  赋值(obj , SEL , ...)
 @return 返回id类型
 */
#define SX_MsgSend(...)  ((id (*)(id, SEL, ...))objc_msgSend)(__VA_ARGS__)


/**
 1.调用函数，不定参数
 2.多参数必须写全参数，否则crash
 3.函数不存在不会导致crash
 IMP实现
 #warning 多参数必须写全参数，否则crash。
 
 @param _obj 对象
 @param _key 函数名、字符串
 @param ... 不定参数
 @return 无返回值
 */
#define SX_OBJECT_FUNC_ARGS( _obj, _key , ... )  {                  \
SEL setSelector = NSSelectorFromString(_key); \
if ([_obj respondsToSelector:setSelector]) {         \
IMP imp = [_obj methodForSelector:setSelector];  \
id (*func)(id, SEL, ...) = (void *)imp;         \
func (_obj, setSelector, ##__VA_ARGS__);                  \
}                                                    \
}




@interface NSObject (PerformObjects)



/**
 1.调用函数,参数不定，
 2.参数以nil结尾，多参数可以只写一个nil
 3.函数不存在不会导致crash
 NSInvocation实现
 #warning:多参数中间不能有nil，否则后续参数会直接为nil
 #warning:函数不存在可能会造成内存泄露memoryleaks
 @param selector 函数
 @param object 第一个参数，可以接多个参数
 @return 返回id类型
 */
- (id)sx_performSelector:(SEL)selector withObjects:(id)object,...NS_REQUIRES_NIL_TERMINATION;



@end


