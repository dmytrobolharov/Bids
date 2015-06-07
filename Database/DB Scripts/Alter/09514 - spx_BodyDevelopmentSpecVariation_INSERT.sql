IF OBJECT_ID(N'[dbo].[spx_BodyDevelopmentSpecVariation_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodyDevelopmentSpecVariation_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BodyDevelopmentSpecVariation_INSERT]  
(  
@BodyID uniqueidentifier,  
@NewBodyID nvarchar(50),  
@CreatedBy nvarchar(50),  
@CreatedDate nvarchar(50)  
)  
AS  
  
SET NOCOUNT ON  
  
  
DECLARE @POMTempItemID nvarchar(50)  
DECLARE @POMTempID nvarchar(50)  
DECLARE @Row_Count int  
DECLARE @Row_Loop int  
DECLARE @Size0 nvarchar (7), @Size1 nvarchar (7), @Size2 nvarchar (7), @Size3 nvarchar (7), 
		@Size4 nvarchar (7), @Size5 nvarchar (7), @Size6 nvarchar (7), @Size7 nvarchar (7), 
		@Size8 nvarchar (7), @Size9 nvarchar (7), @Size10 nvarchar (7), @Size11 nvarchar (7), 
		@Size12 nvarchar (7), @Size13 nvarchar (7), @Size14 nvarchar (7), @Size15 nvarchar (7), 
		@Size16 nvarchar (7),  @Size17 nvarchar (7), @Size18 nvarchar (7), @Size19 nvarchar (7), 
		@sort nvarchar(5)  
  
  
BEGIN  
CREATE TABLE #tempBodySpec1 (  
 RecID int IDENTITY(1,1)  NOT NULL,  
 SpecID  uniqueidentifier,  
 SpecMasterID uniqueidentifier,  
 BodyID uniqueidentifier,  
 POMTempItemID uniqueidentifier,  
 POMLibraryID uniqueidentifier,  
 POMTempID uniqueidentifier,  
 BodySet int,  
 Critical int,  
 POM nvarchar (10),  
 PointMeasur nvarchar (225),  
 TOL numeric(18, 4) NOT NULL ,  
 TOLN numeric(18, 4) NOT NULL ,  
 Spec decimal(18, 4) NOT NULL ,  
 Proto0 numeric(18, 4) NOT NULL ,  
 Proto1 numeric(18, 4) NOT NULL ,  
 Proto2 numeric(18, 4) NOT NULL ,  
 Proto3 numeric(18, 4) NOT NULL ,  
 Proto4 numeric(18, 4) NOT NULL ,  
 Proto5 numeric(18, 4) NOT NULL ,  
 Proto6 numeric(18, 4) NOT NULL ,  
 Proto7 numeric(18, 4) NOT NULL ,  
 Proto8 numeric(18, 4) NOT NULL ,  
 Proto9 numeric(18, 4) NOT NULL ,  
 Proto10 numeric(18, 0) NOT NULL ,  
 Proto11 numeric(18, 0) NOT NULL ,  
 Proto12 numeric(18, 4) NOT NULL ,  
 Proto13 numeric(18, 4) NOT NULL ,  
 Proto14 numeric(18, 4) NOT NULL ,  
 Proto15 numeric(18, 4) NOT NULL ,  
 Proto16 numeric(18, 4) NOT NULL ,  
 Proto17 numeric(18, 4) NOT NULL ,  
 Proto18 numeric(18, 4) NOT NULL ,  
 Proto19 numeric(18, 4) NOT NULL ,  
 Grade0 numeric(18, 4) NOT NULL ,  
 Grade1 numeric(18, 4) NOT NULL ,  
 Grade2 numeric(18, 4) NOT NULL ,  
 Grade3 numeric(18, 4) NOT NULL ,  
 Grade4 numeric(18, 4) NOT NULL ,  
 Grade5 numeric(18, 4) NOT NULL ,  
 Grade6 numeric(18, 4) NOT NULL ,  
 Grade7 numeric(18, 4) NOT NULL ,  
 Grade8 numeric(18, 4) NOT NULL ,  
 Grade9 numeric(18, 4) NOT NULL ,  
 Grade10 numeric(18, 4) NOT NULL ,  
 Grade11 numeric(18, 4) NOT NULL ,  
 Grade12 numeric(18, 4) NOT NULL ,  
 Grade13 numeric(18, 4) NOT NULL ,  
 Grade14 numeric(18, 4) NOT NULL ,  
 Grade15 numeric(18, 4) NOT NULL ,  
 Grade16 numeric(18, 4) NOT NULL ,  
 Grade17 numeric(18, 4) NOT NULL ,  
 Grade18 numeric(18, 4) NOT NULL ,  
 Grade19 numeric(18, 4) NOT NULL ,  
 Size0 numeric(18, 4) NOT NULL ,  
 Size1 numeric(18, 4) NOT NULL ,  
 Size2 numeric(18, 4) NOT NULL ,  
 Size3 numeric(18, 4) NOT NULL ,  
 Size4 numeric(18, 4) NOT NULL ,  
 Size5 numeric(18, 4) NOT NULL ,  
 Size6 numeric(18, 4) NOT NULL ,  
 Size7 numeric(18, 4) NOT NULL ,  
 Size8 numeric(18, 4) NOT NULL ,  
 Size9 numeric(18, 4) NOT NULL ,  
 Size10 numeric(18, 4) NOT NULL ,  
 Size11 numeric(18, 4) NOT NULL ,  
 Size12 numeric(18, 4) NOT NULL ,  
 Size13 numeric(18, 4) NOT NULL ,  
 Size14 numeric(18, 4) NOT NULL ,  
 Size15 numeric(18, 4) NOT NULL ,  
 Size16 numeric(18, 4) NOT NULL ,  
 Size17 numeric(18, 4) NOT NULL ,  
 Size18 numeric(18, 4) NOT NULL ,  
 Size19 numeric(18, 4) NOT NULL ,  
 CDate datetime,  
 CUser nvarchar (200),  
 MDate datetime,  
 MUser nvarchar (200),  
 Change int,  
 Sort nvarchar (5),  
 HowToMeasurText nvarchar (4000),  
 HowToMeasurImage nvarchar (100)    
)   
END  
  
