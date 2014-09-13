-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 June 2010                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */                                                                     */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS                                                                                    
--

CREATE TABLE pGRCompany (
        CompanyGuidID        UNIQUEIDENTIFIER DEFAULT NEWID(),
        CompanyId            int NOT NULL,
        Company              nvarchar(60) NOT NULL,
        IsRelative           int NULL,
        IsNegative           int NULL,
        IsMetric             int NULL,
        LastUpdated          datetime NULL,
        IsActive             int NULL,
        ClassifierId         int NULL DEFAULT 0,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRCompany PRIMARY KEY CLUSTERED 
                 ( CompanyGuidID ASC )

 )
go
 

CREATE TABLE pGRGarment (
        GarmentGuidID        UNIQUEIDENTIFIER DEFAULT NEWID(),
        CompanyGuidID        UNIQUEIDENTIFIER NULL,
        GarmentId            int NOT NULL,
        Garment              nvarchar(100) NOT NULL,
        CompanyId            int NULL,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRGarment PRIMARY KEY CLUSTERED 
                 ( GarmentGuidID ASC )

 )
go
 
CREATE INDEX pGRGarment_CompanyGuidID ON pGRGarment
 (
        CompanyGuidID                      ASC
 )
go
 
CREATE TABLE pGRGradeRule (
        GradeRuleGuidID      UNIQUEIDENTIFIER DEFAULT NEWID(),
        POMGradeTypeGuidId   UNIQUEIDENTIFIER  NULL,
        SizeRangeGuidId      UNIQUEIDENTIFIER  NULL,
        GradeRuleId          int NOT NULL,
        POMGradeTypeId       int NULL,
        SizeRangeId          int NULL,
        Incr1                nvarchar(18) NULL,
        Incr2                nvarchar(18) NULL,
        Incr3                nvarchar(18) NULL,
        Incr4                nvarchar(18) NULL,
        Incr5                nvarchar(18) NULL,
        Incr6                nvarchar(18) NULL,
        Incr7                nvarchar(18) NULL,
        Incr8                nvarchar(18) NULL,
        Incr9                nvarchar(18) NULL,
        Incr10               nvarchar(18) NULL,
        Incr11               nvarchar(18) NULL,
        Incr12               nvarchar(18) NULL,
        Incr13               nvarchar(18) NULL,
        Incr14               nvarchar(18) NULL,
        Incr15               nvarchar(18) NULL,
        Incr16               nvarchar(18) NULL,
        Incr17               nvarchar(18) NULL,
        Incr18               nvarchar(18) NULL,
        Incr19               nvarchar(18) NULL,
        Incr20               nvarchar(18) NULL,
        Incr21               nvarchar(18) NULL,
        Incr22               nvarchar(18) NULL,
        Incr23               nvarchar(18) NULL,
        Incr24               nvarchar(18) NULL,
        Incr25               nvarchar(18) NULL,
        Incr26               nvarchar(18) NULL,
        Incr27               nvarchar(18) NULL,
        Incr28               nvarchar(18) NULL,
        Incr29               nvarchar(18) NULL,
        Incr30               nvarchar(18) NULL,
        Incr31               nvarchar(18) NULL,
        Incr32               nvarchar(18) NULL,
        Incr33               nvarchar(18) NULL,
        Incr34               nvarchar(18) NULL,
        Incr35               nvarchar(18) NULL,
        Incr36               nvarchar(18) NULL,
        Incr37               nvarchar(18) NULL,
        Incr38               nvarchar(18) NULL,
        Incr39               nvarchar(18) NULL,
        Incr40               nvarchar(18) NULL,
        Incr41               nvarchar(18) NULL,
        Incr42               nvarchar(18) NULL,
        Incr43               nvarchar(18) NULL,
        Incr44               nvarchar(18) NULL,
        Incr45               nvarchar(18) NULL,
        Incr46               nvarchar(18) NULL,
        Incr47               nvarchar(18) NULL,
        Incr48               nvarchar(18) NULL,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRGradeRule PRIMARY KEY CLUSTERED 
                 ( GradeRuleGuidID ASC )
)
go
 
CREATE INDEX pGRGradeRule_SizeRangeGuidId ON pGRGradeRule
 (
        SizeRangeGuidId                    ASC
 )
