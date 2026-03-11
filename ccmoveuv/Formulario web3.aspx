<%@ Page Title="" Language="vb" AutoEventWireup="false" Async="true" MasterPageFile="~/Site1.Master" CodeBehind="Formulario web3.aspx.vb" Inherits="ccmoveuv.Formulario_web3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid" style="font-size: small">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="row">

            <div class="col-2 text-center">
                <label class="form-label" for="txtGranel"><b>CODIGO GRANEL</b></label>
            </div>
            <div class="col-4 text-center">
                <label class="form-label" for="txtNomPro"><b>NOMBRE PRODUCTO</b></label>
            </div>
            <div class="col-4 text-center">
                <label class="form-label" for="txtForFar"><b>FORMA FARMACEUTICA</b></label>
            </div>
            <div class="col-2 text-center">
                <label class="form-label"><b>FECHA</b></label>
            </div>

        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row mt-0 text-center">

                    <div class="col-2">
                        <asp:TextBox runat="server" ID="txtCodGranel" TextMode="Number" CssClass="form-control-sm w-75 " placeholder="Buscar # granel" /><asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/search-black.svg" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCodGranel" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="guardar"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtCodGranel" Type="Integer" MinimumValue="0" MaximumValue="2000000" ErrorMessage="Números enteros a partir del 0" Display="Dynamic" ForeColor="Red"></asp:RangeValidator>
                    </div>
                    <div class="col-4">
                        <asp:TextBox ID="txtNomProd" runat="server" CssClass="form-control-sm w-75 text-uppercase" TextMode="Search" placeholder="Buscar nombre producto" /><asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/search-black.svg" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtNomProd" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="guardar"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-4">
                        <asp:Literal runat="server" ID="litForFar" />
                    </div>
                    <div class="col-2">
                        <asp:TextBox runat="server" ID="txtFecha" TextMode="Date" CssClass="form-control" AutoPostBack="true" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFecha" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="guardar"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="codigoGranel" OnRowCommand="GridView1_RowCommand" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                        <Columns>
                            <asp:BoundField DataField="codigoGranel" HeaderText="CODIGO GRANEL" />
                            <asp:BoundField DataField="nombreProducto" HeaderText="NOMBRE PRODUCTO" />
                            <asp:BoundField DataField="nombreFormaFarmaceutica" HeaderText="FORMA FARMACEUTICA" />
                            <asp:BoundField DataField="cantidadLoteGranel" HeaderText="CANTIDAD LOT. A GRANEL" />
                            <asp:TemplateField HeaderText="SELECCIONAR">
                                <ItemTemplate>
                                    <asp:Button ID="btnSeleccionar" runat="server" Text="Seleccionar"
                                        CommandName="Seleccionar" CommandArgument='<%# Container.DataItemIndex %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <SortedAscendingCellStyle BackColor="#F4F4FD" />
                        <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                        <SortedDescendingCellStyle BackColor="#D8D8F0" />
                        <SortedDescendingHeaderStyle BackColor="#3E3277" />
                    </asp:GridView>
                </div>


                <div class="row mt-1">
                    <div class="col-2 text-center">
                        <label class="form-label"><b>CONCENTRACION</b></label>
                    </div>
                    <div class="col-3 text-center">
                        <label class="form-label"><b>VIA ADMINISTRACIÓN</b></label>
                    </div>
                    <div class="col-3 text-center">
                        <label class="form-label"><b>CONSIDERACIONES DE USO DEL PRODUCTO</b></label>
                    </div>
                    <div class="col-4 text-center">
                        <label class="form-label"><b>JUSTIFICACIÓN DE LA FORMA FARMACEÚTICA</b></label>
                    </div>
                </div>
                <div class="row mt-0">
                    <div class="col-2">
                        <asp:TextBox runat="server" ID="txtConcentracion" TextMode="Number" CssClass="form-control" placeholder="Digite concentracion" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtConcentracion" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="guardar"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-3">
                        <asp:TextBox runat="server" ID="txtViaAdmon" TextMode="SingleLine" CssClass="form-control" placeholder="Digite via admon." />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtViaAdmon" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="guardar"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-3">
                        <asp:TextBox runat="server" ID="txtConUsoPro" TextMode="SingleLine" CssClass="form-control" placeholder="Digite consideraciones uso producto." />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtConUsoPro" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="guardar"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-4">
                        <asp:TextBox runat="server" ID="txtJusForFar" TextMode="SingleLine" CssClass="form-control" placeholder="Digite justifica" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtJusForFar" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="guardar"></asp:RequiredFieldValidator>
                    </div>
                </div>


                <div class="row mt-1">
                    <div class="col-2 text-center">
                        <label class="form-label"><b>POSOLOGÍA</b></label>
                    </div>
                    <div class="col-2 text-center">
                        <label class="form-label"><b>TAMAÑO DE LOTE A GRANEL</b></label>
                    </div>
                    <div class="col-5 text-center">
                        <label class="form-label"><b>CODIGOS PRODUCTO TERMINADO</b></label>
                    </div>
                    <div class="col-3 text-center">
                        <label class="form-label"><b>TAMAÑO LOTE PRODUCTO TERMINADO</b></label>
                    </div>
                    <%--<div class="col-2 text-center">
                <label class="form-label"><b>FECHA HISTORICOS</b></label>
            </div>
            <div class="col-3 text-center">
                <label class="form-label"><b>TÉCNICAS ANÁLITICAS</b></label>
            </div>
            <div class="col-3">
            </div>--%>
                    <%-- <div class="col-10 text-center">
                <label class="form-label"><b>RELACIÓN PCP-ACC</b></label>
            </div>
            <div class="col-2 text-center">
                <label class="form-label"><b>RESULTADOS</b></label>
            </div>
            <div class="col-12 text-center">
                <label class="form-label"><b>TRATAMIENTO ESTADÍSTICO</b></label>
            </div>--%>
                </div>
                <div class="row mt-0">
                    <div class="col-2">
                        <asp:TextBox runat="server" ID="txtPosologia" TextMode="SingleLine" CssClass="form-control" placeholder="Digite posología." />
                    </div>
                    <div class="col-2">
                        <asp:Literal runat="server" ID="litTamLotGra" />
                    </div>
                    <div class="col-5">
                        <asp:GridView ID="GridView2" runat="server"  AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="codigo" HeaderText="CODIGO" />
                                <asp:BoundField DataField="nombre" HeaderText="NOMBRE PRODUCTO" />
                                <asp:BoundField DataField="presentacion" HeaderText="PRESENTACIÓN" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </div>
                    <div class="col-3">
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False"  BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="codigo" HeaderText="CODIGO" />
                                <asp:BoundField DataField="nombre" HeaderText="NOMBRE PRODUCTO" />
                                <asp:BoundField DataField="cantidad" HeaderText="CANTIDAD LOTE" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-5 text-center">
                        <label class="form-label"><b>PRESENTACIÓN</b></label>
                    </div>
                    <div class="col-3 text-center">
                        <label class="form-label"><b>ESTUDIOS ESTABILIDAD</b></label>
                    </div>
                    <div class="col-4 text-center">
                        <label class="form-label"><b>VIDA UTIL</b></label>
                    </div>
                </div>
                <div class="row mt-0">
                    <div class="col-5">
                        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="codigo" HeaderText="CODIGO DEL MATERIAL" />
                                <asp:BoundField DataField="nombre" HeaderText="NOMBRE" />
                                <asp:BoundField DataField="codigoEspecificacion" HeaderText="CODIGO ESPECIFICACIÓN" />
                                <asp:BoundField DataField="nombreEspecificacion" HeaderText="NOMBRE ESPECIFICACIÓN" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </div>
                    <div class="col-3">
                        <asp:GridView ID="GridView7" runat="server"  AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="presentacion" HeaderText="PRESENTACIÓN" />
                                <asp:BoundField DataField="fechaIngreso" DataFormatString="{0:dd/MM/yyyy}" HeaderText="FECHA DE INGRESO" />
                                <asp:BoundField DataField="lote" HeaderText="LOTE" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </div>
                    <div class="col-4">
                        <asp:GridView ID="GridView8" runat="server"  AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="codigo" HeaderText="CODIGO" />
                                <asp:BoundField DataField="nombreProducto" HeaderText="NOMBRE PRODUCTO" />
                                <asp:BoundField DataField="vidaUtil" DataFormatString="{0:dd/MM/yy}" HeaderText="VIDA UTIL" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-3 text-center">
                        <label class="form-label"><b>RUTA GRANEL</b></label>
                    </div>
                    <div class="col-3 text-center">
                        <label class="form-label"><b>RUTA TERMINADO</b></label>
                    </div>
                    <div class="col-6 text-center">
                        <label class="form-label"><b>HISTÓRICO DE LOTES</b></label>
                    </div>
                </div>
                <div class="row mt-0">
                    <div class="col-3">
                        <asp:GridView ID="GridView5" runat="server"  AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="nombre" HeaderText="NOMBRE DEL EQUIPO" />
                                <asp:BoundField DataField="codigo" HeaderText="CODIGO DEL EQUIPO" />
                                <asp:BoundField DataField="etapa" HeaderText="ETAPA DEL PROCESO" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </div>
                    <div class="col-3">
                        <asp:GridView ID="GridView6" runat="server"  AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="nombre" HeaderText="NOMBRE DEL EQUIPO" />
                                <asp:BoundField DataField="codigo" HeaderText="CODIGO DEL EQUIPO" />
                                <asp:BoundField DataField="etapa" HeaderText="ETAPA DEL PROCESO" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </div>
                    <div class="col-6">
                        <asp:GridView ID="GridView9" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:BoundField DataField="nroorden" HeaderText="# ORDEN" />
                                <asp:BoundField DataField="lote" HeaderText="LOTE" />
                                <asp:BoundField DataField="cantidad" HeaderText="TAMAÑO DE LOTE" />
                                <asp:BoundField DataField="fechaliq" DataFormatString="{0:dd/MM/yy}" HeaderText="FECHA FABRICACIÓN" />
                                <asp:BoundField DataField="edicion_producto" HeaderText="ED.PRO." />
                                <asp:BoundField DataField="principio_activo" HeaderText="FABRICANTE PRINCIPIO ACTIVO" />
                                <asp:BoundField DataField="rendimiento" HeaderText="% RENDIMIENTO" />
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <SortedAscendingCellStyle BackColor="#F4F4FD" />
                            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                            <SortedDescendingCellStyle BackColor="#D8D8F0" />
                            <SortedDescendingHeaderStyle BackColor="#3E3277" />
                        </asp:GridView>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-5 text-center">
                        <label class="form-label">
                            <b>ENVASE Y EMPAQUE</b>
                    </div>
                    <div class="col-7">
                        <label class="form-label"><b>ATRIBUTOS CRITICOS DE CALIDAD</b></label>
                    </div>
                </div>
                <div class="row mt-0">
    <div class="col-5">
        <asp:GridView ID="GridView10" runat="server"  AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:BoundField DataField="orden" HeaderText="# ORDEN" />
                <asp:BoundField DataField="lote" HeaderText="LOTE" />
                <asp:BoundField DataField="edicion_producto" HeaderText="ED. PRO." />
                <asp:BoundField DataField="rendimiento" HeaderText="% RENDIMIENTO" />
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <SortedAscendingCellStyle BackColor="#F4F4FD" />
            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
            <SortedDescendingCellStyle BackColor="#D8D8F0" />
            <SortedDescendingHeaderStyle BackColor="#3E3277" />
        </asp:GridView>
    </div>
    <div class="col-7">
        <asp:Literal runat="server" ID="litAtrCri" Text="Diligenciar tabla #ANALISIS/LOTE/ATRIBUTOS CRITICOS DE CALIDAD"></asp:Literal>
    </div>
