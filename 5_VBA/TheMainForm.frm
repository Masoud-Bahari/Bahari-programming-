VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} Masoud 
   Caption         =   "UserForm1"
   ClientHeight    =   4305
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   9390.001
   OleObjectBlob   =   "Masoud.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "Masoud"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

    Dim folderName As String
    Dim folderPath As String



Private Sub CommandButton10_Click()
    Dim pdf1 As String
    Dim pdf2 As String
    Dim mergedPdf As String
    Dim pth1 As String
    Dim command As String
    
    ' Set the paths to the two PDFs you want to merge
    pdf1 = "C:\Users\mab30ri\University of Wuerzburg Dropbox\Masoud Bahari\5-Job document\-BewerbungBank\16-\Arbeitszeugnis_MBahari_JMU_Wuerzburg.pdf"
    pdf2 = "C:\Users\mab30ri\University of Wuerzburg Dropbox\Masoud Bahari\5-Job document\-BewerbungBank\16-\Bahari_Lebenslauf.pdf"
    
    ' Set the path where the merged PDF will be saved
    mergedPdf = "C:\Users\mab30ri\University of Wuerzburg Dropbox\Masoud Bahari\5-Job document\-BewerbungBank\16-\merged_output.pdf"
    
    ' Path to PDFtk executable
    pth1 = "C:\Program Files (x86)\PDFtk\bin\pdftk.exe"
    
    ' Create the command to merge the PDFs
    command = """" & pth1 & """ """ & pdf1 & """ """ & pdf2 & """ cat output """ & mergedPdf & """"
    
    ' Execute the command
    Shell command, vbNormalFocus
    
    MsgBox "PDFs have been merged successfully!"
End Sub

Private Sub CommandButton12_Click()
    ' Requires references to Microsoft HTML Object Library and Microsoft Internet Controls
    ' To add these references, go to Tools > References in the VBA editor.

    Dim sourceText As String
    Dim translatedText As String
    Dim url As String
    Dim xmlHttp As Object
    Dim htmlDoc As Object
    Dim divElements As Object
    Dim i As Integer

    ' Get the content of the Word document
    sourceText = ActiveDocument.Content.text
    
    ' Check if there's any text to translate
    If Len(Trim(sourceText)) = 0 Then
        MsgBox "The document is empty."
        Exit Sub
    End If
    
    ' Build the Google Translate URL (from German to English)
    url = "https://translate.google.com/m?sl=de&tl=en&q=" & URLEncode(sourceText)
    
    ' Create the XMLHTTP object to make the request
    Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xmlHttp.Open "GET", url, False
    xmlHttp.setRequestHeader "User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)"
    xmlHttp.send
    
    ' Check if the request was successful
    If xmlHttp.Status <> 200 Then
        MsgBox "Error: Unable to connect to Google Translate."
        Exit Sub
    End If
    
    ' Load the response HTML into the HTML document object
    Set htmlDoc = CreateObject("htmlfile")
    htmlDoc.body.innerHTML = xmlHttp.responseText
    
    ' Extract the translated text by traversing the HTML structure
    Set divElements = htmlDoc.getElementsByTagName("div")
    
    ' Loop through the div elements to find the translated text
    For i = 0 To divElements.Length - 1
        If divElements(i).ClassName = "result-container" Then
            translatedText = divElements(i).innerText
            Exit For
        End If
    Next i
    
    ' If translation is not found
    If Len(translatedText) = 0 Then
        MsgBox "Translation failed. Please check the structure."
        Exit Sub
    End If
    
    ' Clean the translated text before showing it
    translatedText = CleanText(translatedText)

    ' Format the translated text to maintain line breaks and spacing
    translatedText = Replace(translatedText, vbCr, vbLf) ' Replace carriage returns with line feeds

    ' Reconstructing the translated text into 6 small paragraphs
    Dim finalText As String
    finalText = ReconstructParagraphs(translatedText, 6) ' Call the function for reconstruction

    
    ' Show the translated text in the label with paragraph style and larger font
