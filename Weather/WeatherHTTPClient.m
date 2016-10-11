//
//  WeatherHTTPClient.m
//  Weather
//
//  Created by David on 10/11/16.
//  Copyright © 2016 Scott Sherwood. All rights reserved.
//

#import "WeatherHTTPClient.h"

static NSString * const WorldWeatherOnlineAPIKey = @"PASTE YOUR API KEY HERE";

static NSString * const WorldWeatherOnlineURLString = @"http://api.worldweatheronline.com/free/v1/";

@implementation WeatherHTTPClient

+ (instancetype)sharedWeatherHTTPClient {
    static WeatherHTTPClient *_sharedWeatherHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherHTTPClient = [[WeatherHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:WorldWeatherOnlineURLString]];
    });
    
    return _sharedWeatherHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}


@end
