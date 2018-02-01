//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import "QuestionsTableDataManager.h"
#import "ApiService.h"
#import "QuestionModel.h"
#import "ModelMapper.h"

@interface QuestionsTableDataManager ()

@property (strong, nonatomic) NSArray<QuestionModel *> *questions;

@end

@implementation QuestionsTableDataManager {

}

- (void)prepareDataForText:(NSString *)text completionHandler:(void (^)(BOOL))completionHandler {
    __weak QuestionsTableDataManager *weakSelf = self;
    [ApiService getQuestionsWithString:text
                     CompletionHandler:^(NSDictionary *dictionary, NSError *error) {
                         if (error != nil) {
                             completionHandler(NO);
                             return;
                         }
                         NSMutableArray<QuestionModel *> *result = [NSMutableArray array];
                         NSArray *rawData = [ModelMapper arrayFromJson:dictionary];
                         for (NSDictionary *model in rawData) {
                             [result addObject:[ModelMapper getModelFromJson:model]];
                         }
                         weakSelf.questions = [result copy];
                        completionHandler(YES);
                     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questions != nil ? self.questions.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.text = self.questions[indexPath.row].title;
    return cell;
}


@end