With Me.TextBox3 ' Assuming you have renamed your TextBox to TextBox1
    .text = finalText ' Set the text
    .Font.Size = 9 ' Set a larger font size
    .TextAlign = fmTextAlignLeft ' Align text to the left
    .WordWrap = True ' Allow text to wrap to the next line
    .MultiLine = True ' Allow multiple lines in TextBox
    .ScrollBars = fmScrollBarsVertical ' Add vertical scroll bars
End With
End Sub
' Function to reconstruct the text into a specified number of paragraphs
Function ReconstructParagraphs(ByVal text As String, ByVal paragraphCount As Integer) As String
    Dim sentences() As String
    Dim finalText As String
    Dim i As Integer
    Dim sentenceCount As Integer
    Dim dummySentence As String

    ' Split text into sentences
    sentences = Split(text, ".") ' Split by periods for sentence segmentation
    sentenceCount = UBound(sentences) + 1 ' Total number of sentences

    ' Set a dummy sentence for padding if necessary
    If sentenceCount > 0 Then
        dummySentence = "This is a placeholder sentence." ' Adjust as needed
    Else
        dummySentence = "No content available."
    End If

    ' Reconstruct into paragraphs
    For i = 0 To paragraphCount - 1
        If i > 0 Then finalText = finalText & vbCrLf & vbCrLf ' Add line break for paragraph separation
        
        Dim j As Integer
        For j = 0 To 2 ' Include a fixed number of sentences per paragraph
            Dim currentSentenceIndex As Integer
            currentSentenceIndex = i * 3 + j
            
            If currentSentenceIndex < sentenceCount Then
                Dim sentence As String
                sentence = Trim(sentences(currentSentenceIndex))
                If Len(sentence) > 0 Then
                    finalText = finalText & sentence & "." ' Append the sentence with a period
                End If
            Else
                finalText = finalText & dummySentence ' Add a dummy sentence
            End If
        Next j
    Next i

    ReconstructParagraphs = Trim(finalText) ' Return the formatted text
End Function





' Helper function to URL-encode the text
Function URLEncode(ByVal text As String) As String
    Dim i As Integer
    Dim Char As String
    Dim result As String
    
    For i = 1 To Len(text)
        Char = Mid(text, i, 1)
        Select Case Asc(Char)
            Case 48 To 57, 65 To 90, 97 To 122 ' Alphanumeric characters
                result = result & Char
            Case 32 ' Space character
                result = result & "+"
            Case Else
                result = result & "%" & Right("0" & Hex(Asc(Char)), 2) ' Ensure two-digit hex
        End Select
    Next i
    
    URLEncode = result
End Function

