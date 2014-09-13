INSERT INTO pLineFolderFinancial (LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable, RangePlan)
VALUES ('10000000-0000-0000-0000-000000000014', 'decimal', '0', 'font', 'Quantity to deliver to warehouse', '0014', 1, 1, 1)

INSERT INTO pLineFolderFinancial (LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable, RangePlan)
VALUES ('10000000-0000-0000-0000-000000000015', 'decimal', '0.00', 'font', 'Average Price to deliver to warehouse', '0015', 1, 0, 1)

INSERT INTO pLineFolderFinancial (LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable, RangePlan)
VALUES ('10000000-0000-0000-0000-000000000016', 'decimal', '0.00', 'font', 'Total Amount to deliver to warehouse', '0016', 1, 1, 1)

INSERT INTO pLineFolderFinancial (LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable, RangePlan)
VALUES ('10000000-0000-0000-0000-000000000017', 'decimal', '0.00', 'font', 'Total Amount to delivery to warehouse', '0017', 1, 1, 1)

INSERT INTO pLineFolderFinancial (LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable, RangePlan)
VALUES ('10000000-0000-0000-0000-000000000018', 'decimal', '0.00', 'font', 'Margin', '0018', 1, 0, 1)

GO

UPDATE pLineFolderFinancial SET AllowPercentInput = 1
WHERE LineFolderFinancialID IN 
(
'10000000-0000-0000-0000-000000000000', 
'10000000-0000-0000-0000-000000000001'
)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05752', GetDate())
GO
