Imports System.Data.Odbc
Imports System.Threading.Tasks
Imports System.Web.Services.Description

Public Class Formulario_web3
    Inherits System.Web.UI.Page

    Public objUtili As New Utilidades()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Session("Usuario") Is Nothing Then
                Dim usuario As String = objUtili.Desencriptar(Request.QueryString("Gusuario"))
                Dim codCia As String = objUtili.Desencriptar(Request.QueryString("Codcia"))
                Dim empresa As String = Request.QueryString("Empresa").ToUpper
                Dim cadena As String = If(empresa.Equals("COASPHARMA"), ConfigurationManager.ConnectionStrings("bdsif").ConnectionString, ConfigurationManager.ConnectionStrings("bdprusif").ConnectionString)
                Session("usuario") = usuario
                Session("codCia") = Convert.ToInt32(codCia)
                Session("cadena") = cadena
                If Session("SesionValida") Is Nothing Then
                    'If objUtili.EnlaceExpira(Session("usuario").ToString, Session("Cadena").ToString, "ccmaehtb", HttpContext.Current) = False Then
                    objUtili.VerificarPermisos(Session("cadena").ToString, usuario, "G", HttpContext.Current)

                    Using conn As New OdbcConnection(cadena)
                        conn.Open()
                        Using cmd As New OdbcCommand("SELECT nombre FROM simaeusu WHERE usuario=?", conn)
                            cmd.Parameters.AddWithValue("?", usuario)
                            Using dr As OdbcDataReader = cmd.ExecuteReader()
                                If dr.Read() Then
                                    Dim cargo As String = dr("nombre").ToString()
                                    Session("cargo") = cargo
                                Else
                                    Context.Response.Redirect("SinPermiso.aspx?Gusuario=" & Context.Request.QueryString("Gusuario") & "&Codcia=" & Context.Request.QueryString("Codcia") & "&Empresa=" & Context.Request.QueryString("Empresa"))
                                End If
                            End Using
                        End Using
                    End Using
                    Session("SesionValida") = True
                    'Else
                    ' Context.Response.Redirect("HtmlPage1.html?Gusuario=" & Context.Request.QueryString("Gusuario") & "&Codcia=" & Context.Request.QueryString("Codcia") & "&Empresa=" & Context.Request.QueryString("Empresa"), True)
                    'End If
                End If
            End If
        End If
    End Sub

    'Protected Async Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    '    If IsPostBack Then Return

    '    If Session("Usuario") IsNot Nothing Then Return
    '    InicializarSession()
    '    Await ValidarSesionAsync()
    'End Sub

    'Private Sub InicializarSession()
    '    Dim empresa As String = Request.QueryString("Empresa").ToUpper()
    '    Dim cadena As String = If(empresa = "COASPHARMA",
    '        ConfigurationManager.ConnectionStrings("bdsif").ConnectionString,
    '        ConfigurationManager.ConnectionStrings("bdprusif").ConnectionString)
    '    Session("usuario") = objUtilidades.Desencriptar(Request.QueryString("Gusuario"))
    '    Session("codCia") = objUtilidades.Desencriptar(Request.QueryString("Codcia"))
    '    Session("cadena") = cadena
    'End Sub

    'Private Async Function ValidarSesionAsync() As Task(Of Boolean)

    '    If Session("SesionValida") IsNot Nothing Then
    '        Return True
    '    End If

    '    Dim expira As Boolean =
    '    Await objUtilidades.EnlaceExpiraAsync(
    '        Session("usuario").ToString(),
    '        Session("cadena").ToString(),
    '        "ccmoveuv",
    '        HttpContext.Current
    '    )

    '    If expira Then
    '        Return False
    '    End If

    '    Await objUtilidades.VerificarPermisosAsync(
    '    Session("cadena").ToString(),
    '    Session("usuario").ToString(),
    '    "G",
    '    HttpContext.Current
    ')

    '    Dim cargo As String =
    '    Await objUtilidades.ObtenerCargoAsync(
    '        Session("cadena").ToString(),
    '        Session("usuario").ToString()
    '    )

    '    Session("cargo") = cargo
    '    Session("SesionValida") = True
    '    Return True
    'End Function

    Private Sub BuscarNombreGranel()
        Try
            Dim cmd As OdbcCommand
            Using conn As New OdbcConnection(Session("cadena"))
                conn.Open()
                If Not String.IsNullOrEmpty(txtCodGranel.Text) Then
                    cmd = New OdbcCommand("SELECT a.codprod AS codigoGranel, a.nomprod AS nombreProducto, b.nomtipo AS nombreFormaFarmaceutica, c.canlotea AS cantidadLoteGranel
                                      , d.nompres AS nombrePresentacion
                                        FROM inmaepro as a
                                      INNER JOIN pdmaefrf as b ON a.codforma = b.codtipo
                                      INNER JOIN dtmaelot as c ON a.codprod = c.codprod
                                      INNER JOIN ptmaepre as d ON a.codpres = d.codpres
                                      WHERE CAST(a.codprod AS TEXT) LIKE ? AND a.claseinv=5 ORDER BY a.codprod ASC;", conn)
                    cmd.Parameters.AddWithValue("?", "%" & CInt(txtCodGranel.Text) & "%")
                Else
                    cmd = New OdbcCommand("SELECT a.codprod AS codigoGranel, a.nomprod AS nombreProducto, b.nomtipo AS nombreFormaFarmaceutica, c.cantlote AS cantidadLoteGranel
                                      FROM inmaepro as a
                                      , d.nompres AS nombrePresentacion
                                      INNER JOIN pdmaefrf as b ON a.codforma = b.codtipo
                                      INNER JOIN dtmaefor as c ON a.codprod = c.codprod
                                      INNER JOIN ptmaepre as d ON a.codpres = d.codpres
                                      WHERE nomprod LIKE ? AND a.claseinv=5 ORDER BY a.codprod ASC;", conn)
                    cmd.Parameters.AddWithValue("?", "%" & txtNomProd.Text.ToUpper & "%")

                End If
                Using dr As OdbcDataReader = cmd.ExecuteReader()
                    Dim dt As New DataTable()
                    dt.Load(dr)
                    If dt.Rows.Count > 0 Then
                        GridView1.DataSource = dt
                        GridView1.DataBind()
                        GridView1.Focus()
                    Else
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowInfo", $"alert('Codigo de producto no es granel');", True)
                        txtCodGranel.Text = String.Empty
                        txtCodGranel.Focus()
                    End If
                End Using
            End Using
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowInfo", $"alert('{HttpUtility.JavaScriptStringEncode("Error buscando información 1: " & ex.Message)}');", True)
        End Try
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        If Not String.IsNullOrEmpty(txtCodGranel.Text) Then
            BuscarNombreGranel()
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowInfo", $"alert('Por favor ingrese un código de granel');", True)
            txtCodGranel.Focus()
        End If
    End Sub

    Protected Sub ImageButton2_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton2.Click
        If Not String.IsNullOrEmpty(txtNomProd.Text) Then
            BuscarNombreGranel()
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowInfo", $"alert('Por favor ingrese un nombre de producto');", True)
            txtNomProd.Focus()
        End If
    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Seleccionar" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = GridView1.Rows(index)
            Dim codGranel As Integer = CInt(GridView1.DataKeys(index).Value)
            txtCodGranel.Text = codGranel.ToString.Trim
            txtNomProd.Text = HttpUtility.HtmlDecode(row.Cells(1).Text).Trim
            litForFar.Text = HttpUtility.HtmlDecode(row.Cells(2).Text).Trim
            litTamLotGra.Text = HttpUtility.HtmlDecode(row.Cells(3).Text).Trim
            LLenarGridview(codGranel)
            GridView1.DataSource = Nothing
            GridView1.DataBind()
            txtFecha.Focus()
        End If
    End Sub

    Protected Sub MostrarInformacion(sentencia As String, parametro As Object, numeroGridView As GridView, conn As OdbcConnection)
        Using cmd As New OdbcCommand(sentencia, conn)
            cmd.Parameters.AddWithValue("?", parametro)
            Using dr As OdbcDataReader = cmd.ExecuteReader()
                Dim dt As New DataTable()
                dt.Load(dr)
                If dt.Rows.Count > 0 Then
                    numeroGridView.DataSource = dt
                    numeroGridView.DataBind()
                End If
            End Using
        End Using
    End Sub

    Protected Sub LLenarGridview(parametro As Object)
        Try
            Using conn As New OdbcConnection(Session("cadena"))
                conn.Open()
                MostrarInformacion("SELECT a.codgeme AS codigo,b.nomprod AS nombre,c.nompres AS presentacion
                                    FROM pdmaegem a,inmaepro b, ptmaepre c
                                    WHERE a.codprod = ?
                                    AND a.codgeme = b.codprod
                                    AND b.codpres=c.codpres
                                    AND b.estado in (0,1) ORDER BY codigo ASC;", parametro, GridView2, conn)
                MostrarInformacion("SELECT a.codgeme AS codigo,c.nomprod AS nombre,canlotea AS cantidad
                                    FROM pdmaegem a,inmaepro b,inmaepro c,dtmaelot d
                                    WHERE a.codprod = ?
                                    AND a.codprod = b.codprod
                                    AND a.codgeme = c.codprod AND c.estado in (0,1)
                                    AND a.codgeme = d.codprod AND d.codprove = 1000 ORDER BY codigo ASC;", parametro, GridView3, conn)
                Presentacion(parametro, conn)
                MostrarInformacion("SELECT DISTINCT b.codmaq AS codigo,b.nommaq AS nombre,c.nomopera AS etapa
                                    FROM pdmaerut a,mamaemaq b, pdmaeope c
                                    WHERE a.codmaq=b.codmaq AND a.codopera=c.codopera AND a.codprod =? ORDER BY codigo ASC;", parametro, GridView5, conn)
                MostrarInformacion("SELECT DISTINCT b.codmaq AS codigo,b.nommaq AS nombre,c.nomopera AS etapa
                                    FROM pdmaerut a,mamaemaq b, pdmaeope c, pdmaegem d, inmaepro e
                                    WHERE a.codmaq=b.codmaq AND a.codopera=c.codopera AND d.codprod = e.codprod AND d.codgeme = e.codprod and e.estado in (0,1)  AND a.codprod=? ORDER BY codigo ASC;", parametro, GridView6, conn)
                MostrarInformacion("SELECT b.nompres AS presentacion,a.sta_fing AS fechaIngreso,a.sta_lote AS lote
                                    FROM ccmovsta a,ptmaepre b
                                    WHERE codprod = ?
                                    AND a.codpres = b.codpres ORDER BY lote;", parametro, GridView7, conn)
                MostrarInformacion("SELECT pdmaegem.codgeme AS codigo,inmaepro.nomprod AS nombreProducto,fecregi AS vidaUtil
                                    FROM inmaepro,ptmaepre,pdmaegem
                                    LEFT JOIN dtmaevut ON pdmaegem.codgeme = dtmaevut.codprod
                                    LEFT JOIN dtmaereg ON pdmaegem.codcia = dtmaereg.codcia AND pdmaegem.codgeme = dtmaereg.codprod
                                    LEFT JOIN dtmaeesr ON dtmaereg.estregi = dtmaeesr.codesta
                                    WHERE pdmaegem.codcia  = inmaepro.codcia AND pdmaegem.codgeme = inmaepro.codprod
                                    AND inmaepro.codpres = ptmaepre.codpres AND pdmaegem.codcia  = 1
                                    AND pdmaegem.codprod = ?
                                    ORDER BY pdmaegem.codgeme; ", parametro, GridView8, conn)
            End Using
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowInfo", $"alert('{HttpUtility.JavaScriptStringEncode($"Error mostrando información: " & ex.Message)}');", True)
        End Try

    End Sub

    Protected Sub Presentacion(codProd As Integer, conn As OdbcConnection)
        Try
            Dim cmd As New OdbcCommand("WITH ult AS (SELECT c.codprodm, MAX(c.edicion) AS edicion_max FROM ccdetemp c GROUP BY c.codprodm)
                                            SELECT a.codprodm AS codigo,b.nomprod AS nombre,c.codana AS codigoEspecificacion,n.nomana AS nombreEspecificacion
                                            FROM ccmaeamp n,dtmaefor a JOIN inmaepro b ON b.codprod = a.codprodm
                                            JOIN ult u ON u.codprodm = a.codprodm
                                            JOIN ccdetemp c ON c.codprodm = u.codprodm AND c.edicion  = u.edicion_max
                                            WHERE a.codprod = ?
                                            and c.codana = n.codana;", conn)
            cmd.Parameters.AddWithValue("?", codProd)
            Using dr As OdbcDataReader = cmd.ExecuteReader()
                Dim dt As New DataTable()
                dt.Load(dr)
                If dt.Rows.Count > 0 Then
                    GridView4.DataSource = dt
                    GridView4.DataBind()
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowInfo", $"alert('No se encontraron presentaciones de productos con el código proporcionado');", True)
                End If
            End Using
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowInfo", $"alert('{HttpUtility.JavaScriptStringEncode("Error buscando presentación: " & ex.Message)}');", True)
        End Try
    End Sub

    Protected Sub LLenarGridViewXFecha()
        Try
            Using conn As New OdbcConnection(Session("cadena"))
                conn.Open()
                MostrarInformacion("SELECT a.codprod,a.nroorden,a.lote,a.cantidad,a.fechaliq,
                                        COALESCE((SELECT p.pfe_edic FROM pdmaepfe AS p WHERE p.codprod = a.codprod ORDER BY p.pfe_edic DESC LIMIT 1),
                                        (SELECT r.numpos FROM pdmaeprc AS r WHERE r.codprod = a.codprod ORDER BY r.numpos DESC LIMIT 1)) AS edicion_producto,
                                        a.codprove,b.pvd_noco,m.codprod  AS cod_activo,m.nomprod  AS principio_activo,ren.porcenre AS rendimiento
                                        FROM plmaeorf AS a
                                        JOIN po_prove AS b ON a.codcia = b.emp_codi AND a.codprove = b.codprove
                                        JOIN dtmaefor AS f ON f.codprod = a.codprod
                                        JOIN inmaepro AS m ON m.codprod = f.codprodm AND m.claseinv = 1 AND m.codgrup  = 1
                                        JOIN pdmaeren AS ren ON ren.codprod  = a.codprod  AND ren.nroorden = a.nroorden
                                        WHERE a.fecemis >=? AND NULLIF(TRIM(m.nomprod), '') IS NOT NULL
                                        ORDER BY a.codprod, a.nroorden;", txtFecha.Text, GridView9, conn)
                MostrarInformacion("SELECT a.nroorden AS orden,a.lote AS lote,
                                        COALESCE((SELECT p.pfe_edic FROM pdmaepfe AS p WHERE p.codprod = a.codprod ORDER BY p.pfe_edic DESC LIMIT 1),
                                        (SELECT r.numpos FROM pdmaeprc AS r WHERE r.codprod = a.codprod ORDER BY r.numpos DESC LIMIT 1)) AS edicion_producto,
                                        a.codprove,b.pvd_noco,ren.porcenre AS rendimiento
                                        FROM plmaeore AS a
                                        JOIN po_prove AS b ON a.codcia = b.emp_codi AND a.codprove = b.codprove
                                        JOIN pdmaeren AS ren ON ren.codprod  = a.codprod  AND ren.nroorden = a.nroorden
                                        WHERE a.fecemis >= ?
                                        ORDER BY a.codprod, a.nroorden;", txtFecha.Text, GridView10, conn)

            End Using
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowInfo", $"alert('{HttpUtility.JavaScriptStringEncode($"Error mostrando información por fecha: " & ex.Message)}');", True)
        End Try

    End Sub

    Protected Sub txtFecha_TextChanged(sender As Object, e As EventArgs) Handles txtFecha.TextChanged
        LLenarGridViewXFecha()
        txtConcentracion.Focus()
    End Sub

End Class