go
 
CREATE INDEX pGRGradeRule_POMGradeTypeGuidId ON pGRGradeRule
 (
        POMGradeTypeGuidId                 ASC
 )
go
 
 
 CREATE TABLE pGRGradeType (
        GradeTypeGuidId      UNIQUEIDENTIFIER DEFAULT NEWID(),
        CompanyGuidID        UNIQUEIDENTIFIER NULL,
        GradeTypeId          int NOT NULL,
        GradeTypeCode        nvarchar(4) NULL,
        GradeTypeDesc        nvarchar(100) NOT NULL,
        CompanyId            int NULL,
        GTSortField          float NULL DEFAULT 0,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRGradeType PRIMARY KEY CLUSTERED 
                 ( GradeTypeGuidId ASC )
 )
go
 
CREATE INDEX pGRGradeType_CompanyGuidID ON pGRGradeType
(
        CompanyGuidID                      ASC
)
go
 
CREATE INDEX pGRGradeType_GradeTypeCode ON pGRGradeType
(
        GradeTypeCode                  ASC
)
go
 
 
CREATE TABLE pGRGrmntClassImg (
        Garment_Cls_ImgGuidId  UNIQUEIDENTIFIER DEFAULT NEWID(),
        GarmentGuidID          UNIQUEIDENTIFIER NULL,
        SizeClassGuidId        UNIQUEIDENTIFIER NULL,
        Garment_Cls_ImgId      int NOT NULL,
        GarmentId              int NULL,
        SizeClassId            int NULL,
        How2MeasName           nvarchar(128) NULL,
        How2MeasText           nvarchar(510) NULL,
        ImageSerialNumber      int NULL DEFAULT 0,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRGrmntClassImg PRIMARY KEY CLUSTERED 
                 ( Garment_Cls_ImgGuidId ASC )
 )
go
 
CREATE INDEX pGRGrmntClassImg_GarmentGuidID ON pGRGrmntClassImg
(
        GarmentGuidID                      ASC
)
go
 
CREATE INDEX pGRGrmntClassImg_SizeClassGuidId ON pGRGrmntClassImg
(
        SizeClassGuidId                    ASC
)
go
 
CREATE TABLE pGRKeyMeasurement (
        KeyMeasurementGuidId  UNIQUEIDENTIFIER DEFAULT NEWID(),
        POMGradeTypeGuidId   UNIQUEIDENTIFIER  NULL,
        KeyMeasurementId      int NOT NULL,
        Garment_Cls_ImgId     int NULL,
        POMGradeTypeId        int NULL,
        IsPrimaryKeyMeas      int NULL DEFAULT -1,
        ImageSerialNumber      int NULL DEFAULT 0,
        CONSTRAINT PK_pGRKeyMeasurement PRIMARY KEY CLUSTERED 
                 ( KeyMeasurementGuidId ASC )
 )
go
 
 CREATE INDEX pGRKeyMeasurement_Garment_Cls_ImgId ON pGRKeyMeasurement
 (
        Garment_Cls_ImgId              ASC
 )
go
 
CREATE INDEX pGRKeyMeasurement_POMGradeTypeGuidId ON pGRKeyMeasurement
 (
        POMGradeTypeGuidId                 ASC
 )
go
 
CREATE TABLE pGRPOM (
        POMGuidId            UNIQUEIDENTIFIER DEFAULT NEWID(),
        CompanyGuidID        UNIQUEIDENTIFIER NULL,
        POMId                int NOT NULL,
        RefCode              nvarchar(12) NOT NULL,
        POMDesc              nvarchar(100) NOT NULL,
        CompanyId            int NULL,
        How2MeasName         nvarchar(128) NULL,
        How2MeasText         nvarchar(500) NULL,
        VideoSerialNumber    int NULL DEFAULT 0,
        SortField            float NULL DEFAULT 0,
        CnvtPOMDesc          nvarchar(100) NULL,
        ImageSerialNumber    int NULL DEFAULT 0,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRPOM PRIMARY KEY CLUSTERED 
                 ( POMGuidId ASC )
 )
