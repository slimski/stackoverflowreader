//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import "QuestionsTableDataManager.h"
#import "ApiService.h"
#import "QuestionModel.h"
#import "ModelMapper.h"
#import "QuestionTableViewCell.h"

@interface QuestionsTableDataManager ()

@property (strong, nonatomic) NSArray<QuestionModel *> *questions;

@end

@implementation QuestionsTableDataManager

- (void)prepareDataForText:(NSString *)text completionHandler:(void (^)(BOOL))completionHandler {
    if (text.length == 0) {
        self.questions = [NSArray array];
    }

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
    QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[QuestionTableViewCell cellIdentifier]];
    QuestionModel *question = self.questions[indexPath.row];
    [cell setupWithTitle:question.title andAuthor:question.ownerDisplayName];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionModel *question = self.questions[indexPath.row];
    return [QuestionTableViewCell calculateHeightForTitle:question.title andWidth:tableView.frame.size.width];
}

@end