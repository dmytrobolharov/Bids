IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOL_Copy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOL_Copy_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOL_Copy_INSERT] 
(
@StyleID nvarchar(50),
@NewStyleID nvarchar(50),
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)

DECLARE @PageOperationId as varchar(50)
DECLARE @StyleSet as int
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

DECLARE @NewPageOperationId as uniqueidentifier
DECLARE @OldPageOperationId as uniqueidentifier
DECLARE @NewBOLExceptionId as uniqueidentifier
DECLARE @OldBOLExceptionId as uniqueidentifier

DECLARE @CURSOR CURSOR, @CURSOR2 CURSOR

-- temp table for list BOL operations
CREATE TABLE #tmpBOLOperations (
	 NewPageOperationId uniqueidentifier
	,OldPageOperationId uniqueidentifier
	,StyleID uniqueidentifier
	,StyleSet int
	,Sort nvarchar(5)
	,IsLinked int
	,OperationId uniqueidentifier
	,MacroId uniqueidentifier
	,MacroParentId uniqueidentifier
	,Code nvarchar(200)
	,Name nvarchar(200)
	,Comments nvarchar(200)
	,ImageID uniqueidentifier
	,ImageType nvarchar(50)
	,SAM numeric(10,2)
	,Coef numeric(10,2)
	,Adj nvarchar(20)
	,AdjTime nvarchar(20)
	,BaseRateId uniqueidentifier
	,MachineId uniqueidentifier
	,CUser nvarchar(200)
	,CDate datetime
	,MUser nvarchar(200)
	,MDate datetime
	,IsException int
)

-- temp table for BOL exceptions of certain style
CREATE TABLE #tmpBOLException(
	 NewBOLExceptionId uniqueidentifier
	,OldBOLExceptionId uniqueidentifier
	,StyleId uniqueidentifier
	,StyleSet int
	,BOLExceptionName nvarchar(200)
	,CUser nvarchar(200)
	,CDate datetime
	,MUser nvarchar(200)
	,MDate datetime
)

BEGIN

--copy all without unlinked macro and their operations
INSERT INTO #tmpBOLOperations 
	(NewPageOperationId, OldPageOperationId, StyleID, StyleSet, Sort, isLinked, OperationId, MacroId, 
	Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, CUser, CDate, MUser, MDate, IsException)
SELECT  newid(), PageOperationId, @NewStyleID, StyleSet, Sort, IsLinked, OperationId, MacroId,
		Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, IsException
