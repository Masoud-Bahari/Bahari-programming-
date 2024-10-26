Attribute VB_Name = "Codes"
' Global variable declarations
Public T1 As String, T2 As String, T3 As String, T4 As String, T5 As String
Public ppth As String
Public doc As Document
Public para As Paragraph
Public i As Long
Public ctrl As ContentControl
Public originalCount As Long
Public rng As Range
Public desiredFontName As String
Public desiredFontSize As Integer
Public counters(1 To 10) As Long ' Example for 10 counters

Sub InitializeCounters()
    Dim i As Long
    For i = LBound(counters) To UBound(counters)
        counters(i) = 0 ' Set each element to zero
    Next i
End Sub

Sub InitializeGlobals()
    Call InitializeCounters
    ' You can add more global initializations here if needed
End Sub

Public Function UpdateContentControls() As Boolean
    ' Check if any text box is empty
    If T1 = "" Or T2 = "" Or T3 = "" Or T4 = "" Or T5 = "" Then
        MsgBox "Warning: Please fill in all fields.", vbExclamation, "Input Error"
        UpdateContentControls = False ' Return false if input is invalid
        Exit Function
    End If

    ' Loop through content controls and update them based on titles
    For Each ctrl In ActiveDocument.ContentControls
        Select Case ctrl.Title
            Case "Empfaenger"
                ctrl.Range.text = T1
            Case "Position"
                ctrl.Range.text = T2
            Case "Task"
                ctrl.Range.text = T3
            Case "Interest"
                ctrl.Range.text = T4
        End Select
    Next ctrl
    UpdateContentControls = True ' Return true if everything is successful
End Function

Sub ShowMasoudUserForm()
    ' Show the UserForm named Masoud
    Masoud.Show
End Sub








