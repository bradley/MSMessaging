//
//  MessageInputViewModel.m
//  GradientMessages
//
//  Created by Mark Stultz on 5/22/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "MessageInputViewModel.h"

@interface MessageInputViewModel ()

@property (nonatomic, strong) MessageInputLayoutSpec *layoutSpec;

@end

@implementation MessageInputViewModel

- (instancetype)initWithLayoutSpec:(MessageInputLayoutSpec *)layoutSpec
{
	self = [super init];
	if (self) {
		self.layoutSpec = layoutSpec;
	}
	
	return self;
}

@end
