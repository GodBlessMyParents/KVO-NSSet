//
//  main.m
//  NSSetTest
//
//  Created by 姬武超 on 16/5/2.
//  Copyright © 2016年 姬武超. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  *NSArray: 有序的集合，存储的元素在一个整块的内存中并按序排列
 
 NSSet: 无序的集合，散列存储, 每个元素只会存在一次
 NSSet的特性(确定性、无序性、互异性)
 
 
 NSDictionary: 无序, 键值对的不可变集合
 NSOrderedSet: 可以用来管理一组需要考虑顺序但又希望可以通过Key直接获取对应value的数据
  NSOrderedSet的特性(确定性、有序性、互异性) （自动去重）
 *
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*********************************** NSSet ******************
         *  不可变set
         */
        // set
        NSSet *set = [NSSet setWithObjects:@"zhangsan",@"lisi",@"wangwu", nil];
        NSLog(@"不可变--%@",set);
       
        //转变为数组
        NSArray *arr = [set allObjects];
        //便利数组输出
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"%@",obj);
        }];
        
        //获取第一个元素
        NSString * str = [set anyObject];
        NSLog(@"%@",str);
        
        
        //判断是否包含某个元素
       BOOL isHas =  [set containsObject:@"lisi"];
        NSLog(@"%hhd",isHas);
        
        //判断是否有交集
        NSSet *set2 = [NSSet setWithObjects:@"wangwu",@"mazi",@"liuer",@"xiaoming", nil];
        BOOL isIntersect = [set intersectsSet:set2];
        NSLog(@"isSame-->%hhd",isIntersect);
        
        //判断是否相等
        BOOL isEqu = [set isEqual:set2];
        NSLog(@"isEqu-->%hhd",isEqu);
        
        //判断是是另一个的子集
        
        BOOL isSub = [set2 isSubsetOfSet:set];
         NSLog(@"isSub-->%hhd",isSub);
        
        
        /**
         *  可变的set
         */
        NSMutableSet *muSet1 = [NSMutableSet setWithObjects:@"h1",@"h2",@"h3",@"h4", nil];
        
           NSMutableSet *muSet2 = [NSMutableSet setWithObjects:@"h1",@"h2",@"h3", nil];
        //1 添加元素
        [muSet2 addObject:@"h4"];
        NSLog(@"添加-muSet2-->%@",muSet2);
        
        //2 删除元素
        [muSet1 removeObject:@"h4"];
        NSLog(@"删除-muSet1-->%@",muSet1);
        /**
         *  结果：
         h1,
         h3,
         h2
          为什么不是按顺序输出？？(待研究)
         
         NSSet: 无序的集合，散列存储, 每个元素只会存在一次
         */
        
        
        // 从数组中添加集合
        NSArray *array = [NSArray arrayWithObjects:@"ee",nil];
        
        [muSet1 addObjectsFromArray:array];
         NSLog(@"添加数组之后muSet1-->%@",muSet1);
        
        //将元素的交集赋值给muSet1，并将muSet1里面的元素替换（交集）
        
        [muSet1 intersectSet:muSet2];
        NSLog(@"两个集合取交集--%@",muSet1);
        
        //将相同的去掉（补集）
        [muSet1 minusSet:muSet2];
        NSLog(@"将相同的去掉--%@",muSet1);
        
        // 取两者的并集
        
        [muSet1 unionSet:muSet2];
        
        NSLog(@"取两者的并集--%@",muSet1);
        
            }
    return 0;
}
