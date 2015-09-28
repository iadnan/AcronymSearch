//
//  ASLongForm.h
//  AcronymSearch
//
//  Created by Ibrahim Adnan on 9/26/15.
//  Copyright © 2015 Ibrahim Adnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASLongformObject : NSObject

@property (nonatomic,strong) NSString *longform;
@property (nonatomic,strong) NSNumber *freq;
@property (nonatomic,strong) NSNumber *since;
@property (nonatomic,strong) NSArray<ASLongformObject *> *variations;


- (instancetype)initWithLongform:(NSString *)longform freq:(NSNumber *)freq since:(NSNumber *)since;

@end
