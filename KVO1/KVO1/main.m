//
//  main.m
//  KOV
//
//  Created by 姬武超 on 16/5/1.
//  Copyright © 2016年 姬武超. All rights reserved.
//

#import "Model.h"
#import <Foundation/Foundation.h>
@interface A : NSObject

@end

@implementation A

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *, id> *)change
                       context:(void *)context {
  NSLog(@"%@---%@----%@", [super class], object, change);
}
@end

/**
 *  B继承自A
 */
@interface B : A
@end

@implementation B
/**
 * 这样B就不会收到c的变化了 及重写了这个方法
 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *, id> *)change
                       context:(void *)context {
}
@end

@interface C : NSObject
@property(nonatomic, strong) id obj;
@property(nonatomic, strong) Model *model;
@end

@implementation C

- (instancetype)init {
  if (self = [super init]) {
    self.obj = @"default";
    self.model = [Model new];
    self.model.name = @"hehhe";
    self.model.age = 10;
  }
  return self;
}

@end

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    A *a = [A new];
    B *b = [B new];
    C *c = [[C alloc] init];
    //        Model *model = [Model new];
    //        model.name = @"zhangsan";
    //        model.age = 12;

    //        [model addObserver:a forKeyPath:@"model"
    //        options:NSKeyValueObservingOptionNew context:NULL];
    /**
     *  A 和 B 作为C的观察者
     */
    [c addObserver:a
         forKeyPath:@"obj"
            options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
            context:NULL];

    [c addObserver:b
         forKeyPath:@"obj"
            options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
            context:NULL];

    //        [c addObserver:a forKeyPath:@"model.name"
    //        options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld
    //        context:NULL];
    //
    //        [c addObserver:b forKeyPath:@"model.name"
    //        options:NSKeyValueObservingOptionNew |
    //        NSKeyValueObservingOptionOld context:NULL];
    //
    //        c.model.name = @"zhangshang";
    //        c.model.age = 19;

    c.obj = @"New Key";

    [c removeObserver:a forKeyPath:@"obj" context:NULL];
    [c removeObserver:b forKeyPath:@"obj" context:NULL];

    //        [c removeObserver:a forKeyPath:@"model.name" context:NULL];
    //        [c removeObserver:b forKeyPath:@"model.name" context:NULL];
  }
  return 0;
}