' Helper function to clean the translated text from artifacts
Function CleanText(ByVal text As String) As String
    text = Replace(text, "\", "") ' Remove backslashes
    text = Replace(text, "%20", " ") ' Replace %20 with space
    text = Replace(text, "%FC", "ü") ' Fix special character (example)
    text = Replace(text, "%E4", "ä") ' Fix special character ä
    text = Replace(text, "%F6", "ö") ' Fix special character ö
    text = Replace(text, "%C4", "Ä") ' Fix special character Ä
    text = Replace(text, "%D6", "Ö") ' Fix special character Ö
    text = Replace(text, "%DC", "Ü") ' Fix special character Ü
    text = Replace(text, "%DF", "ß") ' Fix special character ß
    ' Add more replacements as needed for other common encoding artifacts
    
    CleanText = text
End Function








Private Sub CommandButton13_Click()
    ' Assuming you have a TextBox named TextBox1 on your UserForm
    With Me.TextBox4
        ' Set the text with a line break between the sentences
        .text = "This is the first sentence." & vbCrLf & vbCrLf & _
                 "This is the second sentence."
        .Font.Size = 10 ' Set a larger font size
        .TextAlign = fmTextAlignLeft ' Align text to the left
        .WordWrap = True ' Allow text to wrap to the next line
        .MultiLine = True ' Allow multiple lines in TextBox
        .ScrollBars = fmScrollBarsVertical ' Add vertical scroll bars if needed
    End With
End Sub

Private Sub CommandButton2_Click()
    On Error GoTo ErrorHandler
    ' Reset counter if it's below 60, else exit
    ' Retrieve text from text boxes
    T1 = txt1.text
    T2 = txt2.text
    T3 = txt3.text
    T4 = txt4.text
    T5 = txt5.text
     ' Call the global function to update content controls
      If UpdateContentControls() Then
        'MsgBox "Content controls updated successfully!", vbInformation, "Success"
    End If
  Set doc = ActiveDocument
    ' Loop through paragraphs from the end to the beginning to remove empty paragraphs
    For i = doc.paragraphs.Count To 1 Step -1
    
        If counters(1) < 60 Then
            counters(3) = counters(3) + 1 ' Increment counter
        Else
            Exit Sub ' Exit if counter reaches 60
        End If
        
        DoEvents ' Prevent freezing
        Set para = doc.paragraphs(i)
        
        ' Check if the paragraph is empty
        If Len(Trim(para.Range.text)) = 0 Then
            para.Range.Delete ' Remove empty paragraphs
        End If
    Next i
    ' Now loop through remaining paragraphs to set single line spacing and remove extra spaces
    For Each para In doc.paragraphs
        If counters(2) < 60 Then
            counters(3) = counters(3) + 1 ' Increment counter
        Else
            Exit Sub ' Exit if counter reaches 60
        End If
        
        DoEvents ' Prevent freezing
        ' Set the line spacing to single
        para.LineSpacingRule = wdLineSpaceSingle
        ' Set space before and after the paragraph to 0
        para.SpaceBefore = 0
        para.SpaceAfter = 0
    Next para
    
    ' Optional: Remove any additional line breaks (vbCr) between paragraphs
    For i = doc.paragraphs.Count To 2 Step -1
    
        If counters(3) < 60 Then
            counters(3) = counters(3) + 1 ' Increment counter
        Else
            Exit Sub ' Exit if counter reaches 60
        End If
    
        DoEvents ' Prevent freezing
        Set para = doc.paragraphs(i)
        If para.Range.text = vbCr And para.Previous.Range.text = vbCr Then
            para.Range.Delete ' Remove duplicate line breaks
        End If
    Next i
    
    ' Set the desired font and size
    desiredFontName = "Times New Roman" ' Change this to your preferred font
    desiredFontSize = 10 ' Change this to your preferred font size
    
    ' Loop through each paragraph in the document
    For Each para In ActiveDocument.paragraphs
        DoEvents ' Prevent freezing
        ' Set the font for the paragraph range
        Set rng = para.Range
        rng.Font.Name = desiredFontName
        rng.Font.Size = desiredFontSize
    Next para
    

    Exit Sub
ErrorHandler:
    MsgBox "An error occurred: " & Err.Description

End Sub

Private Sub CommandButton3_Click()
  T1 = txt1.text
    T2 = txt2.text
    T3 = txt3.text
    T4 = txt4.text
    T5 = txt5.text
     ' Call the global function to update content controls
      If UpdateContentControls() Then
        'MsgBox "Content controls updated successfully!", vbInformation, "Success"
    End If
    
    ' Loop through each paragraph in the active document
    For Each para In ActiveDocument.paragraphs

        DoEvents ' Prevent freezing
        ' Check if the paragraph has more than two lines
        If para.Range.ComputeStatistics(wdStatisticLines) > 2 Then
            ' Justify the paragraph
            para.Alignment = wdAlignParagraphJustify
        End If
    Next para

End Sub

Private Sub CommandButton4_Click()
    Unload Me
End Sub

Private Sub CommandButton5_Click()
  T1 = txt1.text
    T2 = txt2.text
    T3 = txt3.text
    T4 = txt4.text
    T5 = txt5.text
     ' Call the global function to update content controls
      If UpdateContentControls() Then
        'MsgBox "Content controls updated successfully!", vbInformation, "Success"
    End If
    
    ' Loop through each paragraph in the active document
    For Each para In ActiveDocument.paragraphs

        DoEvents ' Prevent freezing
        ' Check if the paragraph has more than two lines
        If para.Range.ComputeStatistics(wdStatisticLines) > 2 Then
            ' Set the paragraph alignment to left (unjustify)
            para.Alignment = wdAlignParagraphLeft
        End If
    Next para
End Sub

Private Sub CommandButton6_Click()
    On Error GoTo ErrorHandler
    Dim fd As FileDialog
    Dim strng As String

    ' Open File Dialog to select a PDF file
    Set fd = Application.FileDialog(msoFileDialogFilePicker)
    fd.Title = "Select PDF File"
    fd.Filters.Clear
    fd.Filters.Add "PDF Files", "*.pdf"
    
    ' Show the dialog and get the file path
    If fd.Show = -1 Then
        strng = fd.SelectedItems(1) ' Get the selected PDF file path
        
        ' Use Shell to open the selected PDF
        Shell "cmd.exe /c start """" """ & strng & """", vbHide
    Else
        MsgBox "No file selected."
    End If
    Exit Sub

ErrorHandler:
    MsgBox "An error occurred: " & Err.Description ' Display error message
End Sub




Private Sub CommandButton8_Click()


    Dim customDateString As String
    customDateString = Format(Date, "dddd, mmmm dd, yyyy")
    ' Get the folder name from a textbox (or you can set it directly)
    folderName = txt5.text & customDateString ' Or hardcode a name like "NewFolder"

    ' Set the full path for the folder to be created inside D:
    folderPath = "C:\Users\mab30ri\University of Wuerzburg Dropbox\Masoud Bahari\5-Job document\-BewerbungBank\" & folderName

    ' Check if the folder already exists
    If Dir(folderPath, vbDirectory) = "" Then
        ' Folder doesn't exist, so create it
        MkDir folderPath
        MsgBox "Folder created successfully: " & folderPath
    Else
        ' Folder already exists
        MsgBox "Folder already exists: " & folderPath
    End If
 
    ' Open the folder in Windows Explorer
    If Dir(folderPath, vbDirectory) <> "" Then
        Shell "explorer.exe """ & folderPath & """", vbNormalFocus
    Else
        MsgBox "Failed to open the folder: " & folderPath, vbCritical
    End If
    
End Sub
Private Sub CommandButton1_Click()
    ppth = folderPath & "\Bahari_Anschreiben_" & txt5.text
    ActiveDocument.ExportAsFixedFormat OutputFileName:=ppth, ExportFormat:=wdExportFormatPDF
        ' Optional: Confirmation message
    MsgBox "Content controls replaced successfully!", vbInformation, "Success"
    ' Clear the text boxes after submission (optional)
    txt1.text = ""
    txt2.text = ""
    txt3.text = ""
    txt4.text = ""
    txt5.text = ""
    MsgBox "Rich text content controls updated and highlighted successfully. Document re-protected and saved as PDF."
End Sub

Private Sub CommandButton11_Click()
    Dim pdfList As String
    Dim pdfCV As String, pdfArbeit As String, pdfAnschreiben As String, pdfMaster As String, pdfBachelor As String
    Dim FinalMerged As String
    Dim pdftkPath As String
    Dim command As String
    
    ' Paths to individual PDF files (set these according to your files)
    pdfAnschreiben = ppth & ".pdf"
    pdfCV = "C:\Users\mab30ri\University of Wuerzburg Dropbox\Masoud Bahari\5-Job document\-BewerbungBank\1_Bahari_Lebenslauf.pdf"
    pdfArbeit = "C:\Users\mab30ri\University of Wuerzburg Dropbox\Masoud Bahari\5-Job document\-BewerbungBank\2_Arbeitszeugnis_MBahari_JMU_Wuerzburg.pdf"
    pdfMaster = "C:\Users\mab30ri\University of Wuerzburg Dropbox\Masoud Bahari\5-Job document\-BewerbungBank\4_Master_Degree_Transcript.pdf"
    pdfBachelor = "C:\Users\mab30ri\University of Wuerzburg Dropbox\Masoud Bahari\5-Job document\-BewerbungBank\3_Bachelor_Degree_Transcript.pdf"

    ' Initialize pdfList as an empty string
    pdfList = ""
    
    ' Check which option buttons are selected and add relevant PDFs to the list
    If CheckBox1.Value = True Then
        pdfList = pdfList & " """ & pdfCV & """"
    End If
    
    If CheckBox2.Value = True Then
        pdfList = pdfList & " """ & pdfAnschreiben & """"
    End If
    
    If CheckBox3.Value = True Then
        pdfList = pdfList & " """ & pdfArbeit & """"
    End If
    
    If CheckBox4.Value = True Then
        pdfList = pdfList & " """ & pdfMaster & """"
    End If
    
    If CheckBox5.Value = True Then
        pdfList = pdfList & " """ & pdfBachelor & """"
    End If
    
    
    ' If no options are selected, exit the macro
    If pdfList = "" Then
        MsgBox "Please select at least one document."
        Exit Sub
    End If
    
    ' Set the path for the merged PDF output
    FinalMerged = folderPath & "\Bahari_Bewerbung.pdf"
    
    ' Path to PDFtk executable
    pdftkPath = "C:\Program Files (x86)\PDFtk\bin\pdftk.exe"
    
    ' Create the command to merge the selected PDFs
    command = """" & pdftkPath & """" & pdfList & " cat output """ & FinalMerged & """"
    
    ' Execute the command
    Shell command, vbNormalFocus
    
    ' Notify the user
    MsgBox "Selected PDFs have been merged successfully!"
End Sub

Private Sub CommandButton9_Click()
    Dim pdfPath As String
    Dim startPage As Long
    Dim endPage As Long
    Dim totalPages As Long

    ' Set the page range
    startPage = 1
    endPage = 2

    ' Check if the page range is valid
    totalPages = ActiveDocument.ComputeStatistics(wdStatisticPages)
    If startPage < 1 Or endPage > totalPages Then
        MsgBox "Invalid page range."
        Exit Sub
    End If

    ' Set the output path for the PDF
    pdfPath = "D:\SelectedPages_2_3.pdf" ' Specify your path here

    ' Export the specified page range to PDF
    ActiveDocument.ExportAsFixedFormat _
        OutputFileName:=pdfPath, _
        ExportFormat:=wdExportFormatPDF, _
        OpenAfterExport:=True, _
        OptimizeFor:=wdExportOptimizeForPrint, _
        Range:=wdExportFromTo, _
        From:=startPage, _
        To:=endPage

    MsgBox "PDF with selected pages has been exported successfully!"
End Sub


Private Sub ToggleButton_Click()
    ' Toggle button state and update caption and label
    If ToggleButton.Value = True Then
        ToggleButton.Caption = "ON"
        Label9.Caption = "Current State: ON"
    Else
        ToggleButton.Caption = "OFF"
        Label9.Caption = "Current State: OFF"
    End If
End Sub
Private Sub btnExecute_Click()
    On Error GoTo ExportError ' Set up error handling
    Dim startPage As Long
    Dim endPage As Long
    Dim pdfPathh As String

    ' Set the output path directly to D drive
    pdfPathh = "D:\Bahari_Anschreiben_" & TextBox1.text & TextBox2.text & ".pdf" ' Customize as needed

    ' Check if the toggle button is active
    If ToggleButton.Value = True Then
        ' Get user input for page range
        startPage = Val(TextBox1.text)
        endPage = Val(TextBox2.text)

        ' Validate page range
        If startPage < 1 Or endPage < startPage Then
            MsgBox "Please enter a valid page range."
            Exit Sub
        End If
        
        ' Ensure the active document is valid
        If ActiveDocument Is Nothing Then
            MsgBox "No active document found."
            Exit Sub
        End If
        
        ' Check if the document contains enough pages
        Dim totalPages As Long
        totalPages = ActiveDocument.ComputeStatistics(wdStatisticPages)
        If endPage > totalPages Then
            MsgBox "The document does not contain that many pages."
            Exit Sub
        End If

        ' Debugging: Check the current document's total pages
        Debug.Print "Total Pages in Document: " & totalPages

        ' Export the specified page range to PDF
        ActiveDocument.ExportAsFixedFormat _
            OutputFileName:=pdfPathh, _
            ExportFormat:=wdExportFormatPDF, _
            OpenAfterExport:=True, _
            Range:=wdExportPageRange, _
            From:=startPage, _
            To:=endPage

        MsgBox "PDF exported successfully to " & pdfPathh
        
        ' Clear the text boxes
        TextBox1.text = ""
        TextBox2.text = ""
    End If

    Exit Sub

ExportError:
    MsgBox "Error during PDF export: " & Err.Description
End Sub



