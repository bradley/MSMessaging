//
//  MessageBubbleLayoutSpec.h
//  GradientMessages
//
//  Created by Mark Stultz on 5/21/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

@interface MessageBubbleLayoutSpec : NSObject

@property (nonatomic, assign, readwrite) CGSize collectionViewSize;
@property (nonatomic, assign, readwrite) CGSize messageLabelSize;

@property (nonatomic, assign, readwrite) CGSize bubbleMaskImageSize;
@property (nonatomic, assign, readwrite) CGPoint bubbleMaskOffset;
@property (nonatomic, assign, readwrite) UIEdgeInsets messageBubbleInsets;
@property (nonatomic, assign, readwrite) UIEdgeInsets messageLabelInsets;

- (CGRect)bubbleMaskLayerContentsCenter;

- (CGSize)cellSize;

- (CGRect)bubbleMaskFrame;
- (CGRect)messageLabelFrame;
- (CGRect)gradientFrame;

@end
