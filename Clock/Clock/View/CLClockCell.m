//
//  CLClockCell.m
//  Clock
//
//  Created by wangtao on 13-12-29.
//  Copyright (c) 2013年 wangtao. All rights reserved.
//

#import "CLClockCell.h"

@implementation CLClockCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:215.0f/255 green:215.0f/255 blue:215.0f/255 alpha:0];
        self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width, 20)];
        [self.timeLable setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.timeLable];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(CLClockObject *)object
{
    self.timeLable.text =  [object.fireDate dateToString:@"HH:mm"];
}
@end
