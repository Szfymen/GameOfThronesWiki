//
//  ArticleTableViewCell.h
//  GameOfThronesWiki
//
//  Created by Mateusz Tylman on 25/10/15.
//  Copyright © 2015 Mateusz Tylman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;

@end
