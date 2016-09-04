//
//  main.m
//  KVO2
//
//  Created by 姬武超 on 16/5/1.
//  Copyright © 2016年 姬武超. All rights reserved.
//

/**
 *  在某个方法中设置多个属性通知从而达到依赖的目的。
    两种方法
 *
 */

#import <Foundation/Foundation.h>


@interface Obsever : NSObject

@end

@implementation Obsever

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    NSLog(@"%@---%@---%@",[super class],object ,change);
}

@end


@interface Person  : NSObject{
    Obsever *_obsever;
}

@property (nonatomic,copy)NSString *familyName;
@property (nonatomic,copy)NSString *givenName;
@property (nonatomic,copy)NSString *fullName;

@end

@implementation Person


- (instancetype)init{
    if (self = [super init]) {
        _familyName = @"li";
        _givenName = @"jun";
        _obsever = [[Obsever alloc]init];
        
        [self addObserver:_obsever forKeyPath:@"fullName" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
        
    }
    return self;
}


- (NSString *)fullName{
    return [NSString stringWithFormat:@"%@ %@",_familyName,_givenName];
}
//********************第一种***************
/*
- (void)setFamilyName:(NSString *)familyName{
    
    [self willChangeValueForKey:@"familyName"];
    [self willChangeValueForKey:@"fullName"];
    _familyName = familyName;
    _fullName = self.fullName;
    [self didChangeValueForKey:@"familyName"];
    [self didChangeValueForKey:@"fullName"];
}

- (void)setGivenName:(NSString *)givenName{
    
    [self willChangeValueForKey:@"givenName"];
    [self willChangeValueForKey:@"fullName"];
    
    _givenName = givenName;
    _fullName = self.fullName;
    
    [self didChangeValueForKey:@"givenName"];
    [self didChangeValueForKey:@"fullName"];
    
}
*/

//*****************第二种****************
/**
 *  进入Foundation/NSKeyValueObserving.h中可以发现这么个方法
 
 + (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key
 这里可以直接实现KVO的依赖。把Person.m中的两个setter干掉，然后代码这样写
 
 */
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    
    if ([key isEqualToString:@"fullName"]) {
        NSArray *affectingKeys = @[@"givenName",@"familyName"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
    }
    
    return keyPaths;
}



- (void)dealloc{
    [self removeObserver:_obsever forKeyPath:@"fullName" context:NULL];
}


@end





int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *per = [[Person alloc]init];
        [per setValue:@"jun fang" forKey:@"givenName"];
//        [per setValue:@"zhangsan" forKey:@"familyName"];
        NSLog(@"%@",per.fullName);
    }
    return 0;
}







