
//
//  ASAcronymSearchService.m
//  AcronymSearch
//
//  Created by Ibrahim Adnan on 9/23/15.
//  Copyright © 2015 Ibrahim Adnan. All rights reserved.
//

#import "ASAcronymSearchService.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASLongformObject.h"

@implementation ASAcronymSearchService

- (void)meaningsForAcronym:(NSString *)acronym withResponse:(ResponseBlock)responseBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",acronym];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];

    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject && [responseObject isKindOfClass:[NSArray class]]){
            NSArray *longformArray = [[responseObject firstObject] objectForKey:@"lfs"];
            NSMutableArray *resultArray = [NSMutableArray array];
            [longformArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *longformDict = (NSDictionary *)obj;
                NSString *lf = [longformDict valueForKey:@"lf"];
                NSNumber *freq = [longformDict valueForKey:@"freq"];
                NSNumber *since = [longformDict valueForKey:@"since"];
                NSArray *vars = [longformDict valueForKey:@"vars"];
                
                ASLongformObject *longform = [[ASLongformObject alloc] initWithLongform:lf freq:freq since:since];
                if(vars && [vars count] > 0){
                    NSMutableArray *variations = [NSMutableArray array];
                    [vars enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSDictionary *longformDict = (NSDictionary *)obj;
                        NSString *lf = [longformDict valueForKey:@"lf"];
                        NSNumber *freq = [longformDict valueForKey:@"freq"];
                        NSNumber *since = [longformDict valueForKey:@"since"];
                        ASLongformObject *longForm = [[ASLongformObject alloc] initWithLongform:lf freq:freq since:since];
                        [variations addObject:longForm];
                    }];
                    longform.variations = variations;
                }
                
                [resultArray addObject:longform];
            }];
            responseBlock(resultArray,nil);
        }else{
            responseBlock(nil,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        responseBlock(nil,error);
    }];
}

@end