FROM pStyleBOLPageOperations
WHERE (StyleID = @StyleID) AND ((IsLinked = 1) OR (IsLinked = 0 AND MacroParentId IS NULL AND MacroId IS NULL))

	--Cursor for unlinked macro and their operations 
	SET @CURSOR = CURSOR SCROLL
	FOR
		SELECT  PageOperationId, StyleSet, Sort, isLinked, OperationId, MacroId, 
		Code, Name, Comments, MachineId, BaseRateId, Coef, Adj, AdjTime, ImageID, ImageType, IsException
		FROM  pStyleBOLPageOperations WHERE  isLinked = 0 AND MacroId IS NOT NULL AND (StyleID = @StyleID)
	OPEN @CURSOR
	FETCH NEXT FROM @CURSOR INTO @PageOperationId, @StyleSet, @Sort, @isLinked, @OperationId, @MacroId, 
	@Code, @Name, @Comments, @MachineId, @BaseRateId, @Coef, @Adj, @AdjTime, @ImageID, @ImageType, @IsException
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @NewUnlinkMacroPageOperationId as UNIQUEIDENTIFIER
		set @NewUnlinkMacroPageOperationId = NEWID()
		
		--insert unlincked macro
		INSERT INTO #tmpBOLOperations 
		(NewPageOperationId, OldPageOperationId, StyleID, StyleSet, Sort, isLinked, OperationId, MacroId, 
		Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, CUser, CDate, MUser, MDate, IsException)
		VALUES
		(@NewUnlinkMacroPageOperationId, @PageOperationId, @NewStyleID, @StyleSet, @Sort, @isLinked, @OperationId, @MacroId, 
		@Code, @Name, @Comments, @MachineId, @BaseRateId, @SAM, @Coef, @Adj, @AdjTime, @ImageID, @ImageType, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @IsException)
		
		--insert operations of unlinked macro (set MacroParentId for them)
		INSERT INTO #tmpBOLOperations 
		(NewPageOperationId, OldPageOperationId, StyleID, StyleSet, Sort, isLinked, OperationId, MacroId, 
		Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, CUser, CDate, MUser, MDate, IsException,
		MacroParentId)
		SELECT  NEWID(), PageOperationId, @NewStyleID, StyleSet, Sort, IsLinked, OperationId, MacroId,
		Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @IsException,
		@NewUnlinkMacroPageOperationId
		FROM pStyleBOLPageOperations
		WHERE (StyleID = @StyleID) AND (MacroParentId = @PageOperationId)

	FETCH NEXT FROM @CURSOR INTO @PageOperationId, @StyleSet, @Sort, @isLinked, @OperationId, @MacroId, 
	@Code, @Name, @Comments, @MachineId, @BaseRateId, @Coef, @Adj, @AdjTime, @ImageID, @ImageType, @IsException
	END
	CLOSE @CURSOR
	
	-- insert list from temporary table to pStyleBOLPageOperations
	INSERT INTO pStyleBOLPageOperations (PageOperationId, StyleID, StyleSet, Sort, isLinked, OperationId, MacroId, 
		MacroParentId, Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, CUser, CDate, 
		MUser, MDate, IsException)
	SELECT NewPageOperationId, StyleID, StyleSet, Sort, isLinked, OperationId, MacroId, 
		MacroParentId, Code, Name, Comments, MachineId, BaseRateId, SAM, Coef, Adj, AdjTime, ImageID, ImageType, CUser, CDate, 
		MUser, MDate, IsException
	FROM #tmpBOLOperations

	-- copy exceptions to temp table
	INSERT INTO #tmpBOLException (NewBOLExceptionId, OldBOLExceptionId, StyleId, StyleSet, 
		BOLExceptionName, CUser, CDate, MUser, MDate)
	SELECT NEWID(), BOLExceptionId, @NewStyleID, StyleSet, BOLExceptionName, CUser, CDate, @CreatedBy, @CreatedDate
	FROM pStyleBOLException WHERE StyleId = @StyleID
	
	-- copy exceptions from temp table to pStyleBOLException
	INSERT INTO pStyleBOLException (BOLExceptionId, StyleId, StyleSet, 
		BOLExceptionName, CUser, CDate, MUser, MDate)
	SELECT NewBOLExceptionId, StyleId, StyleSet, BOLExceptionName, CUser, CDate, MUser, MDate 
	FROM #tmpBOLException


	-- cursors for copying data of table - pStyleBOLExceptionEntries
	SET @CURSOR = CURSOR SCROLL
	FOR
		SELECT NewPageOperationId, OldPageOperationId FROM #tmpBOLOperations
	OPEN @CURSOR
	FETCH NEXT FROM @CURSOR INTO @NewPageOperationId, @OldPageOperationId
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SET @CURSOR2 = CURSOR SCROLL
		FOR
			SELECT NewBOLExceptionId, OldBOLExceptionId FROM #tmpBOLException
		OPEN @CURSOR2
		FETCH NEXT FROM @CURSOR2 INTO @NewBOLExceptionId, @OldBOLExceptionId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- if in pStyleBOLExceptionEntries record with @OldBOLExceptionId and @OldPageOperationId exists
			-- make copy with new IDs (BOLExceptionId and PageOperationId)
			IF (SELECT COUNT(*) FROM pStyleBOLExceptionEntries WHERE BOLExceptionId = @OldBOLExceptionId AND PageOperationId = @OldPageOperationId) = 1
			BEGIN
				INSERT INTO pStyleBOLExceptionEntries (BOLExceptionEntryId, BOLExceptionId, PageOperationId)
				VALUES (NEWID(), @NewBOLExceptionId, @NewPageOperationId)
			END
		
		FETCH NEXT FROM @CURSOR2 INTO @NewBOLExceptionId, @OldBOLExceptionId
		END
		CLOSE @CURSOR2
	
	FETCH NEXT FROM @CURSOR INTO @NewPageOperationId, @OldPageOperationId
	END
	CLOSE @CURSOR
	
	

	-- delete temporary tables
	DROP TABLE #tmpBOLOperations
	DROP TABLE #tmpBOLException
	

END

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02309'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02309', GetDate())
END	
GO