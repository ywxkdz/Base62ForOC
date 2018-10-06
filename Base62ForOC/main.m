//
//  main.m
//  Base62ForOC
//
//  Created by Liumao on 2018/10/6.
//  Copyright © 2018 SMIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Base62.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString * oriString = @"080006E2-5666-8888-49C1-3FD9FC77DC0A";
        NSString *encoded = [oriString encodeWithKeySet:nil];
        NSLog(@"encodeWithKeySet --  %@" ,encoded);
        NSLog(@"decodeWithKeySet --  %@" , [encoded decodeWithKeySet:nil]);

    }
    return 0;
}
