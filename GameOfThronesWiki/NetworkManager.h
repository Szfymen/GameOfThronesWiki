//
//  NetworkManager.h
//  GameOfThronesWiki
//
//  Created by Mateusz Tylman on 25/10/15.
//  Copyright © 2015 Mateusz Tylman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"

@interface NetworkManager : NSObject

+ (instancetype)sharedInstance;
- (void)getTopArticlesWithLimit:(NSInteger)limit
                   categoryType:(NSString *)category
          withCompletionHandler:(void (^)(NSArray *articleList))completionHandler;

@end