go

 
CREATE TABLE pGRPOMGradeType (
        POMGradeTypeGuidId    UNIQUEIDENTIFIER DEFAULT NEWID(),
        POMGuidId             UNIQUEIDENTIFIER NULL,
        GradeTypeGuidId       UNIQUEIDENTIFIER  NULL,
        POMGradeTypeId        int NOT NULL,
        POMId                 int NULL,
        GradeTypeId           int NULL,
        CONSTRAINT PK_pGRPOMGradeType PRIMARY KEY CLUSTERED 
                 ( POMGradeTypeGuidId ASC )
 )
go
 
CREATE INDEX pGRPOMGradeType_POMGradeTypeGuidId ON pGRPOMGradeType
 (
        POMGradeTypeGuidId                    ASC
 )
go
 
CREATE INDEX pGRPOMGradeType_POMGuidId ON pGRPOMGradeType
 (
        POMGuidId                          ASC
 )
go
 
 
CREATE INDEX pPOMGradeTypePOM_GradeTypeGuidId ON pGRPOMGradeType
 (
        GradeTypeGuidId                   ASC
 )
go
 
CREATE TABLE pGRSizeClass (
        SizeClassGuidId      UNIQUEIDENTIFIER DEFAULT NEWID(),
        CompanyGuidID        UNIQUEIDENTIFIER NULL,
        SizeClassId          int NOT NULL,
        SizeClass            nvarchar(60) NOT NULL,
        CompanyId            int NULL,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRSizeClass PRIMARY KEY CLUSTERED 
                 ( SizeClassGuidId ASC )
 )
go
 
CREATE INDEX pGRSizeClass_CompanyGuidID ON pGRSizeClass
 (
        CompanyGuidID                      ASC
 )
