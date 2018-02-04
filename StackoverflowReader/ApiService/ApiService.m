//
// Created by Igor Nabokov on 01/02/2018.
// Copyright (c) 2018 Igor Nabokov. All rights reserved.
//

#import "ApiService.h"
#import "Constants.h"


@implementation ApiService

+ (void)getQuestionsWithString:(NSString *)searchString CompletionHandler: (void (^)(NSDictionary *, NSError *))completionHandler {
    NSString *search = [NSString stringWithFormat:SearchUrl, searchString];
    NSURL *url = [NSURL URLWithString:search relativeToURL:[self baseUrl]];
    [self requestUrl:url completionHandler:completionHandler];
}

#pragma mark Private

+ (void)requestUrl:(NSURL *)url completionHandler: (void (^)(NSDictionary *, NSError *))completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (error != nil) {
                                                completionHandler(nil, error);
                                                return;
                                            }
                                            NSError *jsonError;
                                            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                            if (jsonError != nil) {
                                                completionHandler(nil, jsonError);
                                                return;
                                            }

                                            completionHandler(result, nil);
                                        }];
    [task resume];
}

+ (NSURL *)baseUrl {
    return [NSURL URLWithString:BaseUrl];
}

@end