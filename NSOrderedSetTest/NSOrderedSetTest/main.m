//
//  main.m
//  NSOrderedSetTest
//
//  Created by 姬武超 on 16/5/2.
//  Copyright © 2016年 姬武超. All rights reserved.
//
/**
 *  NSSet 是无虚的 NSOrderdSet是有序的 
    NSOrderdSet它跟 NSSet 具有相同的方法，还添加了一些 NSArray风格的方法，像 objectAtIndex:。
    讲解NSOrderdSet的很好的文章
 http://nshipster.cn/nsorderedset/
 *
 */
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *arrayOrd = [NSArray arrayWithObjects:@"he1" ,@"he2",@"he3",@"he4",@"he4",nil];
       BOOL isContain = [arrayOrd containsObject:@"he2"];
        NSLog(@"isContain--->%hhd",isContain);
        
        NSLog(@"arrayOrd--%@",arrayOrd);
        
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:arrayOrd];
        NSLog(@"NSOrderedSet--%@",orderedSet);//输出的结果显示只有一个he4 证明NSOrderedSet 有去重性
        
        BOOL isOrderSetContain =  [orderedSet containsObject:@"he2"];
        NSLog(@"isOrderSetContain %hhd",isOrderSetContain);

        
    }
    return 0;
}
