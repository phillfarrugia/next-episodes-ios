//
//  NEDataModelTypes.h
//  Next Episodes
//
//  Created by Phill Farrugia on 22/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEJsonDataModelDecoder.h"

typedef NS_ENUM(NSUInteger, NEDataModelType)
{
    NEDataModelTypeShow,
    NEDataModelTypeEpisode,
    
};

Class dataModelOfType(NEDataModelType dataModelType);
Class <NEJsonDataModelDecoder> dataModelDecoderOfType(NEDataModelType dataModelType);

