Public Class Site1
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Session("usuario") Is Nothing OrElse Session("cadena") Is Nothing Then
        '    Response.Redirect("HtmlPage1.html", False)
        '    Return
        'End If

        'If Not IsPostBack Then
        '    Dim utilidades As New Utilidades()
        '    Literal1.Text = Session("usuario").ToString()
        '    Literal2.Text = Session("cargo").ToString()

        '    Dim nombreEmpresa As String =
        '        utilidades.ObtenerNombreEmpresa(
        '            Session("cadena").ToString(),
        '            CInt(Session("codCia"))
        '        )

        '    If String.IsNullOrEmpty(nombreEmpresa) Then
        '        spanEmpresa.InnerHtml = "Empresa: No especificada"
        '    Else
        '        spanEmpresa.InnerHtml = "Empresa: " & nombreEmpresa
        '    End If
        'End If

    End Sub

End Class