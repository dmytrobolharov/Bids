SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOL_PageCopy_INSERT] 
(
@StyleID nvarchar(50),
@StyleSet int,
@NewStyleID nvarchar(50),
@NewStyleSet int,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)

DECLARE @PageOperationId as varchar(50)
DECLARE @IsLinked as int
DECLARE @Sort as nvarchar(5)
DECLARE @OperationId as varchar(50)
DECLARE @MacroId as varchar(50)
DECLARE @Code as nvarchar(200)
DECLARE @Name as nvarchar(200)
DECLARE @Comments as nvarchar(200)
DECLARE @ImageID as varchar(50)
DECLARE @ImageType as varchar(50)
DECLARE @SAM as numeric(10, 2)
DECLARE @Coef as numeric(10, 2)
DECLARE @Adj as nvarchar(20)
DECLARE @AdjTime as nvarchar(20)
DECLARE @BaseRateId as varchar(50)
DECLARE @MachineId as varchar(50)
DECLARE @IsException as int


BEGIN

SELECT @nCount = count(*) FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE (StyleId = @NewStyleID)  AND  (StyleSet = @NewStyleSet) AND (MacroParentId IS NULL)
SELECT @nMax = cast ( MAX (Sort) as int ) FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE (StyleId = @NewStyleID)  AND  (StyleSet = @NewStyleSet) AND (MacroParentId IS NULL)
IF @nCount IS NULL SET @nCount = 0 
IF @nMax IS NULL SET @nMax = 0 
IF @nCount > @nMax SET @nSort = @nCount 
ELSE SET @nSort = @nMax 
print 'nCount=' + Cast(@nCount as varchar (10) ) + ' nMax=' + Cast( @nMax as varchar (10) ) + ' nSort=' + Cast( @nSort as varchar (10) )

SET @vcCount = RIGHT ( '0000' + cast ( @nSort as nvarchar (4) ) , 4 )
print 'vccount 1 = ' + @vcCount

--copy all without unlinked macro and their operations
INSERT INTO pStyleBOLPageOperations 
	(PageOperationId, StyleID, StyleSet, Sort, isLinked, OperationId, MacroId, 
	Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, CUser, CDate, MUser, MDate, IsException)
SELECT  newid(), @NewStyleID, @NewStyleSet, RIGHT ( '0000' + CAST( cast (@vcCount as int) + cast (Sort as int) AS nvarchar (4)), 4), IsLinked, OperationId, MacroId,
		Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, IsException
FROM pStyleBOLPageOperations
WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND ((IsLinked = 1) OR (IsLinked = 0 AND MacroParentId IS NULL AND MacroId IS NULL))

	--Cursor for unlinked macro and their operations 
	DECLARE @CURSOR CURSOR
	SET @CURSOR = CURSOR SCROLL
	FOR
		SELECT  PageOperationId, Sort, isLinked, OperationId, MacroId, 
		Code, Name, Comments, MachineId, BaseRateId, Coef, Adj, AdjTime, ImageID, ImageType, IsException
		FROM  pStyleBOLPageOperations WHERE  isLinked = 0 AND MacroId IS NOT NULL AND (StyleID = @StyleID) AND (StyleSet = @StyleSet)
	OPEN @CURSOR
	FETCH NEXT FROM @CURSOR INTO @PageOperationId, @Sort, @isLinked, @OperationId, @MacroId, 
	@Code, @Name, @Comments, @MachineId, @BaseRateId, @Coef, @Adj, @AdjTime, @ImageID, @ImageType, @IsException
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @NewPageOperationId as UNIQUEIDENTIFIER
		set @NewPageOperationId = newid()
		
		--insert macro
		INSERT INTO pStyleBOLPageOperations 
		(PageOperationId, StyleID, StyleSet, Sort, isLinked, OperationId, MacroId, 
		Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, CUser, CDate, MUser, MDate, IsException)
		VALUES
		(@NewPageOperationId, @NewStyleID, @NewStyleSet, RIGHT ( '0000' + CAST( cast (@vcCount as int) + cast (@Sort as int) AS nvarchar (4)), 4), @isLinked, @OperationId, @MacroId, 
		@Code, @Name, @Comments, @MachineId, @BaseRateId, @SAM, @Coef, @Adj, @AdjTime, @ImageID, @ImageType, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @IsException)
		
		--insert operations of unlinked macro (set MacroParentId for them)
		INSERT INTO pStyleBOLPageOperations 
		(PageOperationId, StyleID, StyleSet, Sort, isLinked, OperationId, MacroId, 
		Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, CUser, CDate, MUser, MDate, IsException,
		MacroParentId)
		SELECT  newid(), @NewStyleID, @NewStyleSet, Sort, IsLinked, OperationId, MacroId,
		Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @IsException,
		@NewPageOperationId
		FROM pStyleBOLPageOperations
		WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND (MacroParentId = @PageOperationId)

	FETCH NEXT FROM @CURSOR INTO @PageOperationId, @Sort, @isLinked, @OperationId, @MacroId, 
	@Code, @Name, @Comments, @MachineId, @BaseRateId, @Coef, @Adj, @AdjTime, @ImageID, @ImageType, @IsException
	END
	CLOSE @CURSOR
	

END


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01818'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01818', GetDate())
END

GO
