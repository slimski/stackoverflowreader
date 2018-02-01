//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionModel.h"

@interface ModelMapper : NSObject

+ (QuestionModel *)getModelFromJson:(NSDictionary *)json;
+ (NSArray *)arrayFromJson:(NSDictionary *)json;

@end