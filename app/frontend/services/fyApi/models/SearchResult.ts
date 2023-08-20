/* generated using openapi-typescript-codegen -- do no edit */
/* istanbul ignore file */
/* tslint:disable */
/* eslint-disable */

import type { Commodity } from './Commodity';
import type { Component } from './Component';
import type { Equipment } from './Equipment';
import type { Model } from './Model';
import type { ModelModule } from './ModelModule';
import type { ModelPaint } from './ModelPaint';
import type { SearchResultTypeEnum } from './SearchResultTypeEnum';

export type SearchResult = {
    id: string;
    type: SearchResultTypeEnum;
    item: (Model | Component | Commodity | Equipment | ModelModule | ModelPaint);
};

