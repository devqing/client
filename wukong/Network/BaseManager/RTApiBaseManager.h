//
//  SharkApiBaseManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFURLResponse.h"

@class RTApiBaseManager;

//api回调
@protocol RTAPIManagerApiCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager;
- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager;
@end


@protocol RTAPIManagerCallbackDataReformer <NSObject>
@required

- (id)manager:(RTApiBaseManager *)manager reformData:(NSDictionary *)data;

@end


@protocol RTAPIManagerValidator <NSObject>
@required

- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;

@end


typedef NS_ENUM (NSUInteger, RTAPIManagerErrorType){
    RTAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    RTAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    RTAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    RTAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    RTAPIManagerErrorTypeTimeout,       //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    RTAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, RTAPIManagerRequestType){
    RTAPIManagerRequestTypeGet,
    RTAPIManagerRequestTypePost,
    RTAPIManagerRequestTypeDELETE,
    RTAPIManagerRequestTypeHEAD,
    RTAPIManagerRequestTypePUT
};

@protocol RTAPIManagerParamSourceDelegate <NSObject>
@required

- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager;

@end

/*
 RTAPIBaseManager的派生类必须符合这些protocal
 */
@protocol RTAPIManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (RTAPIManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (BOOL)shouldCache;

@end


@protocol RTAPIManagerInterceptor <NSObject>

@optional
- (void)manager:(RTApiBaseManager *)manager beforePerformSuccessWithResponse:(AIFURLResponse *)response;
- (void)manager:(RTApiBaseManager *)manager afterPerformSuccessWithResponse:(AIFURLResponse *)response;

- (void)manager:(RTApiBaseManager *)manager beforePerformFailWithResponse:(AIFURLResponse *)response;
- (void)manager:(RTApiBaseManager *)manager afterPerformFailWithResponse:(AIFURLResponse *)response;

- (BOOL)manager:(RTApiBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(RTApiBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;

@end

@interface RTApiBaseManager : NSObject

@property (nonatomic, weak) id<RTAPIManagerApiCallBackDelegate> delegate;
@property (nonatomic, weak) id<RTAPIManagerParamSourceDelegate> paramSource;
@property (nonatomic, weak) id<RTAPIManagerValidator> validator;
@property (nonatomic, weak) NSObject<RTAPIManager> *child; //里面会调用到NSObject的方法，所以这里不用id
@property (nonatomic, weak) id<RTAPIManagerInterceptor> interceptor;

/*
 baseManager是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。所以为了统一外部调用的入口，设置了这个变量。
 派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限。
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) RTAPIManagerErrorType errorType;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

- (id)fetchDataWithReformer:(id<RTAPIManagerCallbackDataReformer>)reformer;

//尽量使用loadData这个方法,这个方法会通过param source来获得参数，这使得参数的生成逻辑位于controller中的固定位置
- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

// 拦截器方法，继承之后需要调用一下super
//- (void)beforePerformSuccessWithResponse:(AIFURLResponse *)response;
//- (void)afterPerformSuccessWithResponse:(AIFURLResponse *)response;
//
//- (void)beforePerformFailWithResponse:(AIFURLResponse *)response;
//- (void)afterPerformFailWithResponse:(AIFURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;

- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
- (BOOL)shouldCache;

@end
