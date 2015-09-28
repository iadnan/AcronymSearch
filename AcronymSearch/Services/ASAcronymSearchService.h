//
//  ASAcronymSearchService.h
//  AcronymSearch
//
//  Created by Ibrahim Adnan on 9/23/15.
//  Copyright © 2015 Ibrahim Adnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAcronymSearchService : NSObject

typedef void (^ResponseBlock) (NSArray *meanings, NSError *error);

- (void)meaningsForAcronym:(NSString *)acronym withResponse:(ResponseBlock)responseBlock;

@end