BEGIN  
CREATE TABLE #tempBodySpec2 (  
 RecID int IDENTITY(1,1)  NOT NULL,  
 SpecID  uniqueidentifier,  
 SpecMasterID uniqueidentifier,  
 BodyID uniqueidentifier,  
 POMTempItemID uniqueidentifier,  
 POMLibraryID uniqueidentifier,  
 POMTempID uniqueidentifier,  
 BodySet int,  
 Critical int,  
 POM nvarchar (10),  
 PointMeasur nvarchar (225),  
 TOL numeric(18, 4) NOT NULL ,  
 TOLN numeric(18, 4) NOT NULL ,  
 Spec decimal(18, 4) NOT NULL ,  
 Proto0 numeric(18, 4) NOT NULL ,  
 Proto1 numeric(18, 4) NOT NULL ,  
 Proto2 numeric(18, 4) NOT NULL ,  
 Proto3 numeric(18, 4) NOT NULL ,  
 Proto4 numeric(18, 4) NOT NULL ,  
 Proto5 numeric(18, 4) NOT NULL ,  
 Proto6 numeric(18, 4) NOT NULL ,  
 Proto7 numeric(18, 4) NOT NULL ,  
 Proto8 numeric(18, 4) NOT NULL ,  
 Proto9 numeric(18, 4) NOT NULL ,  
 Proto10 numeric(18, 0) NOT NULL ,  
 Proto11 numeric(18, 0) NOT NULL ,  
 Proto12 numeric(18, 4) NOT NULL ,  
 Proto13 numeric(18, 4) NOT NULL ,  
 Proto14 numeric(18, 4) NOT NULL ,  
 Proto15 numeric(18, 4) NOT NULL ,  
 Proto16 numeric(18, 4) NOT NULL ,  
 Proto17 numeric(18, 4) NOT NULL ,  
 Proto18 numeric(18, 4) NOT NULL ,  
 Proto19 numeric(18, 4) NOT NULL ,  
 Grade0 numeric(18, 4) NOT NULL ,  
 Grade1 numeric(18, 4) NOT NULL ,  
 Grade2 numeric(18, 4) NOT NULL ,  
 Grade3 numeric(18, 4) NOT NULL ,  
 Grade4 numeric(18, 4) NOT NULL ,  
 Grade5 numeric(18, 4) NOT NULL ,  
 Grade6 numeric(18, 4) NOT NULL ,  
 Grade7 numeric(18, 4) NOT NULL ,  
 Grade8 numeric(18, 4) NOT NULL ,  
 Grade9 numeric(18, 4) NOT NULL ,  
 Grade10 numeric(18, 4) NOT NULL ,  
 Grade11 numeric(18, 4) NOT NULL ,  
 Grade12 numeric(18, 4) NOT NULL ,  
 Grade13 numeric(18, 4) NOT NULL ,  
 Grade14 numeric(18, 4) NOT NULL ,  
 Grade15 numeric(18, 4) NOT NULL ,  
 Grade16 numeric(18, 4) NOT NULL ,  
 Grade17 numeric(18, 4) NOT NULL ,  
 Grade18 numeric(18, 4) NOT NULL ,  
 Grade19 numeric(18, 4) NOT NULL ,  
 Size0 numeric(18, 4) NOT NULL ,  
 Size1 numeric(18, 4) NOT NULL ,  
 Size2 numeric(18, 4) NOT NULL ,  
 Size3 numeric(18, 4) NOT NULL ,  
 Size4 numeric(18, 4) NOT NULL ,  
 Size5 numeric(18, 4) NOT NULL ,  
 Size6 numeric(18, 4) NOT NULL ,  
 Size7 numeric(18, 4) NOT NULL ,  
 Size8 numeric(18, 4) NOT NULL ,  
 Size9 numeric(18, 4) NOT NULL ,  
 Size10 numeric(18, 4) NOT NULL ,  
 Size11 numeric(18, 4) NOT NULL ,  
 Size12 numeric(18, 4) NOT NULL ,  
 Size13 numeric(18, 4) NOT NULL ,  
 Size14 numeric(18, 4) NOT NULL ,  
 Size15 numeric(18, 4) NOT NULL ,  
 Size16 numeric(18, 4) NOT NULL ,  
 Size17 numeric(18, 4) NOT NULL ,  
 Size18 numeric(18, 4) NOT NULL ,  
 Size19 numeric(18, 4) NOT NULL ,  
 CDate datetime,  
 CUser nvarchar (200),  
 MDate datetime,  
 MUser nvarchar (200),  
 Change int,  
 Sort nvarchar (5),  
 HowToMeasurText nvarchar (4000),  
 HowToMeasurImage nvarchar (100)    
)   
END  
  
