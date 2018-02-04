//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import "ModelMapper.h"


@implementation ModelMapper

+ (QuestionModel *)getModelFromJson:(NSDictionary *)json {
    QuestionModel *result = [[QuestionModel alloc] init];
    result.title = json[@"title"];
    NSObject *owner = json[@"owner"];
    if (owner != nil && [owner isKindOfClass:[NSDictionary class]]) {
        result.ownerDisplayName = json[@"owner"][@"display_name"];
    }

    return result;
}

+ (NSArray *)arrayFromJson:(NSDictionary *)json {
    NSObject *items = json[@"items"];
    if (items != nil && [items isKindOfClass:[NSArray class]]) {
        return (NSArray *) items;
    }

    return [NSArray array];
}


@end