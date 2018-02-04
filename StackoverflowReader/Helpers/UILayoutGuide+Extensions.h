//
// Created by Igor Nabokov on 04/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILayoutGuide (Extensions)

- (void)bindViewToEdges:(UIView *)view;

- (void)bindViewToCenter:(UIView *)view;

@end