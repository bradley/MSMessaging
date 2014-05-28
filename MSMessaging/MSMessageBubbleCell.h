//
//  MSMessageBubbleCell.h
//  MSMessaging
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

#import "MSMessageBubbleViewModel.h"

@interface MSMessageBubbleCell : UICollectionViewCell

@property (nonatomic, strong) MSMessageBubbleViewModel *viewModel;
@property (nonatomic, assign) CGFloat gradientOffset;

@end
