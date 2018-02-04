//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuestionsTableDataManager : NSObject <UITableViewDelegate, UITableViewDataSource>

- (void)prepareDataForText:(NSString *)text completionHandler:(void (^)(BOOL))completionHandler;

@end