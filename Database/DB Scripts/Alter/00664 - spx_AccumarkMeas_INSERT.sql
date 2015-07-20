/****** Object:  StoredProcedure [dbo].[spx_AccumarkMeas_INSERT]    Script Date: 11/08/2010 08:44:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_AccumarkMeas_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_AccumarkMeas_INSERT
GO

CREATE PROCEDURE spx_AccumarkMeas_INSERT
	(
		@AMLMeasHdrId uniqueidentifier,
		@ModelName nvarchar(50),
		@POMDescription nvarchar(100),
		@POMRow int,
		@SizeCol int,
		@SizeDesc nvarchar(50),
        @Grade numeric(18,4),
		@IsMetric int,
        @CUser nvarchar(50),
        @CDate datetime,
        @MUser nvarchar(50),
        @MDate datetime
	)
AS
INSERT INTO pAccumarkMeasurement
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
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '664', GetDate())
GO