go
 
 
CREATE TABLE pGRSizeRange (
        SizeRangeGuidId      UNIQUEIDENTIFIER DEFAULT NEWID(),
        SizeClassGuidId      UNIQUEIDENTIFIER NULL,
        SizeRangeId          int NOT NULL,
        SizeRange            nvarchar(60) NULL,
        SizeClassId          int NULL,
        SizeName1            nvarchar(16) NULL,
        SizeName2            nvarchar(16) NULL,
        SizeName3            nvarchar(16) NULL,
        SizeName4            nvarchar(16) NULL,
        SizeName5            nvarchar(16) NULL,
        SizeName6            nvarchar(16) NULL,
        SizeName7            nvarchar(16) NULL,
        SizeName8            nvarchar(16) NULL,
        SizeName9            nvarchar(16) NULL,
        SizeName10           nvarchar(16) NULL,
        SizeName11           nvarchar(16) NULL,
        SizeName12           nvarchar(16) NULL,
        SizeDesc1            nvarchar(16) NULL,
        SizeDesc2            nvarchar(16) NULL,
        SizeDesc3            nvarchar(16) NULL,
        SizeDesc4            nvarchar(16) NULL,
        SizeDesc5            nvarchar(16) NULL,
        SizeDesc6            nvarchar(16) NULL,
        SizeDesc7            nvarchar(16) NULL,
        SizeDesc8            nvarchar(16) NULL,
        SizeDesc9            nvarchar(16) NULL,
        SizeDesc10           nvarchar(16) NULL,
        SizeDesc11           nvarchar(16) NULL,
        SizeDesc12           nvarchar(16) NULL,
        SizeName13           nvarchar(16) NULL,
        SizeDesc13           nvarchar(16) NULL,
        SizeName14           nvarchar(16) NULL,
        SizeDesc14           nvarchar(16) NULL,
        SizeName15           nvarchar(16) NULL,
        SizeDesc15           nvarchar(16) NULL,
        SizeName16           nvarchar(16) NULL,
        SizeDesc16           nvarchar(16) NULL,
        SizeName17           nvarchar(16) NULL,
        SizeDesc17           nvarchar(16) NULL,
        SizeName18           nvarchar(16) NULL,
        SizeDesc18           nvarchar(16) NULL,
        SizeName19           nvarchar(16) NULL,
        SizeDesc19           nvarchar(16) NULL,
        SizeName20           nvarchar(16) NULL,
        SizeDesc20           nvarchar(16) NULL,
        SizeName21           nvarchar(16) NULL,
        SizeDesc21           nvarchar(16) NULL,
        SizeName22           nvarchar(16) NULL,
        SizeDesc22           nvarchar(16) NULL,
        SizeName23           nvarchar(16) NULL,
        SizeDesc23           nvarchar(16) NULL,
        SizeName24           nvarchar(16) NULL,
        SizeDesc24           nvarchar(16) NULL,
        SizeName25           nvarchar(16) NULL,
        SizeDesc25           nvarchar(16) NULL,
        SizeName26           nvarchar(16) NULL,
        SizeDesc26           nvarchar(16) NULL,
        SizeName27           nvarchar(16) NULL,
        SizeDesc27           nvarchar(16) NULL,
        SizeName28           nvarchar(16) NULL,
        SizeDesc28           nvarchar(16) NULL,
        SizeName29           nvarchar(16) NULL,
        SizeDesc29           nvarchar(16) NULL,
        SizeName30           nvarchar(16) NULL,
        SizeDesc30           nvarchar(16) NULL,
        SizeName31           nvarchar(16) NULL,
        SizeDesc31           nvarchar(16) NULL,
        SizeName32           nvarchar(16) NULL,
        SizeDesc32           nvarchar(16) NULL,
        SizeName33           nvarchar(16) NULL,
        SizeDesc33           nvarchar(16) NULL,
        SizeName34           nvarchar(16) NULL,
        SizeDesc34           nvarchar(16) NULL,
        SizeName35           nvarchar(16) NULL,
        SizeDesc35           nvarchar(16) NULL,
        SizeName36           nvarchar(16) NULL,
        SizeDesc36           nvarchar(16) NULL,
        SizeName37           nvarchar(16) NULL,
        SizeDesc37           nvarchar(16) NULL,
        SizeName38           nvarchar(16) NULL,
        SizeDesc38           nvarchar(16) NULL,
        SizeName39           nvarchar(16) NULL,
        SizeDesc39           nvarchar(16) NULL,
        SizeName40           nvarchar(16) NULL,
        SizeDesc40           nvarchar(16) NULL,
        SizeName41           nvarchar(16) NULL,
        SizeDesc41           nvarchar(16) NULL,
        SizeName42           nvarchar(16) NULL,
        SizeDesc42           nvarchar(16) NULL,
        SizeName43           nvarchar(16) NULL,
        SizeDesc43           nvarchar(16) NULL,
        SizeName44           nvarchar(16) NULL,
        SizeDesc44           nvarchar(16) NULL,
        SizeName45           nvarchar(16) NULL,
        SizeDesc45           nvarchar(16) NULL,
        SizeName46           nvarchar(16) NULL,
        SizeDesc46           nvarchar(16) NULL,
        SizeName47           nvarchar(16) NULL,
        SizeDesc47           nvarchar(16) NULL,
        SizeName48           nvarchar(16) NULL,
        SizeDesc48           nvarchar(16) NULL,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRSizeRange PRIMARY KEY CLUSTERED 
                 ( SizeRangeGuidId ASC )
)
go
 
CREATE INDEX pGRSizeRange_SizeClassGuidId ON pGRSizeRange
 (
        SizeClassGuidId                    ASC
 )
go
 

CREATE TABLE pGRTolerance (
        ToleranceGuidId      UNIQUEIDENTIFIER DEFAULT NEWID(),
        POMGradeTypeGuidId   UNIQUEIDENTIFIER NULL,
        ToleranceId          int NOT NULL,
        Garment_Cls_ImgId    int NULL,
        POMGradeTypeId       int NULL,
        TolPlus              nvarchar(18) NULL,
        TolMinus             nvarchar(18) NULL,
        IsOnQA               int NULL DEFAULT -1,
        CUser                nvarchar(25) NULL,
        CDate                datetime null,
        Muser                nvarchar(25) NULL,
        MDate                datetime null,
        CONSTRAINT PK_pGRTolerance PRIMARY KEY CLUSTERED 
                 ( ToleranceGuidId ASC )
 )
go
 
CREATE INDEX pGRTolerance_Garment_Cls_ImgId ON pGRTolerance
 (
        Garment_Cls_ImgId              ASC
 )
go
 
CREATE INDEX pGRTolerance_POMGradeTypeGuidId ON pGRTolerance
 (
        POMGradeTypeGuidId                 ASC
 )
go


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '157', GetDate())
GO

 