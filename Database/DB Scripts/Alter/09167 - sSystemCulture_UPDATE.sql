-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 31 October 2014                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

UPDATE sSystemCulture
SET CurrencyDecimalSymbol = ',',
CurrencyDigitGroupingSymbol = '.',
DecimalValidationRegEx = '((\d{1,3})?(\.\d{3})*\,?\d*|\d*\,?\d*)',
CurrencyValidationRegEx = '^\$?([1-9]{1}[0-9]{0,2}(\.[0-9]{3})*(\,[0-9]{0,2})?|[1-9]{1}[0-9]{0,}(\,[0-9]{0,2})?|0(\,[0-9]{0,2})?|(\,[0-9]{1,2})?)$',
PercentValidationRegEx = '[0-9]+[,]?[0-9]*[\ ]*[\%]?'
WHERE CultureName = 'da-DK'
GO

UPDATE sSystemCulture
SET CurrencyDecimalSymbol = ',',
CurrencyDigitGroupingSymbol = ' ',
CurrencyValidationRegEx = '^\$?([1-9]{1}[0-9]{0,2}([\u00A0\s][0-9]{3})*([.,][0-9]{0,2})?|[1-9]{1}[0-9]{0,}([,.][0-9]{0,2})?|0([,.][0-9]{0,2})?|([,.][0-9]{1,2})?)$',
PercentValidationRegEx = '[0-9]+[,.]?[0-9]*[\s]*[\%]?'
WHERE CultureName = 'sv-SE'
GO

UPDATE sSystemCulture
SET CurrencyDecimalSymbol = ',',
CurrencyDigitGroupingSymbol = ' ',
CurrencyValidationRegEx = '^\$?([1-9]{1}[0-9]{0,2}([\u00A0\s][0-9]{3})*([,][0-9]{0,2})?|[1-9]{1}[0-9]{0,}([,][0-9]{0,2})?|0([,][0-9]{0,2})?|([,][0-9]{1,2})?)$',
PercentValidationRegEx = '[0-9]+[,]?[0-9]*[\ ]*[\%]?'
WHERE CultureName = 'sv-FI'
GO

UPDATE sSystemCulture
SET CurrencyDecimalSymbol = ',',
CurrencyDigitGroupingSymbol = '.',
NumberDecimalSymbol = ',',
NumberDigitGroupingSymbol = '.',
DecimalValidationRegEx = '((\d{1,3})?(\.\d{3})*\,?\d*|\d*\,?\d*)',
CurrencyValidationRegEx = '^\$?([1-9]{1}[0-9]{0,2}(\.[0-9]{3})*(\,[0-9]{0,2})?|[1-9]{1}[0-9]{0,}(\,[0-9]{0,2})?|0(\,[0-9]{0,2})?|(\,[0-9]{1,2})?)$',
PercentValidationRegEx = '[\%]?[0-9]+[,]?[0-9]*'
WHERE CultureName = 'tr-TR'
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09167', GetDate())
GO
