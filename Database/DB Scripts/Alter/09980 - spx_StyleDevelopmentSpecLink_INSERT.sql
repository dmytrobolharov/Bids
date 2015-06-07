IF OBJECT_ID(N'[dbo].[spx_StyleDevelopmentSpecLink_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleDevelopmentSpecLink_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleDevelopmentSpecLink_INSERT]
(
@StyleID uniqueidentifier,
@NewStyleID nvarchar(50),
@SizeClassId uniqueidentifier,
@SizeRangeId uniqueidentifier,
@CreatedBy nvarchar(50),
@CreatedDate nvarchar(50)
)
AS

SET NOCOUNT ON
--SET ANSI_WARNINGS OFF

DECLARE @POMTempItemID	varchar(50)
DECLARE @POMTempID	varchar(50)
DECLARE @Row_Count int
DECLARE @Row_Loop int
DECLARE	@Size0 nvarchar (7),
@Size1 nvarchar (7), @Size2 nvarchar (7), @Size3 nvarchar (7),@Size4 nvarchar (7),
@Size5 nvarchar (7), @Size6 nvarchar (7), @Size7 nvarchar (7),@Size8 nvarchar (7), 
@Size9 nvarchar (7), @Size10 nvarchar (7), @Size11 nvarchar (7), @Size12 nvarchar (7),
@Size13 nvarchar (7), @Size14 nvarchar (7), @Size15 nvarchar (7), @Size16 nvarchar (7),
@Size17 nvarchar (7), @Size18 nvarchar (7), @Size19 nvarchar (7)

-- *****************************************************************************************
-- Temporary tables
-- *****************************************************************************************
--if exists (select * from sysobjects where id = object_id(N'#tempStyleSpec') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
--drop table #tempStyleSpec


--if not exists (select * from sysobjects where id = object_id(N'#tempStyleSpec') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE #tempStyleSpec1 (
	RecID int IDENTITY(1,1)  NOT NULL,
	SpecID  uniqueidentifier,
	SpecMasterID uniqueidentifier,
	StyleID uniqueidentifier,
	POMTempItemID uniqueidentifier,
	POMLibraryID uniqueidentifier,
	POMTempID uniqueidentifier,
	StyleSet int,
	Critical int,
	POM nvarchar (10),
	PointMeasur nvarchar (225),
	TOL numeric(18, 4) NOT NULL ,
	TOLN numeric(18, 4) NOT NULL ,
	Spec decimal(18, 4) NOT NULL ,
	Conv decimal(18, 4) NOT NULL ,
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
	Proto10 numeric(18, 4) NOT NULL ,
	Proto11 numeric(18, 4) NOT NULL ,
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
CREATE TABLE #tempStyleSpec2 (
	RecID int IDENTITY(1,1)  NOT NULL,
	SpecID  uniqueidentifier,
	SpecMasterID uniqueidentifier,
	StyleID uniqueidentifier,
	POMTempItemID uniqueidentifier,
	POMLibraryID uniqueidentifier,
	POMTempID uniqueidentifier,
	StyleSet int,
	Critical int,
	POM nvarchar (10),
	PointMeasur nvarchar (225),
	TOL numeric(18, 4) NOT NULL ,
	TOLN numeric(18, 4) NOT NULL ,
	Spec decimal(18, 4) NOT NULL ,
	Conv decimal(18, 4) NOT NULL ,
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
	Proto10 numeric(18, 4) NOT NULL ,
	Proto11 numeric(18, 4) NOT NULL ,
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
CREATE TABLE #tempStyleSpec3 (
	RecID int IDENTITY(1,1)  NOT NULL,
	SpecID  uniqueidentifier,
	SpecMasterID uniqueidentifier,
	StyleID uniqueidentifier,
	POMTempItemID uniqueidentifier,
	POMLibraryID uniqueidentifier,
	POMTempID uniqueidentifier,
	StyleSet int,
	Critical int,
	POM nvarchar (10),
	PointMeasur nvarchar (225),
	TOL numeric(18, 4) NOT NULL ,
	TOLN numeric(18, 4) NOT NULL ,
	Spec decimal(18, 4) NOT NULL ,
	Conv decimal(18, 4) NOT NULL ,
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
	Proto10 numeric(18, 4) NOT NULL ,
	Proto11 numeric(18, 4) NOT NULL ,
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
CREATE TABLE #tempStyleSpec4 (
	RecID int IDENTITY(1,1)  NOT NULL,
	SpecID  uniqueidentifier,
	SpecMasterID uniqueidentifier,
	StyleID uniqueidentifier,
	POMTempItemID uniqueidentifier,
	POMLibraryID uniqueidentifier,
	POMTempID uniqueidentifier,
	StyleSet int,
	Critical int,
	POM nvarchar (10),
	PointMeasur nvarchar (225),
	TOL numeric(18, 4) NOT NULL ,
	TOLN numeric(18, 4) NOT NULL ,
	Spec decimal(18, 4) NOT NULL ,
	Conv decimal(18, 4) NOT NULL ,
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
	Proto10 numeric(18, 4) NOT NULL ,
	Proto11 numeric(18, 4) NOT NULL ,
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
	INSERT INTO #tempStyleSpec1
		(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
		Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
		Grade18, Grade19, Spec, Conv, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, 
		Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
		Size14, Size15, Size16, Size17, Size18, Size19, Change, CDate, CUser, MDate, MUser, Sort)
	SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, 
		TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, 
		Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, 0 AS Conv, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,
		Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17, 
		Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12, 
		0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, Change, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, 
		Sort
	FROM pStyleSpec WITH (NOLOCK)
	WHERE (StyleID = @StyleID) AND (StyleSet = 1)
	ORDER BY Sort
END

BEGIN
	INSERT INTO #tempStyleSpec2
		(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
		Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
		Grade18, Grade19, Spec, Conv, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, 
		Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
		Size14, Size15, Size16, Size17, Size18, Size19, Change, CDate, CUser, MDate, MUser, Sort)
	SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, 
		TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, 
		Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, 0 AS Conv, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,
		Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17, 
		Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12, 
		0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, Change, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, 
		Sort
	FROM pStyleSpec WITH (NOLOCK)
	WHERE (StyleID = @StyleID) AND (StyleSet = 2)
	ORDER BY Sort
END

BEGIN
	INSERT INTO #tempStyleSpec3
		(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
		Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
		Grade18, Grade19, Spec, Conv, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, 
		Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
		Size14, Size15, Size16, Size17, Size18, Size19, Change, CDate, CUser, MDate, MUser, Sort)
	SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, 
		TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, 
		Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, 0 AS Conv, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,
		Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17, 
		Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12, 
		0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, Change, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, 
		Sort
	FROM pStyleSpec WITH (NOLOCK)
	WHERE (StyleID = @StyleID) AND (StyleSet = 3)
	ORDER BY Sort
END

BEGIN
	INSERT INTO #tempStyleSpec4
		(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
		Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
		Grade18, Grade19, Spec, Conv, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, 
		Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
		Size14, Size15, Size16, Size17, Size18, Size19, Change, CDate, CUser, MDate, MUser, Sort)
	SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, 
		TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, 
		Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, 0 AS Conv, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,
		Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17, 
		Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12, 
		0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, Change, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, 
		Sort
	FROM pStyleSpec WITH (NOLOCK)
	WHERE (StyleID = @StyleID) AND (StyleSet = 4)
	ORDER BY Sort
END

DECLARE @POMTempGroupID nvarchar(50)
DECLARE @StyleSpecID uniqueidentifier
DECLARE @StyleSpecMasterID uniqueidentifier
DECLARE @NewStyleSpecMasterID uniqueidentifier
DECLARE @POM nvarchar(10)
DECLARE @PointMeasur nvarchar(225)
DECLARE @TOL numeric(18, 4), @TOLN numeric(18, 4), @Spec decimal(18, 4),
@Grade0 numeric(18, 4), @Grade1 numeric(18, 4), @Grade2 numeric(18, 4),
@Grade3 numeric(18, 4), @Grade4 numeric(18, 4), @Grade5 numeric(18, 4),
@Grade6 numeric(18, 4), @Grade7 numeric(18, 4), @Grade8 numeric(18, 4),
@Grade9 numeric(18, 4), @Grade10 numeric(18, 4), @Grade11 numeric(18, 4),
@Grade12 numeric(18, 4), @Grade13 numeric(18, 4), @Grade14 numeric(18, 4),
@Grade15 numeric(18, 4), @Grade16 numeric(18, 4), @Grade17 numeric(18, 4),
@Grade18 numeric(18, 4), @Grade19 numeric(18, 4), @Conv numeric(18, 4)


BEGIN

SELECT @POMTempID = POMTempID FROM pStyleSpec WHERE (StyleID = @StyleID) AND
(StyleSet = 1) AND (POMTempID IS NOT NULL)
SELECT @POMTempGroupID = POMTempGroupID FROM pPOMTemplate WHERE POMTempID = @POMTempID 
SELECT @POMTempID = POMTempID, @Size0 = Size0, @Size1 = Size1, @Size2 = Size2,
@Size3 = Size3, @Size4 = Size4, @Size5 = Size5, @Size6 = Size6, @Size7 = Size7, @Size8 = Size8,
@Size9 = Size9, @Size10 = Size10, @Size11 = Size11, @Size12 = Size12, @Size13 = Size13, @Size14 = Size14, 
@Size15 = Size15, @Size16 = Size16, @Size17 = Size17, @Size18 = Size18, @Size19 = Size19
FROM pPOMTemplate WITH (NOLOCK) 
WHERE POMTempGroupID = @POMTempGroupID AND SizeRangeId = @SizeRangeId AND SizeClassId = @SizeClassId

--INSERT pStyleSpecSize

SELECT * FROM pPOMTemplate WITH (NOLOCK) 
WHERE POMTempGroupID = @POMTempGroupID AND SizeRangeId = @SizeRangeId AND SizeClassId = @SizeClassId

SELECT * FROM #tempStyleSpec1

SET @Row_Loop = 1
SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleSpec1)

IF @Row_Count <> 0
	BEGIN
	WHILE @Row_Loop <= @Row_Count 
		BEGIN
		
			SELECT @StyleSpecMasterID = SpecMasterID, @StyleSpecID = SpecID, 
			 @POM = POM, @PointMeasur = PointMeasur 
			FROM #tempStyleSpec1 WHERE RecID = @Row_Loop
			
			IF @StyleSpecMasterID IS NULL
			BEGIN
				SET @NewStyleSpecMasterID = newid()
				UPDATE pStyleSpec SET SpecMasterID = @NewStyleSpecMasterID WHERE SpecID = @StyleSpecID
				SET @StyleSpecMasterID = @NewStyleSpecMasterID
			END	
		
			/*Check to see if there is a matching POM in the template before updating AND if the original size class' POM was still linked.*/
			IF (((SELECT COUNT(*) FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempID = @POMTempID) = 1) AND
				((SELECT POMTempID FROM #tempStyleSpec1 WHERE RecID = @Row_Loop) IS NOT NULL))
				BEGIN
					SELECT @POMTempItemID = POMTempItemID, @TOL = TOL, @TOLN = TOLN, @Spec = Spec, @Conv = Conv, 
					@Grade0 = Grade0, @Grade1 = Grade1, @Grade2 = Grade2, @Grade3 = Grade3, @Grade4 = Grade4, 
					@Grade5 = Grade5, @Grade6 = Grade6, @Grade7 = Grade7, @Grade8 = Grade8, @Grade9 = Grade9, 
					@Grade10 = Grade10, @Grade11 = Grade11, @Grade12 = Grade12, @Grade13 = Grade13, @Grade14 = Grade14,
					@Grade15 = Grade15, @Grade16 = Grade16, @Grade17 = Grade17, @Grade18 = Grade18, @Grade19 = Grade19 
					--FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempGroupID = @POMTempGroupID AND  POMTempID = @POMTempID 
					FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempID = @POMTempID 
				
					UPDATE  #tempStyleSpec1 SET 
					SpecMasterID = @StyleSpecMasterID, POMTempItemID = @POMTempItemID, TOL = @TOL, TOLN = @TOLN, Spec = @Spec, Conv = @Conv, 
					Grade0 = @Grade0, Grade1 = @Grade1, Grade2 = @Grade2, Grade3 = @Grade3, Grade4 = @Grade4, 
					Grade5 = @Grade5, Grade6 = @Grade6, Grade7 = @Grade7, Grade8 = @Grade8, Grade9 = @Grade9, 
					Grade10 = @Grade10, Grade11 = @Grade11, Grade12 = @Grade12, Grade13 = @Grade13, Grade14 = @Grade14,
					Grade15 = @Grade15, Grade16 = @Grade16, Grade17 = @Grade17, Grade18 = @Grade18, Grade19 = @Grade19, POMTempID = @POMTempID
					WHERE RecID = @Row_Loop
				END
			/*Else set the unlinked POM's spec value, grades, etc. to zeros.*/
			ELSE
				BEGIN
					UPDATE  #tempStyleSpec1 SET 
					Spec = 0, Conv = 0, Grade0 = 0, Grade1 = 0, Grade2 = 0, Grade3 = 0, Grade4 = 0,	Grade5 = 0, Grade6 = 0, Grade7 = 0,
					Grade8 = 0, Grade9 = 0,	Grade10 = 0, Grade11 = 0, Grade12 = 0, Grade13 = 0, Grade14 = 0, Grade15 = 0, Grade16 = 0,
					Grade17 = 0, Grade18 = 0, Grade19 = 0, Proto0 = 0, Proto1 = 0, Proto2 = 0, Proto3 = 0, Proto4 = 0, Proto5 = 0,
					Proto6 = 0, Proto7 = 0, Proto8 = 0, Proto9 = 0, Proto10 = 0, Proto11 = 0, Proto12 = 0, Proto13 = 0, Proto14 = 0,
					Proto15 = 0, Proto16 = 0, Proto17 = 0, Proto18 = 0, Proto19 = 0, Size0 = 0, Size1 = 0, Size2 = 0, Size3 = 0, Size4 = 0,
					Size5 = 0, Size6 = 0, Size7 = 0, Size8 = 0, Size9 = 0, Size10 = 0, Size11 = 0, Size12 = 0, Size13 = 0, Size14 = 0,
					Size15 = 0, Size16 = 0, Size17 = 0, Size18 = 0, Size19 = 0
					WHERE RecID = @Row_Loop
				END

			--SELECT * FROM #tempStyleSpec1 WHERE RecID = @Row_Loop

			SET @Row_Loop = @Row_Loop + 1
		END
		
		UPDATE pStyleHeader 
		SET POMTempID1 = @POMTempID, 
		    SizeClassId = @SizeClassId, 
			SizeRangeId = @SizeRangeId 
		WHERE StyleID = @NewStyleID

		INSERT INTO pStyleSpec
			(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
			Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
			Grade18, Grade19, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, 
			Proto16, Proto17, Proto18, Proto19, Spec, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
			Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort, Conv)
		SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, 
			PointMeasur, TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, 
			Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Proto0, Spec AS Proto1, Spec AS Proto2, Spec AS Proto3, Spec AS Proto4, 
			Spec AS Proto5, Spec AS Proto6, Spec AS Proto7, Spec AS Proto8, Spec AS Proto9, Spec AS Proto10, Spec AS Proto11, Spec AS Proto12, 
			Spec AS Proto13, Spec AS Proto19, Spec AS Proto18, Spec AS Proto17, Spec AS Proto16, Spec AS Proto15, Spec AS Proto14, Spec AS Spec, 0 AS Size0, 
			0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11, 0 AS Size12, 
			0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 0 AS Size17, 0 AS Size18, 0 AS Size19, CDate, CUser, @CreatedDate AS MUser, 
			@CreatedBy AS MDate, Change, Sort, Conv
		FROM  #tempStyleSpec1		
	END	
END


BEGIN

SELECT @POMTempID = POMTempID FROM pStyleSpec WHERE (StyleID = @StyleID) AND StyleSet = 2
SELECT @POMTempGroupID = POMTempGroupID FROM pPOMTemplate WHERE POMTempID = @POMTempID 
SELECT @POMTempID = POMTempID, @Size0 = Size0, @Size1 = Size1, @Size2 = Size2,
@Size3 = Size3, @Size4 = Size4, @Size5 = Size5, @Size6 = Size6, @Size7 = Size7, @Size8 = Size8,
@Size9 = Size9, @Size10 = Size10, @Size11 = Size11, @Size12 = Size12, @Size13 = Size13, @Size14 = Size14, 
@Size15 = Size15, @Size16 = Size16, @Size17 = Size17, @Size18 = Size18, @Size19 = Size19
FROM pPOMTemplate WITH (NOLOCK) 
WHERE POMTempGroupID = @POMTempGroupID AND SizeRangeId = @SizeRangeId AND SizeClassId = @SizeClassId

--INSERT pStyleSpecSize

SET @Row_Loop = 1
SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleSpec2)

IF @Row_Count <> 0
	BEGIN
	WHILE @Row_Loop <= @Row_Count 
		BEGIN
		
			SELECT @StyleSpecMasterID = SpecMasterID, @StyleSpecID = SpecID, 
			 @POM = POM, @PointMeasur = PointMeasur 
			FROM #tempStyleSpec2 WHERE RecID = @Row_Loop
			
			IF @StyleSpecMasterID IS NULL
			BEGIN
				SET @NewStyleSpecMasterID = newid()
				UPDATE pStyleSpec SET SpecMasterID = @NewStyleSpecMasterID WHERE SpecID = @StyleSpecID
				SET @StyleSpecMasterID = @NewStyleSpecMasterID
			END	
		
			/*Check to see if there is a matching POM in the template before updating AND if the original size class' POM was still linked.*/
			IF (((SELECT COUNT(*) FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempID = @POMTempID) = 1) AND
				((SELECT POMTempID FROM #tempStyleSpec2 WHERE RecID = @Row_Loop) IS NOT NULL))
				BEGIN
					SELECT @POMTempItemID = POMTempItemID, @TOL = TOL, @TOLN = TOLN, @Spec = Spec,  @Conv = Conv, 
					@Grade0 = Grade0, @Grade1 = Grade1, @Grade2 = Grade2, @Grade3 = Grade3, @Grade4 = Grade4, 
					@Grade5 = Grade5, @Grade6 = Grade6, @Grade7 = Grade7, @Grade8 = Grade8, @Grade9 = Grade9, 
					@Grade10 = Grade10, @Grade11 = Grade11, @Grade12 = Grade12, @Grade13 = Grade13, @Grade14 = Grade14,
					@Grade15 = Grade15, @Grade16 = Grade16, @Grade17 = Grade17, @Grade18 = Grade18, @Grade19 = Grade19 
					--FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempGroupID = @POMTempGroupID AND  POMTempID = @POMTempID 
					FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempID = @POMTempID 
				
					UPDATE  #tempStyleSpec2 SET 
					SpecMasterID = @StyleSpecMasterID, POMTempItemID = @POMTempItemID, TOL = @TOL, TOLN = @TOLN, Spec = @Spec, Conv = @Conv, 
					Grade0 = @Grade0, Grade1 = @Grade1, Grade2 = @Grade2, Grade3 = @Grade3, Grade4 = @Grade4, 
					Grade5 = @Grade5, Grade6 = @Grade6, Grade7 = @Grade7, Grade8 = @Grade8, Grade9 = @Grade9, 
					Grade10 = @Grade10, Grade11 = @Grade11, Grade12 = @Grade12, Grade13 = @Grade13, Grade14 = @Grade14,
					Grade15 = @Grade15, Grade16 = @Grade16, Grade17 = @Grade17, Grade18 = @Grade18, Grade19 = @Grade19, POMTempID = @POMTempID
					WHERE RecID = @Row_Loop
				END
			/*Else set the unlinked POM's spec value, grades, etc. to zeros.*/
			ELSE
				BEGIN
					UPDATE  #tempStyleSpec2 SET 
					Spec = 0, Conv = 0, Grade0 = 0, Grade1 = 0, Grade2 = 0, Grade3 = 0, Grade4 = 0,	Grade5 = 0, Grade6 = 0, Grade7 = 0,
					Grade8 = 0, Grade9 = 0,	Grade10 = 0, Grade11 = 0, Grade12 = 0, Grade13 = 0, Grade14 = 0, Grade15 = 0, Grade16 = 0,
					Grade17 = 0, Grade18 = 0, Grade19 = 0, Proto0 = 0, Proto1 = 0, Proto2 = 0, Proto3 = 0, Proto4 = 0, Proto5 = 0,
					Proto6 = 0, Proto7 = 0, Proto8 = 0, Proto9 = 0, Proto10 = 0, Proto11 = 0, Proto12 = 0, Proto13 = 0, Proto14 = 0,
					Proto15 = 0, Proto16 = 0, Proto17 = 0, Proto18 = 0, Proto19 = 0, Size0 = 0, Size1 = 0, Size2 = 0, Size3 = 0, Size4 = 0,
					Size5 = 0, Size6 = 0, Size7 = 0, Size8 = 0, Size9 = 0, Size10 = 0, Size11 = 0, Size12 = 0, Size13 = 0, Size14 = 0,
					Size15 = 0, Size16 = 0, Size17 = 0, Size18 = 0, Size19 = 0
					WHERE RecID = @Row_Loop
				END

			SET @Row_Loop = @Row_Loop + 1
		END
		
	UPDATE pStyleHeader 
	SET POMTempID2 = @POMTempID, 
	    SizeClassId = @SizeClassId, 
		SizerangeId = @SizeRangeId 
	WHERE StyleID = @NewStyleID

		INSERT INTO pStyleSpec
			(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
			Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
			Grade18, Grade19, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, 
			Proto16, Proto17, Proto18, Proto19, Spec, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
			Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort, Conv)
		SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, 
			PointMeasur, TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, 
			Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Proto0, Spec AS Proto1, Spec AS Proto2, Spec AS Proto3, Spec AS Proto4, 
			Spec AS Proto5, Spec AS Proto6, Spec AS Proto7, Spec AS Proto8, Spec AS Proto9, Spec AS Proto10, Spec AS Proto11, Spec AS Proto12, 
			Spec AS Proto13, Spec AS Proto19, Spec AS Proto18, Spec AS Proto17, Spec AS Proto16, Spec AS Proto15, Spec AS Proto14, Spec AS Spec, 0 AS Size0, 
			0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11, 0 AS Size12, 
			0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 0 AS Size17, 0 AS Size18, 0 AS Size19, CDate, CUser, @CreatedDate AS MUser, 
			@CreatedBy AS MDate, Change, Sort, Conv
		FROM  #tempStyleSpec2		
	END	
END


BEGIN

SELECT @POMTempID = POMTempID FROM pStyleSpec WITH (NOLOCK) WHERE (StyleID = @StyleID) AND StyleSet = 3
SELECT @POMTempGroupID = POMTempGroupID FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID 
SELECT @POMTempID = POMTempID, @Size0 = Size0, @Size1 = Size1, @Size2 = Size2,
@Size3 = Size3, @Size4 = Size4, @Size5 = Size5, @Size6 = Size6, @Size7 = Size7, @Size8 = Size8,
@Size9 = Size9, @Size10 = Size10, @Size11 = Size11, @Size12 = Size12, @Size13 = Size13, @Size14 = Size14, 
@Size15 = Size15, @Size16 = Size16, @Size17 = Size17, @Size18 = Size18, @Size19 = Size19
FROM pPOMTemplate WITH (NOLOCK) 
WHERE POMTempGroupID = @POMTempGroupID AND SizeRangeId = @SizeRangeId AND SizeClassId = @SizeClassId

--INSERT pStyleSpecSize

SET @Row_Loop = 1
SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleSpec3)

IF @Row_Count <> 0
	BEGIN
	WHILE @Row_Loop <= @Row_Count 
		BEGIN
		
			SELECT @StyleSpecMasterID = SpecMasterID, @StyleSpecID = SpecID, 
			 @POM = POM, @PointMeasur = PointMeasur 
			FROM #tempStyleSpec3 WHERE RecID = @Row_Loop
			
			IF @StyleSpecMasterID IS NULL
			BEGIN
				SET @NewStyleSpecMasterID = newid()
				UPDATE pStyleSpec SET SpecMasterID = @NewStyleSpecMasterID WHERE SpecID = @StyleSpecID
				SET @StyleSpecMasterID = @NewStyleSpecMasterID
			END	
		
			/*Check to see if there is a matching POM in the template before updating AND if the original size class' POM was still linked.*/
			IF (((SELECT COUNT(*) FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempID = @POMTempID) = 1) AND
				((SELECT POMTempID FROM #tempStyleSpec3 WHERE RecID = @Row_Loop) IS NOT NULL))
				BEGIN
					SELECT @POMTempItemID = POMTempItemID, @TOL = TOL, @TOLN = TOLN, @Spec = Spec,  @Conv = Conv,  
					@Grade0 = Grade0, @Grade1 = Grade1, @Grade2 = Grade2, @Grade3 = Grade3, @Grade4 = Grade4, 
					@Grade5 = Grade5, @Grade6 = Grade6, @Grade7 = Grade7, @Grade8 = Grade8, @Grade9 = Grade9, 
					@Grade10 = Grade10, @Grade11 = Grade11, @Grade12 = Grade12, @Grade13 = Grade13, @Grade14 = Grade14,
					@Grade15 = Grade15, @Grade16 = Grade16, @Grade17 = Grade17, @Grade18 = Grade18, @Grade19 = Grade19 
					FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempID = @POMTempID 
					--FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempGroupID = @POMTempGroupID AND  POMTempID = @POMTempID 
				
					UPDATE  #tempStyleSpec3 SET 
					SpecMasterID = @StyleSpecMasterID, POMTempItemID = @POMTempItemID, TOL = @TOL, TOLN = @TOLN, Spec = @Spec, Conv = @Conv, 
					Grade0 = @Grade0, Grade1 = @Grade1, Grade2 = @Grade2, Grade3 = @Grade3, Grade4 = @Grade4, 
					Grade5 = @Grade5, Grade6 = @Grade6, Grade7 = @Grade7, Grade8 = @Grade8, Grade9 = @Grade9, 
					Grade10 = @Grade10, Grade11 = @Grade11, Grade12 = @Grade12, Grade13 = @Grade13, Grade14 = @Grade14,
					Grade15 = @Grade15, Grade16 = @Grade16, Grade17 = @Grade17, Grade18 = @Grade18, Grade19 = @Grade19, POMTempID = @POMTempID
					WHERE RecID = @Row_Loop
				END
			/*Else set the unlinked POM's spec value, grades, etc. to zeros.*/
			ELSE
				BEGIN
					UPDATE  #tempStyleSpec3 SET 
					Spec = 0, Conv = 0, Grade0 = 0, Grade1 = 0, Grade2 = 0, Grade3 = 0, Grade4 = 0,	Grade5 = 0, Grade6 = 0, Grade7 = 0,
					Grade8 = 0, Grade9 = 0,	Grade10 = 0, Grade11 = 0, Grade12 = 0, Grade13 = 0, Grade14 = 0, Grade15 = 0, Grade16 = 0,
					Grade17 = 0, Grade18 = 0, Grade19 = 0, Proto0 = 0, Proto1 = 0, Proto2 = 0, Proto3 = 0, Proto4 = 0, Proto5 = 0,
					Proto6 = 0, Proto7 = 0, Proto8 = 0, Proto9 = 0, Proto10 = 0, Proto11 = 0, Proto12 = 0, Proto13 = 0, Proto14 = 0,
					Proto15 = 0, Proto16 = 0, Proto17 = 0, Proto18 = 0, Proto19 = 0, Size0 = 0, Size1 = 0, Size2 = 0, Size3 = 0, Size4 = 0,
					Size5 = 0, Size6 = 0, Size7 = 0, Size8 = 0, Size9 = 0, Size10 = 0, Size11 = 0, Size12 = 0, Size13 = 0, Size14 = 0,
					Size15 = 0, Size16 = 0, Size17 = 0, Size18 = 0, Size19 = 0
					WHERE RecID = @Row_Loop
				END

			SET @Row_Loop = @Row_Loop + 1
		END
		
	UPDATE pStyleHeader 
	SET POMTempID3 = @POMTempID, 
	    SizeClassId = @SizeClassId, 
		SizeRangeId = @SizeRangeId 
	WHERE StyleID = @NewStyleID

		INSERT INTO pStyleSpec
			(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
			Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
			Grade18, Grade19, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, 
			Proto16, Proto17, Proto18, Proto19, Spec, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
			Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort, Conv)
		SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, 
			PointMeasur, TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, 
			Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Proto0, Spec AS Proto1, Spec AS Proto2, Spec AS Proto3, Spec AS Proto4, 
			Spec AS Proto5, Spec AS Proto6, Spec AS Proto7, Spec AS Proto8, Spec AS Proto9, Spec AS Proto10, Spec AS Proto11, Spec AS Proto12, 
			Spec AS Proto13, Spec AS Proto19, Spec AS Proto18, Spec AS Proto17, Spec AS Proto16, Spec AS Proto15, Spec AS Proto14, Spec AS Spec, 0 AS Size0, 
			0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11, 0 AS Size12, 
			0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 0 AS Size17, 0 AS Size18, 0 AS Size19, CDate, CUser, @CreatedDate AS MUser, 
			@CreatedBy AS MDate, Change, Sort, Conv
		FROM  #tempStyleSpec3		
	END	
END


BEGIN

SELECT @POMTempID = POMTempID FROM pStyleSpec WHERE (StyleID = @StyleID) AND StyleSet = 4
SELECT @POMTempGroupID = POMTempGroupID FROM pPOMTemplate WHERE POMTempID = @POMTempID 
SELECT @POMTempID = POMTempID, @Size0 = Size0, @Size1 = Size1, @Size2 = Size2,
@Size3 = Size3, @Size4 = Size4, @Size5 = Size5, @Size6 = Size6, @Size7 = Size7, @Size8 = Size8,
@Size9 = Size9, @Size10 = Size10, @Size11 = Size11, @Size12 = Size12, @Size13 = Size13, @Size14 = Size14, 
@Size15 = Size15, @Size16 = Size16, @Size17 = Size17, @Size18 = Size18, @Size19 = Size19
FROM pPOMTemplate WITH (NOLOCK) 
WHERE POMTempGroupID = @POMTempGroupID AND SizeRangeId = @SizeRangeId AND SizeClassId = @SizeClassId

--INSERT pStyleSpecSize

SET @Row_Loop = 1
SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleSpec4)

IF @Row_Count <> 0
	BEGIN
	WHILE @Row_Loop <= @Row_Count 
		BEGIN
		
			SELECT @StyleSpecMasterID = SpecMasterID, @StyleSpecID = SpecID, 
			 @POM = POM, @PointMeasur = PointMeasur 
			FROM #tempStyleSpec4 WHERE RecID = @Row_Loop
			
			IF @StyleSpecMasterID IS NULL
			BEGIN
				SET @NewStyleSpecMasterID = newid()
				UPDATE pStyleSpec SET SpecMasterID = @NewStyleSpecMasterID WHERE SpecID = @StyleSpecID
				SET @StyleSpecMasterID = @NewStyleSpecMasterID
			END	
		
			/*Check to see if there is a matching POM in the template before updating AND if the original size class' POM was still linked.*/
			IF (((SELECT COUNT(*) FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempID = @POMTempID) = 1) AND
				((SELECT POMTempID FROM #tempStyleSpec4 WHERE RecID = @Row_Loop) IS NOT NULL))
				BEGIN
					SELECT @POMTempItemID = POMTempItemID, @TOL = TOL, @TOLN = TOLN, @Spec = Spec, @Conv = Conv,  
					@Grade0 = Grade0, @Grade1 = Grade1, @Grade2 = Grade2, @Grade3 = Grade3, @Grade4 = Grade4, 
					@Grade5 = Grade5, @Grade6 = Grade6, @Grade7 = Grade7, @Grade8 = Grade8, @Grade9 = Grade9, 
					@Grade10 = Grade10, @Grade11 = Grade11, @Grade12 = Grade12, @Grade13 = Grade13, @Grade14 = Grade14,
					@Grade15 = Grade15, @Grade16 = Grade16, @Grade17 = Grade17, @Grade18 = Grade18, @Grade19 = Grade19 
					FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempID = @POMTempID 
					--FROM pPOMTemplateItem WITH (NOLOCK) WHERE POM = @POM AND PointMeasur = @PointMeasur AND POMTempGroupID = @POMTempGroupID AND  POMTempID = @POMTempID 
				
					UPDATE  #tempStyleSpec4 SET 
					SpecMasterID = @StyleSpecMasterID, POMTempItemID = @POMTempItemID, TOL = @TOL, TOLN = @TOLN, Spec = @Spec, Conv = @Conv,  
					Grade0 = @Grade0, Grade1 = @Grade1, Grade2 = @Grade2, Grade3 = @Grade3, Grade4 = @Grade4, 
					Grade5 = @Grade5, Grade6 = @Grade6, Grade7 = @Grade7, Grade8 = @Grade8, Grade9 = @Grade9, 
					Grade10 = @Grade10, Grade11 = @Grade11, Grade12 = @Grade12, Grade13 = @Grade13, Grade14 = @Grade14,
					Grade15 = @Grade15, Grade16 = @Grade16, Grade17 = @Grade17, Grade18 = @Grade18, Grade19 = @Grade19, POMTempID = @POMTempID
					WHERE RecID = @Row_Loop
				END
			/*Else set the unlinked POM's spec value, grades, etc. to zeros.*/
			ELSE
				BEGIN
					UPDATE  #tempStyleSpec4 SET 
					Spec = 0, Conv = 0, Grade0 = 0, Grade1 = 0, Grade2 = 0, Grade3 = 0, Grade4 = 0,	Grade5 = 0, Grade6 = 0, Grade7 = 0,
					Grade8 = 0, Grade9 = 0,	Grade10 = 0, Grade11 = 0, Grade12 = 0, Grade13 = 0, Grade14 = 0, Grade15 = 0, Grade16 = 0,
					Grade17 = 0, Grade18 = 0, Grade19 = 0, Proto0 = 0, Proto1 = 0, Proto2 = 0, Proto3 = 0, Proto4 = 0, Proto5 = 0,
					Proto6 = 0, Proto7 = 0, Proto8 = 0, Proto9 = 0, Proto10 = 0, Proto11 = 0, Proto12 = 0, Proto13 = 0, Proto14 = 0,
					Proto15 = 0, Proto16 = 0, Proto17 = 0, Proto18 = 0, Proto19 = 0, Size0 = 0, Size1 = 0, Size2 = 0, Size3 = 0, Size4 = 0,
					Size5 = 0, Size6 = 0, Size7 = 0, Size8 = 0, Size9 = 0, Size10 = 0, Size11 = 0, Size12 = 0, Size13 = 0, Size14 = 0,
					Size15 = 0, Size16 = 0, Size17 = 0, Size18 = 0, Size19 = 0
					WHERE RecID = @Row_Loop
				END

			SET @Row_Loop = @Row_Loop + 1
		END
		
	UPDATE pStyleHeader 
	SET POMTempID4 = @POMTempID, 
	    SizeClassId = @SizeClassId, 
		SizeRangeId = @SizeRangeId 
	WHERE StyleID = @NewStyleID

		INSERT INTO pStyleSpec
			(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
			Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
			Grade18, Grade19, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, 
			Proto16, Proto17, Proto18, Proto19, Spec, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
			Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort, Conv)
		SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, 
			PointMeasur, TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, 
			Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Proto0, Spec AS Proto1, Spec AS Proto2, Spec AS Proto3, Spec AS Proto4, 
			Spec AS Proto5, Spec AS Proto6, Spec AS Proto7, Spec AS Proto8, Spec AS Proto9, Spec AS Proto10, Spec AS Proto11, Spec AS Proto12, 
			Spec AS Proto13, Spec AS Proto19, Spec AS Proto18, Spec AS Proto17, Spec AS Proto16, Spec AS Proto15, Spec AS Proto14, Spec AS Spec, 0 AS Size0, 
			0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11, 0 AS Size12, 
			0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 0 AS Size17, 0 AS Size18, 0 AS Size19, CDate, CUser, @CreatedDate AS MUser, 
			@CreatedBy AS MDate, Change, Sort, Conv
	FROM  #tempStyleSpec4		
	END	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09980', GetUTCDate())
GO
