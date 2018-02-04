//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import "QuestionTableViewCell.h"
#import "Constants.h"

const CGFloat Margin = 8.0f;

@interface QuestionTableViewCell ()

@property (weak, nonatomic) UILabel *authorLabel;
@property (weak, nonatomic) UILabel *titleLabel;

@end


@implementation QuestionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        UILabel *authorLabel = [[UILabel alloc] init];
        authorLabel.font = [QuestionTableViewCell labelFont];
        [self addSubview:authorLabel];
        self.authorLabel = authorLabel;

        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [QuestionTableViewCell labelFont];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.numberOfLines = 0;
    }

    return self;
}

+ (UIFont *)labelFont {
    return [UIFont systemFontOfSize:14];
}

+ (CGFloat)calculateHeightForTitle:(NSString *)title andWidth:(CGFloat)width {
    CGSize constraint = CGSizeMake(width - 2 * Margin, CGFLOAT_MAX);

    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [title boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[self labelFont]}
                                                  context:context].size;

    CGSize size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));

    return size.height + 3 * Margin + [self labelFont].lineHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutAuthor];
    [self layoutTitle];
}

- (void)layoutAuthor {
    CGRect frame = CGRectMake(
            Margin,
            Margin,
            self.frame.size.width - 2 * Margin,
            self.authorLabel.font.lineHeight);
    self.authorLabel.frame = frame;
}

- (void)layoutTitle {
    CGRect frame = CGRectMake(
            Margin,
            self.authorLabel.font.lineHeight + 2 * Margin,
            self.frame.size.width - 2 * Margin,
            self.titleLabel.font.lineHeight);
    self.titleLabel.frame = frame;
    [self.titleLabel sizeToFit];
}

+ (NSString *)cellIdentifier {
    return @"cell";
}

- (void)setupWithTitle:(NSString *)title andAuthor:(NSString *)author {
    self.titleLabel.text = title;
    self.authorLabel.text = [NSString stringWithFormat:@"%@: %@", AuthorTitleHeader, author];
}

@end