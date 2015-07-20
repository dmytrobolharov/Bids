/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecItemDataSet_Logic_SELECT]    Script Date: 03/11/2013 10:47:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecItemDataSet_Logic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecItemDataSet_Logic_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecItemDataSet_Logic_SELECT]    Script Date: 03/11/2013 10:47:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_SampleRequestBOMSpecItemDataSet_Logic_SELECT] (
	@StyleID uniqueidentifier, 
	@StyleSet int,
	@SampleRequestTradeID uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleWorkflowID varchar (50) ,
	@Submit int
)
AS 

DECLARE @ApprovedType INT 


SELECT @ApprovedType = b.ApprovedType 
FROM pSampleRequestSubmitBOM a WITH(NOLOCK)
	INNER JOIN pSampleRequestSubmitStatus b  WITH(NOLOCK) ON a.Status = b.StatusID 
WHERE a.SampleRequestTradeID = @SampleRequestTradeID 
	AND a.SampleWorkflowID  = @SampleWorkflowID 
	AND a.Submit = @Submit 
	

SELECT 
	a.POM, a.PointMeasur, a.POMTempID, b.POMLibraryID, a.SpecID, a.StyleID, a.POMTempItemID,  a.ModelSpecID, a.ModelID, 
	a.StyleSet, a.Critical,   a.TOL, a.TOLN, a.Spec, a.Proto0, 
	a.Proto1, a.Proto2, a.Proto3, a.Proto4, a.Proto5, a.Proto6, a.Proto7, a.Proto8, a.Proto9, a.Proto10, a.Proto11, a.Grade0, a.Grade1, a.Grade2, 
	a.Grade3, a.Grade4, a.Grade5, a.Grade6, 
	a.Grade7, a.Grade8, a.Grade9, a.Grade10, a.Grade11, a.Size0, a.Size1, a.Size2, a.Size3, a.Size4, a.Size5, a.Size6, a.Size7, a.Size8, 
	a.Size9, a.Size10, a.Size11, a.CDate, a.CUser, 
	a.MDate, a.MUser, a.Change, a.Sort, b.HowToMeasurText, b.HowToMeasurImage ,
	a.SampleRequestSpecID, a.Ask, a.Var, a.Vendor, a.Rev, a.Final,
	CASE 
		WHEN a.POMTempID IS NULL THEN ''
		ELSE '<img src="../System/Icons/icon_link.gif" style="border-width:0px;" />'
	END  AS Linked,
	CASE a.Critical
		WHEN 1 THEN '<img src="../System/Icons/icon_warning.gif" style="border-width:0px;" />'
		ELSE ''
	END AS IsCritical,
	CASE 
		WHEN b.POMLibraryID IS NOT NULL THEN '<input Onclick="javascript:var w=window.open( ''../Control/Control_POMLibrary_HowTo.aspx?PLID=' +
			CAST(b.POMLibraryID AS NVARCHAR(40)) + '&PTID='', ''POMSubmit'', ''menubar=0,toolbar=0,status=0,scrollbars=1,location=0,resizable=1,top=1,left=1,height=600,width=800''); w.focus(); return false;" 
			type="image" src="../System/Icons/icon_howto.gif" style="border-width:0px;" />'
		ELSE ''
	END AS HowTo,
	CASE 
		WHEN a.POMTempID IS NULL THEN 0
		ELSE 1
	END  AS Locked	
FROM pSampleRequestSpecItemBOM a WITH (NOLOCK) 
	LEFT OUTER JOIN pPOMLibrary b WITH (NOLOCK) ON a.POM = b.POM AND a.PointMeasur = b.PointMeasur
WHERE a.StyleID = @StyleID
	AND  a.StyleSet = @StyleSet
	AND a.SampleRequestTradeID = @SampleRequestTradeID
	AND a.SampleRequestWorkflowID = @SampleRequestWorkflowID
	AND a.SampleWorkflowID = @SampleWorkflowID
	AND a.Submit = @Submit
ORDER BY a.Sort, a.POM, a.PointMeasur


	--** Define Schema structure 
	CREATE TABLE #tb (
		GridOrder INT IDENTITY(1,1), 
		[Column] NVARCHAR(200),
		Alias NVARCHAR(200),
		Type  NVARCHAR(200),
		datatype NVARCHAR(200),
		dataformat NVARCHAR(200),
		cellwidth INT,
		GridWidth INT,
		GridHeaderCss NVARCHAR(200),
		LockId NVARCHAR(10)
	)

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss) 
	VALUES('Linked', 'L', 'label', 'string', 50, 15, 'TableHeader' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
	VALUES('IsCritical', 'C', 'label', 'string', 50, 15, 'TableHeader' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss) 
	VALUES('HowTo', 'H', 'label', 'string', 50, 15, 'TableHeader' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, LockId)   
	VALUES('POM', 'POM', 'textbox', 'string', 50, 40, 'TableHeader', '1' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, LockId) 
	VALUES('PointMeasur', 'Point of Measurement', 'textbox', 'string', 50, 200, 'TableHeader','1' )


	--' If washtype = EMPTY then show TOLN
	IF ( SELECT LEN(ISNULL(WashType,'')) FROM pStyleHeader WHERE StyleID = @StyleID) = 0 
		INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, dataformat, LockId  ) 
		VALUES('TOLN', 'TOLN', 'textbox', 'fraction', 50, 60, 'TableHeaderRed' , '', '-1'  )
	ELSE
		INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, LockId  ) 
		VALUES('TOL', 'TOL', 'textbox', 'fraction', 50, 60, 'TableHeaderRed', '-1'   )
	

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss , dataformat, LockId  ) 
	VALUES('Ask', 'Asked', 'textbox', 'fraction', 50, 60, 'TableHeaderBlue', '', '-1'  )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, dataformat ) 
	VALUES('Var', 'Var', 'label', 'fraction', 50, 60, 'TableHeaderRed', '' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, dataformat) 
	VALUES('Vendor', 'Vendor', 'label', 'fraction', 50, 60, 'TableHeaderYellow', '')


	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, LockId  ) 
	VALUES('Spec', '<input type="checkbox" name="chkCpy2Spec" /> Spec.', 'textbox', 'fraction', 50, 60, 'TableHeader', '-1' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, LockId  ) 
	VALUES('Rev', '<input type="checkbox" name="chkCpy2Rev" /> Rev', 'textbox', 'fraction', 50, 60, 'TableHeaderGreen', '-1' )

	IF @ApprovedType = 1 
		INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, LockId  ) 
		VALUES('Final', '<input type="checkbox" name="chkCpy2Final" />Final', 'textbox', 'fraction', 50, 60, 'TableHeader', '-1'  )

	SELECT RIGHT( '0000'+ CAST(GridOrder AS NVARCHAR(3)), 4)  AS GridOrder, [Column], Alias, Type, 
	datatype, dataformat, cellwidth, GridWidth, GridHeaderCss, ISNULL(LockId,0) AS LockId
	FROM #tb
	
	DROP TABLE #tb 	



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05274', GetDate())
GO