BEGIN  
CREATE TABLE #tempBodySpec3 (  
 RecID int IDENTITY(1,1)  NOT NULL,  
 SpecID  uniqueidentifier,  
 SpecMasterID uniqueidentifier,  
 BodyID uniqueidentifier,  
 POMTempItemID uniqueidentifier,  
 POMLibraryID uniqueidentifier,  
 POMTempID uniqueidentifier,  
 BodySet int,  
 Critical int,  
 POM nvarchar (10),  
 PointMeasur nvarchar (225),  
 TOL numeric(18, 4) NOT NULL ,  
 TOLN numeric(18, 4) NOT NULL ,  
 Spec decimal(18, 4) NOT NULL ,  
 Proto0 numeric(18, 4) NOT NULL ,  
 Proto1 numeric(18, 4) NOT NULL ,  
 Proto2 numeric(18, 4) NOT NULL ,  
 Proto3 numeric(18, 4) NOT NULL ,  
 Proto4 numeric(18, 4) NOT NULL ,  
 Proto5 numeric(18, 4) NOT NULL ,  
 Proto6 numeric(18, 4) NOT NULL ,  
 Proto7 numeric(18, 4) NOT NULL ,  
 Proto8 numeric(18, 4) NOT NULL ,  
 Proto9 numeric(18, 4) NOT NULL ,  
 Proto10 numeric(18, 0) NOT NULL ,  
 Proto11 numeric(18, 0) NOT NULL ,  
 Proto12 numeric(18, 4) NOT NULL ,  
 Proto13 numeric(18, 4) NOT NULL ,  
 Proto14 numeric(18, 4) NOT NULL ,  
 Proto15 numeric(18, 4) NOT NULL ,  
 Proto16 numeric(18, 4) NOT NULL ,  
 Proto17 numeric(18, 4) NOT NULL ,  
 Proto18 numeric(18, 4) NOT NULL ,  
 Proto19 numeric(18, 4) NOT NULL ,  
 Grade0 numeric(18, 4) NOT NULL ,  
 Grade1 numeric(18, 4) NOT NULL ,  
 Grade2 numeric(18, 4) NOT NULL ,  
 Grade3 numeric(18, 4) NOT NULL ,  
 Grade4 numeric(18, 4) NOT NULL ,  
 Grade5 numeric(18, 4) NOT NULL ,  
 Grade6 numeric(18, 4) NOT NULL ,  
 Grade7 numeric(18, 4) NOT NULL ,  
 Grade8 numeric(18, 4) NOT NULL ,  
 Grade9 numeric(18, 4) NOT NULL ,  
 Grade10 numeric(18, 4) NOT NULL ,  
 Grade11 numeric(18, 4) NOT NULL ,  
 Grade12 numeric(18, 4) NOT NULL ,  
 Grade13 numeric(18, 4) NOT NULL ,   Grade14 numeric(18, 4) NOT NULL ,  
 Grade15 numeric(18, 4) NOT NULL ,  
 Grade16 numeric(18, 4) NOT NULL ,  
 Grade17 numeric(18, 4) NOT NULL ,  
 Grade18 numeric(18, 4) NOT NULL ,  
 Grade19 numeric(18, 4) NOT NULL ,  
 Size0 numeric(18, 4) NOT NULL ,  
 Size1 numeric(18, 4) NOT NULL ,  
 Size2 numeric(18, 4) NOT NULL ,  
 Size3 numeric(18, 4) NOT NULL ,  
 Size4 numeric(18, 4) NOT NULL ,  
 Size5 numeric(18, 4) NOT NULL ,  
 Size6 numeric(18, 4) NOT NULL ,  
 Size7 numeric(18, 4) NOT NULL ,  
 Size8 numeric(18, 4) NOT NULL ,  
 Size9 numeric(18, 4) NOT NULL ,  
 Size10 numeric(18, 4) NOT NULL ,  
 Size11 numeric(18, 4) NOT NULL ,  
 Size12 numeric(18, 4) NOT NULL ,  
 Size13 numeric(18, 4) NOT NULL ,  
 Size14 numeric(18, 4) NOT NULL ,  
 Size15 numeric(18, 4) NOT NULL ,  
 Size16 numeric(18, 4) NOT NULL ,  
 Size17 numeric(18, 4) NOT NULL ,  
 Size18 numeric(18, 4) NOT NULL ,  
 Size19 numeric(18, 4) NOT NULL ,  
 CDate datetime,  
 CUser nvarchar (200),  
 MDate datetime,  
 MUser nvarchar (200),  
 Change int,  
 Sort nvarchar (5),  
 HowToMeasurText nvarchar (4000),  
 HowToMeasurImage nvarchar (100)    
)   
END  
  
