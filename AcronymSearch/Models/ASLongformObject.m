//
//  ASLongformObject.m
//  AcronymSearch
//
//  Created by Ibrahim Adnan on 9/26/15.
//  Copyright © 2015 Ibrahim Adnan. All rights reserved.
//

#import "ASLongformObject.h"

@implementation ASLongformObject


- (instancetype)initWithLongform:(NSString *)longform freq:(NSNumber *)freq since:(NSNumber *)since{
    
    self = [super init];
    if(self){
        _longform = longform;
        _freq = freq;
        _since = since;
    }
    
    return self;
}
@end
