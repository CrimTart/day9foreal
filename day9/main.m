//
//  main.m
//  day9
//
//  Created by iOS-School-1 on 15.04.17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockTestClass : NSObject

- (void)testMemory;

@end

@interface BlockTestClass(){
    NSString *_str2;
}

@property(nonatomic, copy) NSString *str;
@property(nonatomic, copy) void (^test)(void);
@end

@implementation BlockTestClass

-(instancetype)init{
    self = [super init];
    if(self){
        _str = @"Hello World!!";
        _str2 = @"Hello World!";
    }
    return self;
    
}

-(void)testMemory{
    //__weak typeof(self) weakSelf = self; //to prevent retain cycle
    __weak typeof(self) weakSelf = self;
    self.test = ^void(void){
        //__strong typeof(self) strongSelf = weakSelf; //to keep the reference in case object is destroyed before block ends
        //NSLog(@"%@", strongSelf.str);
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"%@", strongSelf -> _str2);
    };
    self.test();
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //BlockTestClass *test = [BlockTestClass new];
        //[test testMemory];
        NSArray *arr = @[@(1),@(2),@(4),@(3),@(5)];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(3 == [obj intValue]){
                NSLog(@"%@", @(idx));
                //stop = YES;
            }
        }];
        
        /*dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                      ^{
                          NSLog(@"Hello world!");
                      });
        __block int a = 0;
        int (^inc)(void) = ^int(void){
            return ++a;
        };
        //inc(); - stack block (deleted out of scope)
        //[inc copy] - heap/malloc block (can be accessed from outside)*/
    }
    return 0;
}
