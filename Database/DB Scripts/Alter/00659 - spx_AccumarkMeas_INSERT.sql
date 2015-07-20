
/****** Object:  StoredProcedure [dbo].[spx_AccumarkMeas_INSERT]    Script Date: 11/08/2010 08:44:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (select * from sysobjects where id = object_id('spx_AccumarkMeas_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_AccumarkMeas_INSERT
GO
CREATE  PROCEDURE [dbo].[spx_AccumarkMeas_INSERT]

	(
		@AMLMeasHdrId uniqueidentifier,
		@ModelName nvarchar,
		@POMDescription nvarchar,
		@POMRow int,
		@SizeCol int,
		@SizeDesc nvarchar	,
        @Grade numeric(18,4),
		@IsMetric int,
        @CUser nvarchar,
        @CDate datetime,
        @MUser nvarchar,
        @MDate datetime

	)

AS

INSERT INTO [dbo].[pAccumarkMeasurement]
           (
            [AMLMeasHdrId]
           ,[ModelName]
           ,[POMDescription]
           ,[POMRow]
           ,[SizeCol]
           ,[SizeDesc]
           ,[Grade]
           ,[IsMetric]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate])
     VALUES
           (
		@AMLMeasHdrId ,
		@ModelName,
		@POMDescription ,
		@POMRow ,
		@SizeCol ,
		@SizeDesc ,
        @Grade ,
		@IsMetric ,
        @CUser ,
        @CDate ,
        @MUser ,
        @MDate 
         )
         
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '659', GetDate())
GO