</div>
  
            </ContentTemplate>
        </asp:UpdatePanel>
        
        <div class="row mt-1">
            <div class="col-6 text-center">
                <label class="form-label"><b>AREAS Y EQUIPOS</b></label>
            </div>
            <div class="col-6 text-center"><b>CONDICIONES ACTUALES DE COMERCIALIZACIÓN</b></div>
        </div>
        <div class="row mt-0">
            <div class="col-6">
                <asp:Literal runat="server" ID="litAreEqu" Text="Traer EQUIPO/CODIGO/CALIFICACION/FECHA VIGENCIA"></asp:Literal>
            </div>
            <div class="col-6">
                <asp:Literal runat="server" ID="litConCom" Text="Traer CODIGO PT/NOMBRE/REGISTRO SANITARIO/ESTADO"></asp:Literal>
            </div>
        </div>
        <div class="row mt-1">
            <div class="col-6 text-center">
                <label class="form-label"><b>FORMULA CUALICUANTITATIVA</b></label>
            </div>
            <div class="col-6 text-center">
                <label class="form-label"><b>METODOLOGIA ANALITICA</b></label>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-6">
                <asp:Literal runat="server" ID="litForCuaCua" Text="MATERIA PRIMA/CATEGORIA FUNCIONAL/CANTIDAD/CODIGO ESPECIFICACION/METODO ANALITICO"></asp:Literal>
            </div>
            <div class="col-6">
                <asp:Literal runat="server" ID="litMetAna" Text="Traer METODO ANALITICO/TIPO EVIDENCIA/CODIGO DEL INFORME/ALCANCE"></asp:Literal>
            </div>
        </div>
        <div class="row mt-1">
            <div class="col-6 text-center">
                <label class="form-label"><b>CONDICIONES AMBIENTALES</b></label>
            </div>
            <div class="col-6 text-center">
                <label class="form-label"><b>RELACIÓN PCP-ACC</b></label>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-6">
                <asp:Literal runat="server" ID="litConAmb" Text="TRAER AREA/TEMPERATURA/HUMEDAD RELATIVA/DIFERENCIAL DE PRESION/CLASIFICACION DEL AREA"></asp:Literal>
            </div>
            <div class="col-6">
                <asp:Literal runat="server" ID="litRelPcpAcc" Text="Diligenciar tabla ETAPA/PCP/ACC/JUSTIFICACION"></asp:Literal>
            </div>
        </div>
        <div class="row mt-1">
            <div class="col-4 text-center">
                <label class="form-label"><b>TRATAMIENTO ESTADISTICO</b></label>
            </div>
            <div class="col-4 text-center">
                <label class="form-label"><b>QUEJAS Y RECLAMOS</b></label>
            </div>
            <div class="col-4 text-center">
                <label class="form-label"><b>DESVIACIONES</b></label>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-4">
                <asp:TextBox ID="txtTraEst" runat="server" CssClass="form-control" placeholder="digitar"></asp:TextBox>
            </div>
            <div class="col-4">
                <asp:TextBox runat="server" ID="txtQueRec" CssClass="form-control" placeholder="digitar"></asp:TextBox>
            </div>
            <div class="col-4">
                <asp:TextBox runat="server" ID="txtDes" CssClass="form-control" placeholder="digitar"></asp:TextBox>
            </div>
        </div>
        <div class="row mt-1">
            <div class="col-6 text-center">
                <label class="form-label"><b>ANALISIS DE RESULTADOS</b></label>
            </div>
            <div class="col-6 text-center">
                <label class="form-label"><b>CONCLUSIONES</b></label>
            </div>
            <div class="row mt-0">
                <div class="col-6">
                    <asp:TextBox runat="server" ID="txtAnaRes" CssClass="form-control" placeholder="Digitar"></asp:TextBox>
                </div>
                <div class="col-6">
                    <asp:TextBox runat="server" ID="txtCon" CssClass="form-control" placeholder="Digitar"></asp:TextBox>
                </div>
            </div>
        </div>
        <%--<div class="row mt-0">
                <div class="row mt-0">
        <div class="col-5">
            <table class="table">
                <thead>
                    <tr>
                        <th>ETAPA</th>
                        <th>PCP</th>
                        <th>ACC</th>
                        <th>JUSTIFICACION</th>
                        <th>AGREGAR</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <asp:DropDownList ID="DropDownListEtapa" runat="server" CssClass="dropdown-menu">
                                <asp:ListItem Text="Seleccionar" />
                            </asp:DropDownList></td>
                        <td>
                            <asp:TextBox ID="txtPcp" runat="server" placeholder="digitar pcp" CssClass="form-control-sm"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAcc" runat="server" placeholder="digitar acc" CssClass="form-control-sm"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtJustificacion" runat="server" placeholder="digitar justificación" CssClass="form-control-sm"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="Button2" runat="server" Text="Agregar" /></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="col-2">
            <asp:TextBox runat="server" ID="txtFecHistoricos" TextMode="Date" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtFecHistoricos" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic" ValidationGroup="guardar"></asp:RequiredFieldValidator>
        </div>
        <div class="col-3">
            <table class="table">
                <thead>
                    <tr>
                        <th>Cod</th>
                        <th>Nombre</th>
                        <th>Analisis</th>
                        <th>SELECCIONAR</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>ghjhgdjh</td>
                        <td>lkjlkjlk</td>
                        <td>
                            <asp:Button ID="Button1" runat="server" Text="Seleccionar" /></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="col-3"></div>
    </div>
    <div class="col-5">
    </div>
    <div class="col-2">
        <asp:TextBox ID="txtResultados" runat="server" placeholder="Digite resultados" CssClass="form-control"></asp:TextBox>
    </div>
</div>
            <div class="col-2">
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </div>
            <div class="col-2">
                <asp:Image ID="Image1" runat="server" />
            </div>
            <div class="col-2">
                <asp:Image ID="Image2" runat="server" />
            </div>
            <div class="col-2">
                <asp:Image ID="Image3" runat="server" />
            </div>
            <div class="col-4">
                <asp:TextBox ID="txtAnaResul" runat="server" CssClass="form-control" placeholder="Digite tratamiento estadístico"></asp:TextBox>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-6 text-center">
                <label class="form-label"><b>ANÁLISIS RESULTADOS</b></label>
            </div>
            <div class="col-6 text-center">
                <label class="form-label"><b>CONCLUSIONES</b></label>
            </div>
        </div>
        <div class="row mt-0">
            <div class="col-6">
                <asp:TextBox ID="txtAnaResultados" runat="server" CssClass="form-control" placeholder="Digite análisis resultados"></asp:TextBox>
            </div>
            <div class="col-6">
                <asp:TextBox ID="txtConclusiones" runat="server" CssClass="form-control" placeholder="Digite conclusiones"></asp:TextBox>
            </div>
        </div>--%>
    </div>
</asp:Content>
