/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_Logic_INSERT]    Script Date: 20.03.2015 14:11:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_Logic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogItem_Logic_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_Logic_INSERT]    Script Date: 20.03.2015 14:11:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_ChangeLogItem_Logic_INSERT] (
	@ChangeLogItemID UNIQUEIDENTIFIER
)
AS 
BEGIN

DECLARE 
	@ChangeTableID UNIQUEIDENTIFIER,
	@ChangeTransTypeID INT,
	@ChangeTablePKID NVARCHAR(40),
	@MUser NVARCHAR(200),
	@MDate DATETIME


SELECT @ChangeTableID=c.ChangeTableID, @ChangeTransTypeID=b.ChangeTransTypeID,
@ChangeTablePKID=ChangeTablePKID, @MUser = c.ChangeUserName, @MDate = c.ChangeDate
FROM dbo.pChangeLogItem a
	INNER JOIN dbo.pChangeTransaction b ON a.ChangeTransID = b.ChangeTransID
	INNER JOIN dbo.pChangeLog c ON c.ChangeLogID =  a.ChangeLogID
WHERE a.ChangeLogItemID = @ChangeLogItemID


DECLARE 
	@Custom_SMat_Name NVARCHAR(200),
	@Custom_SMat_No NVARCHAR(200),
	@Custom_SMat_Type NVARCHAR(200)
	
IF @ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' --pStyleMaterials
--AND (@ChangeTablePKID = 0  OR @ChangeTablePKID = 1 OR @ChangeTablePKID = 2)  -- Update and Add
BEGIN



	SELECT @Custom_SMat_Name = a.MaterialName, @Custom_SMat_No = a.MaterialNo, 
	@Custom_SMat_Type = b.ComponentDescription
	FROM dbo.pStyleMaterials a WITH (NOLOCK)
		INNER JOIN dbo.pComponentType b WITH (NOLOCK) ON a.MaterialType =  b.ComponentTypeID
	WHERE a.StyleMaterialID = @ChangeTablePKID

	UPDATE pChangeLogItem 
	SET Custom_SMat_Name = @Custom_SMat_Name , Custom_SMat_No = @Custom_SMat_No,
	Custom_SMat_Type = @Custom_SMat_Type
	WHERE ChangeLogItemID = @ChangeLogItemID

END 

-- Updating style MDate
IF @ChangeTableID IN (
	'D612FAAE-7ACD-DF11-AF06-005056C00008',
	'036F8B4C-C1CC-DF11-AF06-005056C00008', 
	'00000003-C1CC-DF11-AF06-005056C00008', 
	'DD12FAAE-7ACD-DF11-AF06-005056C00008', 
	'00000002-C1CC-DF11-AF06-005056C00008',
	'00000006-C1CC-DF11-AF06-005056C00008'
) OR @ChangeTableID IN (
	SELECT c.ChangeTableID FROM pChangeTable c 
	INNER JOIN pStyleWorkflowToChangeTable sc ON sc.ChangeTableID = c.ChangeTableID 
	WHERE ChangeTableFieldName = 'StyleID' OR ChangeTableFieldName = 'WorkFlowItemID'
)
BEGIN
	DECLARE @StyleID UNIQUEIDENTIFIER

	SELECT @StyleID = StyleID FROM pStyleHeader WHERE StyleID = @ChangeTablePKID
	IF @StyleID IS NULL
		SELECT @StyleID = StyleID FROM pWorkFlowItem WHERE WorkFlowItemID = @ChangeTablePKID
	IF @StyleID IS NOT NULL
		UPDATE pStyleHeader SET MDate = @MDate, MUser = @MUser WHERE StyleID = @StyleID
END

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10216', GetUTCDate())
GO
