Imports System.Data.Odbc
Imports System.Security.Cryptography

Public Class Utilidades

    Public Function Desencriptar(ByVal usuario As String) As String
        Dim IV() As Byte = ASCIIEncoding.ASCII.GetBytes("qualityi")
        Dim EncryptionKey() As Byte = Convert.FromBase64String("rpaSPvIvVLlrcmtzPU9/c67Gkj7yL1S5")
        usuario = usuario.Trim()
        usuario = usuario.Replace(" ", "+")
        usuario = usuario.Replace("%20", "+")
        usuario = usuario.Replace("%2B", "+")
        usuario = usuario.Replace("%3D", "=")
        While (usuario.Length Mod 4) <> 0
            usuario &= "="
        End While
        Dim buffer() As Byte = Convert.FromBase64String(usuario.Trim)
        Using des As New TripleDESCryptoServiceProvider With {
            .Key = EncryptionKey,
            .IV = IV
        }
            Return Encoding.UTF8.GetString(des.CreateDecryptor().TransformFinalBlock(buffer, 0, buffer.Length()))
        End Using
    End Function

    Public Function ObtenerHoraMaxima(
    cadena As String,
    usuario As String,
    programa As String
) As TimeSpan?
        Using conn As New OdbcConnection(cadena)
            conn.Open()
            Using cmd As New OdbcCommand("
            SELECT MAX(hora) AS maxHora
            FROM siaudpro
            WHERE audusua = ?
              AND programa = ?
              AND audfech = ?", conn)
                cmd.Parameters.AddWithValue("?", usuario)
                cmd.Parameters.AddWithValue("?", programa)
                cmd.Parameters.AddWithValue("?", DateTime.Today)

                Using dr As OdbcDataReader = cmd.ExecuteReader()
                    If dr.Read() AndAlso Not Convert.IsDBNull(dr("maxHora")) Then
                        Return TimeSpan.Parse(dr("maxHora").ToString())
                    End If
                End Using
            End Using
        End Using
        Return Nothing
    End Function

    Public Function EstaExpirado(horaBase As TimeSpan?) As Boolean

        If Not horaBase.HasValue Then
            Return True
        End If

        Dim horaExpira = horaBase.Value.Add(TimeSpan.FromMinutes(1))
        Dim horaActual = DateTime.Now.TimeOfDay

        Return horaActual > horaExpira
    End Function

    Public Sub Redirigir(
    context As HttpContext,
    paginaDestino As String)

        Dim url As String =
        paginaDestino &
        "?Gusuario=" & HttpUtility.HtmlEncode(context.Request.QueryString("Gusuario")) &
        "&Codcia=" & HttpUtility.HtmlEncode(context.Request.QueryString("Codcia")) &
        "&Empresa=" & context.Request.QueryString("Empresa")

        context.Response.Redirect(url, False)
    End Sub

    Public Sub EnlaceExpira(
    usuario As String,
    cadena As String,
    programa As String,
    context As HttpContext)
        Try
            Dim horaMaxima = ObtenerHoraMaxima(cadena, usuario, programa)
            If EstaExpirado(horaMaxima) Then
                Redirigir(context, "HtmlPage1.html")
            End If
        Catch ex As Exception
            context.Response.Write("Error: " & ex.Message)
        End Try
    End Sub

    Public Function TienePermiso(
    cadena As String,
    usuario As String,
    programa As String,
    permiso As Char
) As Boolean

        Using conn As New OdbcConnection(cadena)
            conn.Open()

            Using cmd As New OdbcCommand("
            SELECT 1
            FROM simaeppu
            WHERE usuario = ?
              AND programa = ?
              AND permiso = ?", conn)

                cmd.Parameters.AddWithValue("?", usuario)
                cmd.Parameters.AddWithValue("?", programa)
                cmd.Parameters.AddWithValue("?", permiso)

                Using dr As OdbcDataReader = cmd.ExecuteReader()
                    Return dr.Read()
                End Using
            End Using
        End Using

    End Function

    Public Sub VerificarPermisos(
    cadena As String,
    usuario As String,
    permiso As Char,
    context As HttpContext)

        Try
            Dim programa As String = "pdmovrtp"

            If Not TienePermiso(cadena, usuario, programa, permiso) Then
                Redirigir(context, "Formulario web2.aspx")
            End If
        Catch ex As Exception
            context.Response.Write("Error: " & ex.Message)
        End Try

    End Sub

    Public Function ObtenerNombreEmpresa(
    cadena As String,
    codCia As Integer
) As String

        Using c As New OdbcConnection(cadena)
            c.Open()

            Using cmd As New OdbcCommand(
                "SELECT emp_nomb FROM gn_empre WHERE emp_codi = ?", c)

                cmd.Parameters.AddWithValue("?", codCia)

                Using dr As OdbcDataReader = cmd.ExecuteReader()
                    If dr.Read() Then
                        Return dr("emp_nomb").ToString()
                    End If
                End Using
            End Using
        End Using

        Return Nothing
    End Function

End Class