//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell

+ (CGFloat)calculateHeightForTitle:(NSString *)title andWidth:(CGFloat)width;

+ (NSString *)cellIdentifier;

- (void)setupWithTitle:(NSString *)title andAuthor:(NSString *)author;

@end