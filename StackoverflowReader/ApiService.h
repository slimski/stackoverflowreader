//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ApiService : NSObject

+ (void)getQuestionsWithString:(NSString *)searchString CompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler;

@end