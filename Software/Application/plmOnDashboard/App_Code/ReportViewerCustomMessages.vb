Imports System
Imports System.Collections.Generic
Imports System.Text
Imports Microsoft.Reporting.WebForms

Public Class ReportViewerCustomMessages
    Implements Microsoft.Reporting.WebForms.IReportViewerMessages

    Public ReadOnly Property BackButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.BackButtonToolTip
        Get
            Return "Back"
        End Get
    End Property

    Public ReadOnly Property ChangeCredentialsText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ChangeCredentialsText
        Get
            Return "Change Credentials"
        End Get
    End Property

    Public ReadOnly Property ChangeCredentialsToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ChangeCredentialsToolTip
        Get
            Return "Change Credentials"
        End Get
    End Property

    Public ReadOnly Property CurrentPageTextBoxToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.CurrentPageTextBoxToolTip
        Get
            Return "Current Page"
        End Get
    End Property

    Public ReadOnly Property DocumentMap() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.DocumentMap
        Get
            Return "Document Map"
        End Get
    End Property

    Public ReadOnly Property DocumentMapButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.DocumentMapButtonToolTip
        Get
            Return "Document Map"
        End Get
    End Property

    Public ReadOnly Property ExportButtonText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ExportButtonText
        Get
            Return "Export"
        End Get
    End Property

    Public ReadOnly Property ExportButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ExportButtonToolTip
        Get
            Return "Export"
        End Get
    End Property

    Public ReadOnly Property ExportFormatsToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ExportFormatsToolTip
        Get
            Return "Export"
        End Get
    End Property

    Public ReadOnly Property FalseValueText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.FalseValueText
        Get
            Return "False"
        End Get
    End Property

    Public ReadOnly Property FindButtonText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.FindButtonText
        Get
            Return "Find"
        End Get
    End Property

    Public ReadOnly Property FindButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.FindButtonToolTip
        Get
            Return "Find"
        End Get
    End Property

    Public ReadOnly Property FindNextButtonText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.FindNextButtonText
        Get
            Return "Find Next"
        End Get
    End Property

    Public ReadOnly Property FindNextButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.FindNextButtonToolTip
        Get
            Return "Find Next"
        End Get
    End Property

    Public ReadOnly Property FirstPageButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.FirstPageButtonToolTip
        Get
            Return "First Page"
        End Get
    End Property

    Public ReadOnly Property InvalidPageNumber() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.InvalidPageNumber
        Get
            Return "Invalid Page Number"
        End Get
    End Property

    Public ReadOnly Property LastPageButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.LastPageButtonToolTip
        Get
            Return "Last Page"
        End Get
    End Property

    Public ReadOnly Property NextPageButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.NextPageButtonToolTip
        Get
            Return "Next Page"
        End Get
    End Property

    Public ReadOnly Property NoMoreMatches() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.NoMoreMatches
        Get
            Return "No More Matches"
        End Get
    End Property

    Public ReadOnly Property NullCheckBoxText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.NullCheckBoxText
        Get
            Return "Null"
        End Get
    End Property

    Public ReadOnly Property NullValueText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.NullValueText
        Get
            Return "Null"
        End Get
    End Property

    Public ReadOnly Property PageOf() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.PageOf
        Get
            Return "Page Of"
        End Get
    End Property

    Public ReadOnly Property ParameterAreaButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ParameterAreaButtonToolTip
        Get
            Return "Parameter Area"
        End Get
    End Property

    Public ReadOnly Property PasswordPrompt() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.PasswordPrompt
        Get
            Return "Password"
        End Get
    End Property

    Public ReadOnly Property PreviousPageButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.PreviousPageButtonToolTip
        Get
            Return "Previous Page"
        End Get
    End Property

    Public ReadOnly Property PrintButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.PrintButtonToolTip
        Get
            Return "Print"
        End Get
    End Property

    Public ReadOnly Property ProgressText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ProgressText
        Get
            Return "Dashboard Loading"
        End Get
    End Property

    Public ReadOnly Property RefreshButtonToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.RefreshButtonToolTip
        Get
            Return "Refresh"
        End Get
    End Property

    Public ReadOnly Property SearchTextBoxToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.SearchTextBoxToolTip
        Get
           Return "Search"
        End Get
    End Property

    Public ReadOnly Property SelectAll() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.SelectAll
        Get
            Return "Select All"
        End Get
    End Property

    Public ReadOnly Property SelectAValue() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.SelectAValue
        Get
            Return "Select a Value"
        End Get
    End Property

    Public ReadOnly Property SelectFormat() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.SelectFormat
        Get
            Return "Select Format"
        End Get
    End Property

    Public ReadOnly Property TextNotFound() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.TextNotFound
        Get
            Return "Text Not Found"
        End Get
    End Property

    Public ReadOnly Property TodayIs() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.TodayIs
        Get
            Return "Today is"
        End Get
    End Property

    Public ReadOnly Property TrueValueText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.TrueValueText
        Get
         Return "True"
        End Get
    End Property

    Public ReadOnly Property UserNamePrompt() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.UserNamePrompt
        Get
           Return "User Name"
        End Get
    End Property

    Public ReadOnly Property ViewReportButtonText() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ViewReportButtonText
        Get
            Return "View Dashboard"
        End Get
    End Property

    Public ReadOnly Property ZoomControlToolTip() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ZoomControlToolTip
        Get
            Return "Zoom"
        End Get
    End Property

    Public ReadOnly Property ZoomToPageWidth() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ZoomToPageWidth
        Get
            Return "Zoom to Page Width"
        End Get
    End Property

    Public ReadOnly Property ZoomToWholePage() As String Implements Microsoft.Reporting.WebForms.IReportViewerMessages.ZoomToWholePage
        Get
            Return "Zoom to Whole Page"
        End Get
    End Property

End Class