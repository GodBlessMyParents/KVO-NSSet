//
//  main.m
//  KVO2
//
//  Created by 姬武超 on 16/5/1.
//  Copyright © 2016年 姬武超. All rights reserved.
//

/**
 *                  手动触发KVO
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


@interface Person  : NSObject
@property (nonatomic,copy)NSString *name;

- (void)changePersonName: (NSString *)newName;

@end

@implementation Person

- (void)changePersonName:(NSString *)newName{
    /**
     *  手动触发KVO
     */
    [self willChangeValueForKey:@"name"];
    _name = newName;
    [self didChangeValueForKey:@"name"];
    /**
     第二种方式
     self.name = newName;
     这样写的目的是调用setter 方法
     */
}

- (instancetype)init{
    if (self = [super init]) {
        self.name = @"zhangsan";
    }
    return self;
}


@end





int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *per = [[Person alloc]init];
        
        Obsever *obs = [Obsever new];
        
        [per addObserver:obs forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        //1  可以触发KVO
        //        per.name = @"lisi1";
        //2  可以触发KVO
        //        [per setValue:@"lisi2" forKey:@"name"];
        //3  不可以触发KVO
        /**
         *  因为1 和 2  都是访问setter 方法的 可以推断出 KVO的触发是需要访问setter方法的
         */
        
        [per changePersonName:@"lisiQQ群"];
        
        
        /**
         *  在Foundation/NSKeyValueObserving.h可以找到以下方法
         1 - (void)willChangeValueForKey:(NSString *)key;
         2 - (void)didChangeValueForKey:(NSString *)key;
         3 + (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key;
         
         3 是控制是否自动发送通知，如果返回NO，KVO无法自动运作，需手动触发。因为前两个方法默认是在setter中实现的（用KVO做键值观察后，系统会在运行时重写被观察对象属性的setter），即：
         
         - (void)setName:(NSString *)name {
         [self willChangeValueForKey:@"name"];
         _name = name;
         [self didChangeValueForKey:@"name"];
         }
         */
        
        /***************问题****************
         *  那么怎么样让  [per changePersonName:@"lisi"]; 也触发KVO
         
         ************* 答案 **************
         手动触发changePersonName的方法中如下写法
         
         //这样就可以手动触发KVO了
         
         - (void)changePersonName:(NSString *)newName{
         [self willChangeValueForKey:@"name"];
         _name = newName;
         [self didChangeValueForKey:@"name"];
         }
         */
        
        [per removeObserver:obs forKeyPath:@"name" context:NULL];
        
    }
    return 0;
}







