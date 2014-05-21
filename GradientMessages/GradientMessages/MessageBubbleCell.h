//
//  MessageBubbleCell.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

@class MessageBubbleViewModel;

@interface MessageBubbleCell : UICollectionViewCell

@property (nonatomic, strong) MessageBubbleViewModel *viewModel;
@property (nonatomic, assign) CGFloat gradientOffset;

@end
