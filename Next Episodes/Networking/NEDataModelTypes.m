//
//  NEDataModelTypes.m
//  Next Episodes
//
//  Created by Phill Farrugia on 22/01/2015.
//  Copyright (c) 2015 Phill Farrugia. All rights reserved.
//

#import "NEDataModelTypes.h"
#import "NEShowModel.h"

Class dataModelOfType(NEDataModelType dataModelType)
{
    switch (dataModelType) {
        case NEDataModelTypeShow:
            return [NEShowModel class];
        case NEDataModelTypeEpisode:
            return nil; //nothing yet
    }
}