BEGIN  
CREATE TABLE #tempBodySpec4 (  
 RecID int IDENTITY(1,1)  NOT NULL,  
 SpecID  uniqueidentifier,  
 SpecMasterID uniqueidentifier,  
 BodyID uniqueidentifier,  
 POMTempItemID uniqueidentifier,  
 POMLibraryID uniqueidentifier,  
 POMTempID uniqueidentifier,  
 BodySet int,  
 Critical int,  
 POM nvarchar (10),  
 PointMeasur nvarchar (225),  
 TOL numeric(18, 4) NOT NULL ,  
 TOLN numeric(18, 4) NOT NULL ,  
 Spec decimal(18, 4) NOT NULL ,  
 Proto0 numeric(18, 4) NOT NULL ,  
 Proto1 numeric(18, 4) NOT NULL ,  
 Proto2 numeric(18, 4) NOT NULL ,  
 Proto3 numeric(18, 4) NOT NULL ,  
 Proto4 numeric(18, 4) NOT NULL ,  
 Proto5 numeric(18, 4) NOT NULL ,  
 Proto6 numeric(18, 4) NOT NULL ,  
 Proto7 numeric(18, 4) NOT NULL ,  
 Proto8 numeric(18, 4) NOT NULL ,  
 Proto9 numeric(18, 4) NOT NULL ,  
 Proto10 numeric(18, 0) NOT NULL ,  
 Proto11 numeric(18, 0) NOT NULL ,  
 Proto12 numeric(18, 4) NOT NULL ,  
 Proto13 numeric(18, 4) NOT NULL ,  
 Proto14 numeric(18, 4) NOT NULL ,  
 Proto15 numeric(18, 4) NOT NULL ,  
 Proto16 numeric(18, 4) NOT NULL ,  
 Proto17 numeric(18, 4) NOT NULL ,  
 Proto18 numeric(18, 4) NOT NULL ,  
 Proto19 numeric(18, 4) NOT NULL ,  
 Grade0 numeric(18, 4) NOT NULL ,  
 Grade1 numeric(18, 4) NOT NULL ,  
 Grade2 numeric(18, 4) NOT NULL ,  
 Grade3 numeric(18, 4) NOT NULL ,  
 Grade4 numeric(18, 4) NOT NULL ,  
 Grade5 numeric(18, 4) NOT NULL ,  
 Grade6 numeric(18, 4) NOT NULL ,  
 Grade7 numeric(18, 4) NOT NULL ,  
 Grade8 numeric(18, 4) NOT NULL ,  
 Grade9 numeric(18, 4) NOT NULL ,  
 Grade10 numeric(18, 4) NOT NULL ,  
 Grade11 numeric(18, 4) NOT NULL ,  
 Grade12 numeric(18, 4) NOT NULL ,  
 Grade13 numeric(18, 4) NOT NULL ,  
 Grade14 numeric(18, 4) NOT NULL ,  
 Grade15 numeric(18, 4) NOT NULL ,  
 Grade16 numeric(18, 4) NOT NULL ,  
 Grade17 numeric(18, 4) NOT NULL ,  
 Grade18 numeric(18, 4) NOT NULL ,  
 Grade19 numeric(18, 4) NOT NULL ,  
 Size0 numeric(18, 4) NOT NULL ,  
 Size1 numeric(18, 4) NOT NULL ,  
 Size2 numeric(18, 4) NOT NULL ,  
 Size3 numeric(18, 4) NOT NULL ,  
 Size4 numeric(18, 4) NOT NULL ,  
 Size5 numeric(18, 4) NOT NULL ,  
 Size6 numeric(18, 4) NOT NULL ,  
 Size7 numeric(18, 4) NOT NULL ,  
 Size8 numeric(18, 4) NOT NULL ,  
 Size9 numeric(18, 4) NOT NULL ,  
 Size10 numeric(18, 4) NOT NULL ,  
 Size11 numeric(18, 4) NOT NULL ,  
 Size12 numeric(18, 4) NOT NULL ,  
 Size13 numeric(18, 4) NOT NULL ,  
 Size14 numeric(18, 4) NOT NULL ,  
 Size15 numeric(18, 4) NOT NULL ,  
 Size16 numeric(18, 4) NOT NULL ,  
 Size17 numeric(18, 4) NOT NULL ,  
 Size18 numeric(18, 4) NOT NULL ,  
 Size19 numeric(18, 4) NOT NULL ,  
 CDate datetime,  
 CUser nvarchar (200),  
 MDate datetime,  
 MUser nvarchar (200),  
 Change int,  
 Sort nvarchar (5),  
 HowToMeasurText nvarchar (4000),  
 HowToMeasurImage nvarchar (100)    
)   
END  
  
