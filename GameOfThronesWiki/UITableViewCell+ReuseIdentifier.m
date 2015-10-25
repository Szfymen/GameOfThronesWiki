//
//  UITableViewCell+ReuseIdentifier.m
//  GameOfThronesWiki
//
//  Created by Mateusz Tylman on 25/10/15.
//  Copyright © 2015 Mateusz Tylman. All rights reserved.
//

#import "UITableViewCell+ReuseIdentifier.h"

@implementation UITableViewCell (ReuseIdentifier)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
