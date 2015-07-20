
/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_Imperial]    Script Date: 09/20/2010 08:37:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE  PROCEDURE [dbo].[spx_StyleMeas_Imperial](
@AmlMeasHdrID UNIQUEIDENTIFIER
)
AS 

--Declare @AmlMeasHdrID varchar(50)

--set @AmlMeasHdrID='ef36d356-f5dd-4a73-b00d-a108a497715c'

DECLARE @cols NVARCHAR(2000)
SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']',
                         '[' +  cast(sizecol as nvarchar(5)) + ']')
FROM    pamlmeaslbl where amlmeashdrid = @AmlMeasHdrID
ORDER BY sizecol

--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)
Declare @Metric nvarchar(2)

select @Metric=Ismetric from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId

if @Metric='0'
	begin
		SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, ' +
		@cols +'
		FROM
		(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
			  , t1.sizecol
			  , t2.Grade
		FROM    pamlmeaslbl AS t1
				JOIN pamlmeasigc AS t2 ON t1.sizecol = t2.sizecol 
				Join pamlmeaspom as t3 ON t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 
				) p
		PIVOT
		(
		MAX([Grade])
		FOR sizecol IN
		( '+
		@cols +' )
		) AS pvt
		ORDER BY sortid, refcode, description, pom_row ;'

	end
else
	begin
		SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, ' +
		@cols +'
		FROM
		(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus/(2.54)) as decimal(18,4)) as tolplus, cast((t3.tolminus/(2.54)) as decimal(18,4)) as tolminus
			  , t1.sizecol
			  , t2.ConvGrade
		FROM    pamlmeaslbl AS t1
				JOIN pamlmeasigc AS t2 ON t1.sizecol = t2.sizecol 
				Join pamlmeaspom as t3 ON t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 
				) p
		PIVOT
		(
		MAX([ConvGrade])
		FOR sizecol IN
		( '+
		@cols +' )
		) AS pvt
		ORDER BY sortid, refcode, description, pom_row ;'
	end

EXECute(@query)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '415', GetDate())
GO

