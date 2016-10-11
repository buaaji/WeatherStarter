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

- (void) updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(NSUInteger)number {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"num_of_days"] = @(number);
    parameters[@"q"] = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    parameters[@"format"] = @"json";
    parameters[@"key"] = WorldWeatherOnlineAPIKey;
    
    [self GET:@"weather.ashx" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)]){
            [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
            [self.delegate weatherHTTPClient:self didFailWithError:error];
        }
    }];
}






















































@end
