//
// Created by Igor Nabokov on 04/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import "UILayoutGuide+Extensions.h"


@implementation UILayoutGuide (Extensions)

- (void)bindViewToEdges:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
            [view.topAnchor constraintEqualToAnchor:self.topAnchor],
            [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [view.leftAnchor constraintEqualToAnchor:self.leftAnchor],
            [view.rightAnchor constraintEqualToAnchor:self.rightAnchor]
    ]];
}

- (void)bindViewToCenter:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
            [view.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [view.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];
}


@end