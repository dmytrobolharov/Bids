SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_PGRMeasurementsGradeTemplate_Update')
   DROP PROCEDURE spx_PGRMeasurementsGradeTemplate_Update
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_PGRMeasurementsGradeTemplate_Update](	
	@POMTempItemID uniqueidentifier
	,@POMTempID uniqueidentifier
	,@POMTempGroupID uniqueidentifier
	,@Sizecols nvarchar(4000)
	,@ModifiedBy nvarchar(200)
	,@ModifiedDate datetime
)

as

DECLARE @query NVARCHAR(max)

if @Sizecols <> ''
	begin
		 SET @query = N'Update PGRMeasurementsPOMTemplateItem set '  + @Sizecols + 
		 ' WHERE POMTempItemID = ''' + convert(nvarchar(50),@POMTempItemID) + ''' and POMTempID =
		 ''' +  convert(nvarchar(50),@POMTempID) + ''' and POMTempGroupID = ''' +  convert(nvarchar(50),@POMTempGroupID) + ''''
  
		 --select @query as igcqry
 
		 EXEC (@query) 
 
	end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02108'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02108', GetDate())
	END
GO