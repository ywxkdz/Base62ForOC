//
//  NSString+Base62.m
//  FORK
//
//  Created by Pepsin on 4/25/15.
//  Copyright (c) 2015 com.blink. All rights reserved.
//

#import "NSString+Base62.h"

static NSString * standardAlphabet = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

@implementation NSString (Base62)

-(NSString*) encodeWithKeySet:(NSString*)alphabet{
    
    alphabet = alphabet?:standardAlphabet;
    
    return  [self encodeWithKeySet:alphabet num:1024 num2:62];
}

-(NSString*) decodeWithKeySet:(NSString*)alphabet {
    
    return  [self decodeWithKeySet:alphabet num:62 num2:1024];
}

-(NSString*) encodeWithKeySet:(NSString*)alphabet num:(NSInteger)src_base num2:(NSInteger)dst_base{
    
    NSMutableArray *number = [NSMutableArray arrayWithCapacity:self.length];
    
    for (NSInteger i = 0; i < self.length; i++) {
        char ch       = [self characterAtIndex:i];
        NSNumber *num = [NSNumber numberWithChar:ch];
        [number addObject:num];
    }
    NSMutableArray *res           = [self convert:number num:src_base num2:dst_base];
    NSMutableString *resultString = [NSMutableString string];
    
    for (NSNumber *num in res) {
        NSString * ch = [alphabet substringWithRange:NSMakeRange(num.integerValue, 1)];
        [resultString appendString:ch];
    }
    return resultString;
}

-(NSString*) decodeWithKeySet:(NSString*)alphabet num:(NSInteger)src_base num2:(NSInteger)dst_base{
    
    NSMutableArray *number = [NSMutableArray arrayWithCapacity:self.length];
    for (NSInteger i = 0; i < self.length; i++) {
        NSString *chs = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [alphabet rangeOfString:chs];
        NSNumber *num = [NSNumber numberWithInteger:range.location];
        [number addObject:num];
    }
    NSMutableArray *res           = [self convert:number num:src_base num2:dst_base];
    NSMutableString *resultString = [NSMutableString string];
    
    for (NSNumber *num in res) {
        NSString * ch = [NSString stringWithFormat:@"%c",num.intValue];
        [resultString appendString:ch];
    }
    return resultString;
}

-(NSMutableArray*) convert:(NSArray*)number num:(NSInteger)src_base num2:(NSInteger)dst_base{
    
    NSMutableArray * res = [NSMutableArray array];
    NSMutableArray * quotient = [NSMutableArray array];
    NSInteger remainder = 0;
    
    while (number.count) {
        
        quotient = [NSMutableArray array];
        remainder = 0;
        NSInteger len = number.count;
        for (NSInteger i = 0 ; i != len ; i++){
            
            NSNumber * num = number[i];
            NSInteger  accumulator = num.integerValue + remainder * src_base;
            NSInteger  digit = accumulator / dst_base | 0;
            remainder = accumulator % dst_base;
            
            if (quotient.count || digit) {
                [quotient addObject:@(digit)];
            }
        }
        [res insertObject:@(remainder) atIndex:0];
        number = quotient;
    }
    return res;
}
@end