BEGIN  
 INSERT INTO #tempBodySpec1  
  (SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1,   
  Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17,   
  Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14,   
  Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13,   
  Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)  
 SELECT  NEWID() AS SpecID, @NewBodyID AS BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur,   
  TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14,   
  Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,  
  Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17,   
  Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12,   
  0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort  
 FROM  pBodySpec WITH (NOLOCK)  
 WHERE (BodyID = @BodyID) AND (BodySet = 1)  
END  
  
BEGIN  
 INSERT INTO pBodySpec  
  (SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1,   
  Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17,   
  Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14,   
  Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13,   
  Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)  
 SELECT  NEWID() AS SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur,   
  TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14,   
  Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,  
  Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17,   
  Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12,   
  0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort  
 FROM  #tempBodySpec1  
 WHERE (BodyID = @NewBodyID) AND (BodySet = 1)  
END  
  
BEGIN  
 INSERT INTO #tempBodySpec2  
  (SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1,   
  Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17,   
  Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14,   
  Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13,   
  Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)  
 SELECT  NEWID() AS SpecID, @NewBodyID AS BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur,   
  TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14,   
  Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,  
  Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17,   
  Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12,   
  0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort  
 FROM  pBodySpec WITH (NOLOCK)  
 WHERE (BodyID = @BodyID) AND (BodySet = 2)  
