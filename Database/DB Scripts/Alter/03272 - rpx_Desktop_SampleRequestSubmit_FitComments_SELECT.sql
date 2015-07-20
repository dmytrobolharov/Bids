IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Desktop_SampleRequestSubmit_FitComments_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Desktop_SampleRequestSubmit_FitComments_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Desktop_SampleRequestSubmit_FitComments_SELECT]

(
	@StyleTypeID int
	,@DateBegin varchar(25)
	,@DateEnd varchar(25)
)

AS


-- --Test variables
-- DECLARE @StyleTypeID int
-- DECLARE @DateBegin varchar(25)
-- DECLARE @DateEnd varchar(25)
-- SET @StyleTypeID = '10'
-- SET @DateBegin = '5/10/08'
-- SET @DateEnd = '9/01/08'


--Declare variables
DECLARE @SqlStrSelect varchar(4000)
DECLARE @SqlStrWhere2 varchar(4000)
DECLARE @SqlStrWhere3 varchar(4000)
DECLARE @SqlStrOrder varchar(4000)
DECLARE @StyleTypeStr varchar(100)
DECLARE @DateBeginStr varchar(25)
DECLARE @DateEndStr varchar(25)


--Prepare parameters for the end SELECT also
SELECT @StyleTypeStr = StyleTypeDescription
FROM pStyleType WITH (NOLOCK)
WHERE StyleTypeID = @StyleTypeID

SET @DateBeginStr = SUBSTRING(@DateBegin,1,10)
SET @DateEndStr = SUBSTRING(@DateEnd,1,10)


--Check variables
IF(@StyleTypeStr = '' OR @StyleTypeStr IS NULL)
	BEGIN
		SET @StyleTypeStr = 'All Style Types'
	END

IF(@DateBeginStr = '' OR @DateBeginStr IS NULL)
	BEGIN
		SET @DateBeginStr = 'No Beginning'
	END

IF(@DateEndStr = '' OR @DateEndStr IS NULL)
	BEGIN
		SET @DateEndStr = 'Present'
	END


--Update the date variables with the time extensions
IF(@DateBegin <> '' AND @DateBegin IS NOT NULL)
	BEGIN
		SET @DateBegin = SUBSTRING(@DateBegin,1,10) + ' 00:00:00'
	END
ELSE IF(@DateBegin IS NULL)
	BEGIN
		SET @DateBegin = ''
	END

IF(@DateEnd <> '' AND @DateEnd IS NOT NULL)
	BEGIN
		SET @DateEnd = SUBSTRING(@DateEnd,1,10) + ' 23:59:59'
	END
ELSE IF(@DateEnd IS NULL)
	BEGIN
		SET @DateBegin = ''
	END


/*Create the Sql Strings*/
--Set SELECT string
SET @SqlStrSelect = 
	'SELECT '''
		+ @StyleTypeStr + ''' AS StyleType
		, ''' + @DateBeginStr + ''' AS DateBegin
		, ''' + @DateEndStr + ''' AS DateEnd
		, ''Style Type: '' + pStyleType.StyleTypeDescription
		+ '' > Style No: '' + pStyleHeader.StyleNo
		+ '' > Agent: '' + uTradePartner.TradePartnerName
		+ '' > Vendor: '' + uTradePartnerVendor.VendorName
		+ '' > Sample Workflow: '' + pSampleWorkflow.SampleWorkflow
		+ '' > Submit: '' + CAST(pSampleRequestSubmit.Submit AS varchar(2)) AS GroupHeading
		,pSampleRequestSubmit.MUser
		,pSampleRequestSubmit.MDate
		,pSampleRequestSubmit.Comment
	FROM pSampleRequestSubmit WITH (NOLOCK)
		INNER JOIN pStyleHeader WITH (NOLOCK) ON	pSampleRequestSubmit.StyleID = pStyleHeader.StyleID
		INNER JOIN pStyleType WITH (NOLOCK) ON	pStyleHeader.StyleType = pStyleType.StyleTypeID
		INNER JOIN uTradePartner WITH (NOLOCK) ON	pSampleRequestSubmit.TradePartnerID = uTradePartner.TradePartnerID
		INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON	pSampleRequestSubmit.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
		INNER JOIN pSampleWorkflow WITH (NOLOCK) ON	pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	WHERE pSampleRequestSubmit.Comment is not null'



--Set WHERE2 (date) string
IF(@DateBegin <> '' AND @DateEnd = '')
	BEGIN
		SET @SqlStrWhere2 = ' AND	pSampleRequestSubmit.MDate >= ''' + @DateBegin + ''''
	END
ELSE IF(@DateBegin = '' AND @DateEnd <> '')
	BEGIN
		SET @SqlStrWhere2 = ' AND	pSampleRequestSubmit.MDate <= ''' + @DateEnd + ''''
	END
ELSE IF(@DateBegin <> '' AND @DateEnd <> '')
	BEGIN
		SET @SqlStrWhere2 = 
				' AND	(pSampleRequestSubmit.MDate >= ''' + @DateBegin + '''
					AND	pSampleRequestSubmit.MDate <= ''' + @DateEnd + ''')'
	END
ELSE IF(@DateBegin = '' AND @DateBegin = '')
	BEGIN
		SET @SqlStrWhere2 = ''
	END


--Set WHERE3 (StyleType) string
IF(@StyleTypeID <> '')
	BEGIN
		SET @SqlStrWhere3 =
				' AND (pSampleRequestSubmit.StyleID IN	(SELECT StyleID
														FROM pStyleHeader WITH (NOLOCK)
														WHERE StyleType = ' + CAST(@StyleTypeID AS varchar(2)) + '))'
	END
ELSE IF(@StyleTypeID = '')
	BEGIN
		SET @SqlStrWhere3 = ''
	END


--Set ORDER string
SET @SqlStrOrder =
	' ORDER BY
		pStyleHeader.StyleType
		,pStyleHeader.StyleNo
		,uTradePartner.TradePartnerName
		,uTradePartnerVendor.VendorName
		,pSampleWorkflow.SampleWorkflowID
		,pSampleRequestSubmit.Submit DESC'


--Select the data
EXEC(@SqlStrSelect + @SqlStrWhere2 + @SqlStrWhere3 + @SqlStrOrder)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03272', GetDate())
GO