//
//  RuntimeKit.m
//  ObjCRuntimeDemo
//
//  Created by Mr.LuDashi on 2017/1/4.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

#import "RuntimeKit.h"

@implementation RuntimeKit

/**
 获取类名

 @param class 相应类
 @return NSString：类名
 */
+ (NSString *)fetchClassName:(Class)class {
    const char *className = class_getName(class);
    return [NSString stringWithUTF8String:className];
}

/**
 获取成员变量
 
 @param class Class
 @return NSArray
 */
+ (NSArray *)fetchIvarList:(Class)class {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String: ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String: ivarName];
        
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的属性列表, 包括私有和公有属性，以及定义在延展中的属性
 
 @param class Class
 @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)class {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String: propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}


/**
 获取类的实例方法列表：getter, setter, 对象方法等。但不能获取类方法

 @param class <#class description#>
 @return <#return value description#>
 */
+ (NSArray *)fetchMethodList:(Class)class {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取协议列表
 
 @param class <#class description#>
 @return <#return value description#>
 */
+ (NSArray *)fetchProtocolList:(Class)class {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String: protocolName]];
    }
    
    return [NSArray arrayWithArray:mutableList];
    return nil;
}


/**
 往类上添加新的方法与其实现

 @param class 相应的类
 @param methodSel 方法的名
 @param methodSelImpl 对应方法实现的方法名
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl {
    Method method = class_getInstanceMethod(class, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}

/**
 方法交换
 
 @param class 交换方法所在的类
 @param method1 方法1
 @param method2 方法
 */
+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 secondMethod:(SEL)method2 {
    Method firstMethod = class_getInstanceMethod(class, method1);
    Method secondMethod = class_getInstanceMethod(class, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}


// class Test
+ (void)classTest:(Class)mClass method:(SEL)select1 method:(SEL)select2{
//    Method method = class_getInstanceMethod(mClass, select);
    
//    IMP methodIMP = method_getImplementation(method);
//    const char *types = method_getTypeEncoding(method);
    
//    Method method = class_getInstanceMethod(mClass, select2);
//    IMP methodIMP = method_getImplementation(method);
//    const char *types = method_getTypeEncoding(method);
    
//    NSString *methodName = NSStringFromSelector(select1);
    
    // 获取类的类名
//    const char * class_getName ( Class cls );
//    // 获取类的父类
//    Class class_getSuperclass ( Class cls );
//    
//    // 获取实例大小
//    size_t class_getInstanceSize ( Class cls );
//    // 获取类中指定名称实例成员变量的信息
//    Ivar class_getInstanceVariable ( Class cls, const char *name );
//    // 获取类成员变量的信息
//    Ivar class_getClassVariable ( Class cls, const char *name );
//    // 获取指定的属性
//    objc_property_t class_getProperty ( Class cls, const char *name );
//    
//    // 获取实例方法
//    Method class_getInstanceMethod ( Class cls, SEL name );
//    // 获取类方法
//    Method class_getClassMethod ( Class cls, SEL name );
//    // 获取方法的具体实现
//    IMP class_getMethodImplementation ( Class cls, SEL name );
//    IMP class_getMethodImplementation_stret ( Class cls, SEL name );
//
//    // 判断给定的Class是否是一个元类
//    BOOL class_isMetaClass ( Class cls );
//    Class class_getSuperclass ( Class cls );
//    
//    // 获取类中指定名称实例成员变量的信息
//    Ivar class_getInstanceVariable ( Class cls, const char *name );
//    
//    // 获取类成员变量的信息
//    Ivar class_getClassVariable ( Class cls, const char *name );
//    
//    // 添加成员变量
//    BOOL class_addIvar ( Class cls, const char *name, size_t size, uint8_t alignment, const char *types );
//    
//    // 获取整个成员变量列表
//    Ivar * class_copyIvarList ( Class cls, unsigned int *outCount );
//    
//    
//    // 获取指定的属性
//    objc_property_t class_getProperty ( Class cls, const char *name );
//    
//    // 获取属性列表
//    objc_property_t * class_copyPropertyList ( Class cls, unsigned int *outCount );
//    
//    // 为类添加属性
//    BOOL class_addProperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
//    
//    // 替换类的属性
//    void class_replaceProperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
//    
//    // 添加方法
//    BOOL class_addMethod ( Class cls, SEL name, IMP imp, const char *types );
//    
//    // 获取实例方法
//    Method class_getInstanceMethod ( Class cls, SEL name );
//    
//    // 获取类方法
//    Method class_getClassMethod ( Class cls, SEL name );
//    
//    // 获取所有方法的数组
//    Method * class_copyMethodList ( Class cls, unsigned int *outCount );
//    
//    // 替代方法的实现
//    IMP class_replaceMethod ( Class cls, SEL name, IMP imp, const char *types );
//    
//    // 返回方法的具体实现
//    IMP class_getMethodImplementation ( Class cls, SEL name );
//    
//    IMP class_getMethodImplementation_stret ( Class cls, SEL name );
//    
//    // 类实例是否响应指定的selector
//    BOOL class_respondsToSelector ( Class cls, SEL sel );
//    
//    // 添加协议
//    BOOL class_addProtocol ( Class cls, Protocol *protocol );
//    
//    // 返回类是否实现指定的协议
//    BOOL class_conformsToProtocol ( Class cls, Protocol *protocol );
//    
//    // 返回类实现的协议列表
//    Protocol * class_copyProtocolList ( Class cls, unsigned int *outCount );
//    
}

@end