END  
  
BEGIN  
 INSERT INTO pBodySpec  
  (SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1,   
  Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17,   
  Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14,   
  Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13,   
  Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)  
 SELECT  NEWID() AS SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur,   
  TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14,   
  Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,  
  Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17,   
  Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12,   
  0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort  
 FROM  #tempBodySpec2  
 WHERE (BodyID = @NewBodyID) AND (BodySet = 2)  
END  
  
BEGIN  
 INSERT INTO #tempBodySpec3  
  (SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1,   
  Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17,   
  Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14,   
  Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13,   
  Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)  
 SELECT  NEWID() AS SpecID, @NewBodyID AS BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur,   
  TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14,   
  Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,  
  Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17,   
  Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12,   
  0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort  
 FROM  pBodySpec WITH (NOLOCK)  
 WHERE (BodyID = @BodyID) AND (BodySet = 3)  
END  
  
BEGIN  
 INSERT INTO pBodySpec  
  (SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1,   
  Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17,   
  Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14,   
  Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13,   
  Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)  
 SELECT  NEWID() AS SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur,   
  TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14,   
  Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,  
  Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17,   
  Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12,   
  0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort  
 FROM  #tempBodySpec3  
 WHERE (BodyID = @NewBodyID) AND (BodySet = 3)  
END  
  
BEGIN  
 INSERT INTO #tempBodySpec4  
  (SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1,   
  Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17,   
  Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14,   
  Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13,   
  Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)  
 SELECT  NEWID() AS SpecID, @NewBodyID AS BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur,   
  TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14,   
  Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,  
  Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17,   
  Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12,   
  0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort  
 FROM  pBodySpec WITH (NOLOCK)  
 WHERE (BodyID = @BodyID) AND (BodySet = 4)  
END  
  
  
BEGIN  
 INSERT INTO pBodySpec  
  (SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1,   
  Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17,   
  Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14,   
  Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13,   
  Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)  
 SELECT  NEWID() AS SpecID, BodyID, BodySet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur,   
  TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14,   
  Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,  
  Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17,   
  Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12,   
  0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort  
 FROM  #tempBodySpec4  
 WHERE (BodyID = @NewBodyID) AND (BodySet = 4)  
END  
  
/****************************************************************************************************/  
/*This was added because when you copied a Style, the pStyleSpecSize table was not being populated. */  
/*Calling this procedure here will populate this table so that reports can retrieve accurate data. */  
/*Added: 4/3/08                      */   
/****************************************************************************************************/  
EXEC spx_BodySpecSize_SELECT @NewBodyID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09514', GetDate())
GO
