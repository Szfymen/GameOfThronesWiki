//
//  NetworkManager.m
//  GameOfThronesWiki
//
//  Created by Mateusz Tylman on 25/10/15.
//  Copyright © 2015 Mateusz Tylman. All rights reserved.
//

#define baseURL @"http://gameofthrones.wikia.com/api/v1/"

#import "NetworkManager.h"
@interface NetworkManager()

@end
@implementation NetworkManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getTopArticlesWithLimit:(NSInteger)limit
                   categoryType:(NSString *)category
          withCompletionHandler:(void (^)(NSArray *articleList))completionHandler {
    
    NSString *urlString = [NSString stringWithFormat:@"Articles/Top?expand=1&category=%@&limit=%ld",category, (long)limit];

    NSURL *URL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",baseURL, urlString]];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            if (data) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSArray *articleList = [self parseArticleJSON:json];
                if (articleList) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionHandler(articleList);
                    });
                }
            }
        } else {
            [self handleError:error];
        }
    }] resume];
    
}
#pragma mark - Error Handle
- (void)handleError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
}
#pragma mark - Parse Methods
- (NSArray *)parseArticleJSON:(NSDictionary *)json {
    NSMutableArray *articleList = [[NSMutableArray alloc] init];
    NSArray *items = [json objectForKey:@"items"];
    
    for (NSDictionary *item in items) {
        ArticleModel *articleModel = [[ArticleModel alloc] init];
        articleModel.title = [item objectForKey:@"title"];
        articleModel.abstract = [item objectForKey:@"abstract"];
        
        [articleList addObject:articleModel];
    }
    return articleList;
}
@end
